module MarkdownCodec exposing
    ( PageMetadata
    , frontmatterDecoder
    , pageBody
    , withFrontmatter
    )

import DataSource exposing (DataSource)
import DataSource.File as StaticFile
import DataSource.Glob as Glob exposing (Glob)
import Date exposing (Date)
import Html.Styled as Html exposing (Html)
import Markdown.Block exposing (Block)
import Markdown.Parser
import OptimizedDecoder exposing (Decoder)
import Shared
import TailwindMarkdownRenderer


withFrontmatter :
    (frontmatter -> (Shared.Model -> List (Html msg)) -> value)
    -> Decoder frontmatter
    -> (List Block -> DataSource (Shared.Model -> List (Html msg)))
    -> String
    -> DataSource value
withFrontmatter constructor frontmatterDecoder2 renderer filePath =
    DataSource.map2 constructor
        (StaticFile.onlyFrontmatter
            frontmatterDecoder2
            filePath
        )
        ((StaticFile.bodyWithoutFrontmatter
            filePath
            |> DataSource.andThen
                (\rawBody ->
                    rawBody
                        |> Markdown.Parser.parse
                        |> Result.mapError (\_ -> "Couldn't parse markdown.")
                        |> DataSource.fromResult
                )
         )
            |> DataSource.andThen
                renderer
        )


frontmatterDecoder : OptimizedDecoder.Decoder PageMetadata
frontmatterDecoder =
    OptimizedDecoder.map4 PageMetadata
        (OptimizedDecoder.field "title" OptimizedDecoder.string)
        (OptimizedDecoder.field "description" OptimizedDecoder.string)
        (OptimizedDecoder.field "published"
            (OptimizedDecoder.string
                |> OptimizedDecoder.andThen
                    (\isoString ->
                        case Date.fromIsoString isoString of
                            Ok date ->
                                OptimizedDecoder.succeed date

                            Err error ->
                                OptimizedDecoder.fail error
                    )
            )
        )
        (OptimizedDecoder.field "draft" OptimizedDecoder.bool
            |> OptimizedDecoder.maybe
            |> OptimizedDecoder.map (Maybe.withDefault False)
        )


type alias PageMetadata =
    { title : String
    , description : String
    , published : Date
    , draft : Bool
    }


pageBody :
    List String
    ->
        (PageMetadata
         ->
            (Shared.Model
             -> List (Html msg)
            )
         -> value
        )
    -> DataSource value
pageBody splat constructor =
    Glob.expectUniqueMatch (findBySplat splat)
        |> DataSource.andThen
            (withFrontmatter
                constructor
                frontmatterDecoder
                TailwindMarkdownRenderer.render
            )


findBySplat : List String -> Glob String
findBySplat splat =
    Glob.succeed identity
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/")
        |> Glob.match (Glob.literal (String.join "/" splat))
        |> Glob.match
            (Glob.oneOf
                ( ( "", () )
                , [ ( "/index", () ) ]
                )
            )
        |> Glob.match (Glob.literal ".md")
