module Api exposing (routes)

import ApiRoute exposing (ApiRoute)
import BackendTask exposing (BackendTask)
import BackendTask.Helpers as BTask exposing (allPosts)
import FatalError exposing (FatalError)
import Head
import Html exposing (Html)
import HtmlStringMarkdownRenderer
import Pages
import Pages.Manifest as Manifest
import Route exposing (Route)
import RouteCommon
import Rss
import Time


routes :
    BackendTask FatalError (List Route)
    -> (Maybe { indent : Int, newLines : Bool } -> Html Never -> String)
    -> List (ApiRoute ApiRoute.Response)
routes getStaticRoutes htmlToString =
    [ rss
        { siteTagline = ""
        , siteUrl = "https://nathanbraun.com"
        , title = "Nathan Braun"
        , builtAt = Pages.builtAt
        , indexPage = [ "/" ]
        }
        postsBackendTask
    ]



-- manifest : Manifest.Config
-- manifest =
--     Manifest.init
--         { name = "Site Name"
--         , description = "Description"
--         , startUrl = Route.Index |> Route.toPath
--         , icons = []
--         }


rss :
    { siteTagline : String
    , siteUrl : String
    , title : String
    , builtAt : Time.Posix
    , indexPage : List String
    }
    -> BackendTask FatalError (List Rss.Item)
    -> ApiRoute.ApiRoute ApiRoute.Response
rss options itemsRequest =
    ApiRoute.succeed
        (BackendTask.map
            (\items ->
                Rss.generate
                    { title = options.title
                    , description = options.siteTagline
                    , url = options.siteUrl ++ "/" ++ String.join "/" options.indexPage
                    , lastBuildTime = options.builtAt
                    , generator = Just "Nathan Braun"
                    , items = items
                    , siteUrl = options.siteUrl
                    }
            )
            itemsRequest
        )
        |> ApiRoute.literal "feed.xml"
        |> ApiRoute.single
        |> ApiRoute.withGlobalHeadTags
            (BackendTask.succeed
                [ Head.rssLink "feed.xml"
                ]
            )



-- |> ApiRoute.withGlobalHeadTags
--     (BackendTask.succeed
--         [ Head.rssLink "/feed.xml"
--         ]
--     )


postsBackendTask : BackendTask FatalError (List Rss.Item)
postsBackendTask =
    BTask.allPosts
        |> BackendTask.map
            (List.map
                (\{ meta, global, rawMarkdown } ->
                    { title = meta.title
                    , description = meta.description
                    , url =
                        meta.route
                            |> Route.routeToPath
                            |> String.join "/"
                    , categories = []
                    , author = "Nathan Braun"
                    , pubDate = Rss.Date meta.date
                    , content = Nothing
                    , contentEncoded =
                        rawMarkdown
                            |> HtmlStringMarkdownRenderer.renderMarkdown
                            |> Result.toMaybe
                    , enclosure = Nothing
                    }
                )
            )



-- |> BackendTask.allowFatal
-- resolveDate : Post -> BackendTask FatalError Post
-- resolveDate post =
--     case fromIsoString post.meta.date of
--         Nothing ->
--             BackendTask.fail <| FatalError "Date parsing failed"
--         Just date ->
--             let
--                 newMeta = { post.meta | date = date }
--                 newPost = { post | meta = newMeta }
--             in
--             BackendTask.succeed newPost
