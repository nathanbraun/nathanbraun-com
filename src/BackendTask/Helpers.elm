module BackendTask.Helpers exposing (BTask, Post, allPosts, routes)

import BackendTask exposing (BackendTask)
import BackendTask.File
import BackendTask.Glob as Glob
import DataSource.Meta exposing (..)
import Date exposing (Date)
import FatalError
import Json.Decode as D
import Json.Decode.Pipeline exposing (hardcoded, optional, required)
import Route
import Time exposing (Month(..))
import Types exposing (GlobalData, RouteParams)


type alias BTask v =
    BackendTask FatalError.FatalError v


type alias Post =
    { meta : Meta
    , global : Types.GlobalData
    , rawMarkdown : String
    }


allPosts : BTask (List Post)
allPosts =
    routes
        |> BackendTask.andThen
            (\routeParams ->
                routeParams
                    |> List.map
                        (\routeParam ->
                            routeAsLoadedPageAndThen routeParam
                                (\_ contentPage ->
                                    BackendTask.succeed
                                        { meta = contentPage.meta
                                        , global = { isDev = True } -- adjust as necessary
                                        , rawMarkdown = contentPage.markdown
                                        }
                                )
                        )
                    |> BackendTask.combine
            )
        |> BackendTask.map
            (\posts ->
                posts
                    |> List.filter (\post -> post.meta.rss)
                    |> List.sortBy (\post -> post.meta.date |> Date.toIsoString)
                    |> List.reverse
            )



-- allPosts : BTask (List Post)
-- allPosts =
--     BackendTask.succeed
--         [ { meta =
--                 { title = "test"
--                 , description = "test"
--                 , rss = False
--                 , date = Date.fromCalendarDate 1970 Jan 1
--                 , route = Route.SPLAT__ { splat = [ "test" ] }
--                 }
--           , global = { isDev = True }
--           , rawMarkdown = "test"
--           }
--         ]


routes : BTask (List RouteParams)
routes =
    content
        |> BackendTask.map
            (List.map
                (\contentPage ->
                    { splat = contentPage }
                )
            )


content : BTask (List (List String))
content =
    Glob.succeed
        (\leadingPath last ->
            if last == "index" then
                leadingPath

            else
                leadingPath ++ [ last ]
        )
        |> Glob.match (Glob.literal "content/")
        |> Glob.capture Glob.recursiveWildcard
        |> Glob.match (Glob.literal "/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
        |> Glob.toBackendTask


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


decodeMeta : List String -> D.Decoder Meta
decodeMeta splat =
    D.succeed Meta
        |> required "title" D.string
        |> optional "internal" (D.map Just D.string) Nothing
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
