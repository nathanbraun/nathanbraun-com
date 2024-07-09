module Route.Posts exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import BackendTask.Helpers exposing (BTask, routes)
import Components.Heading
import Css
import DataSource.MarkdownTailwind
    exposing
        ( decodeMeta
        , routeAsLoadedPageAndThen
        )
import DataSource.Meta as Meta exposing (Meta)
import Date
import FatalError
import Head
import Head.Seo as Seo
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Json.Decode as Decode
import Markdown.Block as Block
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatefulRoute, StatelessRoute)
import Shared
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Types
import View exposing (View)


type alias RouteParams =
    {}


type alias Model =
    {}


type alias Msg =
    ()


type alias ActionData =
    {}


type alias Data =
    -- List Types.RouteParams
    List Meta


route : StatelessRoute {} Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data routes
        }
        |> RouteBuilder.buildNoState { view = view }


routeParamsToMeta : List Types.RouteParams -> BTask (List Meta)
routeParamsToMeta routeParams =
    routeParams
        |> List.map
            (\routeParam ->
                routeAsLoadedPageAndThen routeParam
                    (\_ { meta, markdown } ->
                        BackendTask.succeed meta
                    )
            )
        |> BackendTask.combine



-- routeParamsToMeta : List Types.RouteParams -> BTask Data
-- routeParamsToMeta routeParam =
--     routeParam
--         |> List.map
--             (\x -> x)
--         |> BackendTask.succeed


data : BTask (List Types.RouteParams) -> BTask Data
data routes =
    routes |> BackendTask.andThen routeParamsToMeta


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "Index page"
    , route = Route.SPLAT__ { splat = [ "posts" ] }
    , meta = Meta.empty
    , published = False
    , content =
        [ Components.Heading.new
            { level =
                Block.H1
            , rawText = "All Posts"
            , children = [ div [] [ text "All Posts" ] ]
            }
            |> Components.Heading.view
        , div []
            (app.data
                -- sort descending by date
                |> List.filter (\meta -> meta.rss)
                |> List.sortBy (\meta -> meta.date |> Date.toIsoString)
                |> List.reverse
                |> List.map postView
            )
        ]
    }


postView : Meta -> Html msg
postView meta =
    div [ css [ Tw.flex ] ]
        [ span [ css [ Tw.hidden, Bp.md [ Tw.inline ] ] ]
            [ text (meta.date |> Date.toIsoString)
            ]
        , div [ css [ Tw.flex ] ]
            [ span [ css [ Tw.mx_2 ] ] [ text " - " ]
            , linkToPost meta
            ]

        -- , div
        --     [ css
        --         [ Tw.underline
        --         , Tw.text_color Theme.blue_600
        --         , Css.visited [ Tw.text_color Theme.purple_800 ]
        --         ]
        --     ]
        --     [ text meta.title ]
        -- ]
        ]


linkToPost : Meta -> Html msg
linkToPost meta =
    a
        [ Attr.href <| Route.toString <| meta.route
        , css
            [ Tw.underline
            , Tw.text_color Theme.blue_600
            , Css.visited [ Tw.text_color Theme.purple_800 ]
            ]
        ]
        [ text meta.title ]
