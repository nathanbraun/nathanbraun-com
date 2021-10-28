module Api exposing (routes)

import ApiRoute
import DataSource exposing (DataSource)
import Html exposing (Html)
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
        { siteTagline = "tagline"
        , siteUrl = "https://nathanbraun.com"
        , title = "elm-pages Blog"
        , builtAt = Pages.builtAt
        , indexPage = [ "blog" ]
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
                            , generator = Just "elm-pages"
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
    Post.allMetadata
        |> DataSource.map
            (List.map
                (\( route, article ) ->
                    { title = article.title
                    , description = article.description
                    , url =
                        route
                            |> Route.routeToPath
                            |> String.join "/"
                    , categories = []
                    , author = "Nathan Braun"
                    , pubDate = Rss.Date article.published
                    , content = Nothing
                    , contentEncoded = Nothing
                    , enclosure = Nothing
                    }
                )
            )
