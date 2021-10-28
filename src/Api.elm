module Api exposing (routes)

import ApiRoute
import DataSource exposing (DataSource)
import Html exposing (Html)
import HtmlStringMarkdownRenderer
import Pages
import Post
import Route exposing (Route)
import Rss
import Time


routes :
    DataSource (List Route)
    -> (Html Never -> String)
    -> List (ApiRoute.ApiRoute ApiRoute.Response)
routes getStaticRoutes htmlToString =
    [ rss
        { siteTagline = ""
        , siteUrl = "https://nathanbraun.com"
        , title = "Nathan Braun"
        , builtAt = Pages.builtAt
        , indexPage = [ "/" ]
        }
        postsDataSource
    ]


rss :
    { siteTagline : String
    , siteUrl : String
    , title : String
    , builtAt : Time.Posix
    , indexPage : List String
    }
    -> DataSource.DataSource (List Rss.Item)
    -> ApiRoute.ApiRoute ApiRoute.Response
rss options itemsRequest =
    ApiRoute.succeed
        (itemsRequest
            |> DataSource.map
                (\items ->
                    { body =
                        Rss.generate
                            { title = options.title
                            , description = options.siteTagline
                            , url = options.siteUrl ++ "/" ++ String.join "/" options.indexPage
                            , lastBuildTime = options.builtAt
                            , generator = Just "Nathan Braun"
                            , items = items
                            , siteUrl = options.siteUrl
                            }
                    }
                )
        )
        |> ApiRoute.literal "feed.xml"
        |> ApiRoute.single


postsDataSource : DataSource.DataSource (List Rss.Item)
postsDataSource =
    Post.allPosts
        |> DataSource.map
            (List.map
                (\{ route, metadata, content } ->
                    { title = metadata.title
                    , description = metadata.description
                    , url =
                        route
                            |> Route.routeToPath
                            |> String.join "/"
                    , categories = []
                    , author = "Nathan Braun"
                    , pubDate = Rss.Date metadata.published
                    , content = Nothing
                    , contentEncoded =
                        content
                            |> HtmlStringMarkdownRenderer.renderMarkdown
                            |> Result.toMaybe
                    , enclosure = Nothing
                    }
                )
            )
