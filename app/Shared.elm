module Shared exposing (Data, Model, Msg, SharedMsg, data, template)

import BackendTask exposing (BackendTask)
import BackendTask.Helpers exposing (BTask)
import Browser.Navigation as Nav
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Styled exposing (a, div, text, toUnstyled)
import Html.Styled.Attributes as Attr exposing (css)
import Html.Styled.Events
import Json.Decode as Decode
    exposing
        ( Decoder
        , bool
        , field
        , float
        , int
        , maybe
        , string
        )
import Json.Encode as Encode
import List.Extra as Extra
import Pages.Flags exposing (Flags(..))
import Pages.PageUrl exposing (PageUrl)
import Process
import Route exposing (Route)
import ScrollTo
import SharedTemplate exposing (SharedTemplate)
import Task
import Theme
import Time
import Types exposing (Msg(..), SharedMsg(..))
import UrlPath exposing (UrlPath, toRelative)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }


type alias Msg =
    Types.Msg


type alias Data =
    Types.GlobalData


type alias SharedMsg =
    Types.SharedMsg


type alias Model =
    Types.Model


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( { showMenu = False
      , scrollTo = ScrollTo.init
      }
    , Effect.none
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( model, Effect.none )

        SharedMsg (ScrollToId id) ->
            ( model
            , ScrollTo.scrollTo id
                |> Cmd.map (ScrollToMsg >> SharedMsg)
                |> Effect.fromCmd
            )

        SharedMsg (ScrollToMsg scrollToMsg) ->
            let
                ( scrollToModel, scrollToCmds ) =
                    ScrollTo.update
                        scrollToMsg
                        model.scrollTo
            in
            ( { model | scrollTo = scrollToModel }
            , scrollToCmds |> Cmd.map (ScrollToMsg >> SharedMsg) |> Effect.fromCmd
            )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ model =
    Sub.batch
        [ Sub.map (ScrollToMsg >> SharedMsg) (ScrollTo.subscriptions model.scrollTo)
        ]


data : BTask Data
data =
    BackendTask.succeed { isDev = True }


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        [ Theme.view page.path sharedData toMsg model pageView ]
    , title = pageView.title
    }
