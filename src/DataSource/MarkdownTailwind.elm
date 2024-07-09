module DataSource.MarkdownTailwind exposing (..)

import BackendTask
import BackendTask.File
import BackendTask.Glob as Glob
import BackendTask.Helpers exposing (BTask)
import DataSource.Meta exposing (Meta)
import Date exposing (Date)
import Html.Styled as Html exposing (Html, text)
import Json.Decode as D
import Json.Decode.Pipeline exposing (hardcoded, required)
import List.Extra as List
import Markdown.Block exposing (Block)
import Markdown.Footnotes
import Markdown.Parser
import Markdown.Renderer
import Parser
import Route
import Theme.Markdown
import Time exposing (Month(..))
import Types


decodeMeta : List String -> D.Decoder Meta
decodeMeta splat =
    D.succeed Meta
        |> required "title" D.string
        |> required "description" D.string
        |> required "rss" D.bool
        |> required "date" (D.string |> D.andThen decodeDate)
        |> hardcoded (Route.SPLAT__ { splat = splat })


decodeDate : String -> D.Decoder Date
decodeDate dateString =
    case Date.fromIsoString dateString of
        Ok date ->
            D.succeed date

        Err _ ->
            D.fail "Invalid date format. Expected ISO-8601"


routeAsLoadedPageAndThen :
    { a | splat : List String }
    ->
        (String
         ->
            { meta :
                Meta
            , markdown : String
            }
         -> BTask b
        )
    -> BTask b
routeAsLoadedPageAndThen routeParams fn =
    case routeParams.splat of
        parts ->
            parts
                |> withOrWithoutIndexSegment
                |> BackendTask.andThen
                    (\path ->
                        path
                            |> BackendTask.File.bodyWithFrontmatter
                                (\rawMarkdown ->
                                    D.succeed ()
                                        |> D.andThen
                                            (\_ ->
                                                decodeMeta routeParams.splat
                                             -- |> Debug.log("❌ Failed to decode metadata for " ++ path)
                                            )
                                        |> D.andThen
                                            (\meta ->
                                                D.succeed { meta = meta, markdown = rawMarkdown }
                                            )
                                )
                            |> BackendTask.allowFatal
                            |> BackendTask.andThen (fn path)
                    )


withOrWithoutIndexSegment : List String -> BTask String
withOrWithoutIndexSegment parts =
    Glob.succeed identity
        |> Glob.match (Glob.literal ("content" :: parts |> String.join "/"))
        |> Glob.match
            (Glob.oneOf
                ( ( "/index", () )
                , [ ( "", () ) ]
                )
            )
        |> Glob.match (Glob.literal ".md")
        |> Glob.captureFilePath
        |> Glob.expectUniqueMatch
        |> BackendTask.allowFatal


markdownRendererCore : String -> Result String (List Block)
markdownRendererCore rawMarkdown =
    rawMarkdown
        |> prefixMarkdownTableOfContents
        |> Markdown.Footnotes.formatFootnotes
        |> Markdown.Parser.parse
        |> Result.mapError
            (\errs ->
                errs
                    |> List.map parserDeadEndToString
                    |> String.join "\n"
                    |> (++) ("Failure in path " ++ ": ")
            )


prefixMarkdownTableOfContents : String -> String
prefixMarkdownTableOfContents s =
    let
        toc =
            s
                |> String.split "\n"
                |> List.dropWhile (\l -> l /= "<toc></toc>")
                |> List.filter (String.startsWith "##")
                |> List.filter (not << String.startsWith "####")
                |> List.map
                    (\l ->
                        let
                            depth =
                                l
                                    |> String.split "#"
                                    |> List.length
                                    |> (\v -> List.repeat ((v - 3) * 2) " ")
                                    |> String.join ""

                            title =
                                l |> String.replace "#" "" |> String.trim

                            ref =
                                stringToTitleId title
                        in
                        depth ++ "- [" ++ title ++ "](#" ++ ref ++ ")"
                    )
                |> String.join "\n"
                |> (++) "**Contents:**\n\n"
    in
    s |> String.replace "<toc></toc>" toc


parserDeadEndToString :
    { a | row : Int, col : Int, problem : Parser.Problem }
    -> String
parserDeadEndToString err =
    [ "row:" ++ String.fromInt err.row
    , "col:" ++ String.fromInt err.col
    , "problem:" ++ problemToString err.problem
    ]
        |> String.join "\n"


problemToString : Parser.Problem -> String
problemToString problem =
    case problem of
        Parser.Expecting string ->
            "Expecting:" ++ string

        Parser.ExpectingInt ->
            "ExpectingInt"

        Parser.ExpectingHex ->
            "ExpectingHex"

        Parser.ExpectingOctal ->
            "ExpectingOctal"

        Parser.ExpectingBinary ->
            "ExpectingBinary"

        Parser.ExpectingFloat ->
            "ExpectingFloat"

        Parser.ExpectingNumber ->
            "ExpectingNumber"

        Parser.ExpectingVariable ->
            "ExpectingVariable"

        Parser.ExpectingSymbol string ->
            "ExpectingSymbol:" ++ string

        Parser.ExpectingKeyword string ->
            "ExpectingKeyword:" ++ string

        Parser.ExpectingEnd ->
            "ExpectingEnd"

        Parser.UnexpectedChar ->
            "UnexpectedChar"

        Parser.Problem string ->
            "Problem:" ++ string

        Parser.BadRepeat ->
            "BadRepeat"


markdownRendererDirect :
    String
    -> Route.Route
    -> Types.Model
    -> Types.GlobalData
    -> List (Html Types.Msg)
markdownRendererDirect rawMarkdown route model global =
    rawMarkdown
        |> markdownRendererCore
        |> Result.andThen
            (\blocks ->
                Markdown.Renderer.render (Theme.Markdown.renderer model global) blocks
            )
        |> (\res ->
                case res of
                    Ok ui ->
                        ui

                    Err err ->
                        [ text <| "Failure in path " ++ Route.toString route ++ ": " ++ err ]
           )


stringToTitleId : String -> String
stringToTitleId s =
    s
        |> String.toLower
        |> String.replace "<br/>" ""
        |> String.replace "?" "-"
        |> String.replace "!" ""
        |> String.replace "." ""
        |> String.replace "," ""
        |> String.replace "'" ""
        |> String.replace "/" "-"
        |> String.replace "`" ""
        |> String.replace "<" ""
        |> String.replace ">" ""
        |> String.replace "”" ""
        |> String.replace "“" ""
        |> String.split " "
        |> List.filter (not << String.isEmpty)
        |> String.join "-"
