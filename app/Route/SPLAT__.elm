module Route.SPLAT__ exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

-- import RouteCommon

import BackendTask
import BackendTask.Helpers exposing (BTask, Post, routes)
import DataSource.MarkdownTailwind
import Effect
import ErrorPage
import FatalError
import Head
import Html.Styled as Html
import PagesMsg
import RouteBuilder exposing (App, StatefulRoute)
import Server.Request
import Server.Response
import Shared
import Types exposing (RouteParams)
import UrlPath
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Types.Msg


type alias RouteParams =
    Types.RouteParams


route : StatefulRoute RouteParams Data ActionData () Types.Msg
route =
    RouteBuilder.preRender
        { head = head
        , pages = routes
        , data = data
        }
        |> RouteBuilder.buildWithSharedState
            { view =
                \app modelShared modelTemplate ->
                    view app modelShared
            , init =
                \app modelShared ->
                    ( (), Effect.none )
            , update =
                -- , update : PageUrl -> StaticPayload data routeParams -> msg -> model -> Shared.Model -> ( model, Effect msg, Maybe Shared.Msg )
                \app modelShared msgTemplate modelTemplate ->
                    -- SPLAT__ uses Types_.Msg same as shared, so just route all handling up to shared.
                    ( (), Effect.none, Just msgTemplate )
            , subscriptions =
                \routeParams path modelShared modelTemplate ->
                    Sub.none
            }


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions routeParams path shared model =
    Sub.none


type alias Data =
    Post


type alias ActionData =
    {}


data : RouteParams -> BTask Data
data routeParams =
    DataSource.MarkdownTailwind.routeAsLoadedPageAndThen routeParams
        (\path d ->
            BackendTask.map
                (\sharedData ->
                    let
                        data_ : Data
                        data_ =
                            { meta = d.meta
                            , global =
                                { isDev = sharedData.isDev
                                }
                            , rawMarkdown = d.markdown
                            }
                    in
                    data_
                )
                Shared.data
        )


head : App Data ActionData RouteParams -> List Head.Tag
head app =
    []


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg.PagesMsg Types.Msg)
view app sharedModel =
    { title = app.data.meta.title
    , content =
        DataSource.MarkdownTailwind.markdownRendererDirect
            app.data.rawMarkdown
            app.data.meta.route
            sharedModel
            app.data.global
            |> List.map (Html.map PagesMsg.fromMsg)
    , route = app.data.meta.route
    , published = app.data.meta.rss
    , meta = app.data.meta
    }


action :
    RouteParams
    -> Server.Request.Request
    -> BackendTask.BackendTask FatalError.FatalError (Server.Response.Response ActionData ErrorPage.ErrorPage)
action routeParams request =
    BackendTask.succeed (Server.Response.render {})
