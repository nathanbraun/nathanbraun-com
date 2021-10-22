module Shared exposing
    ( Data
    , Model
    , Msg(..)
    , SharedMsg(..)
    , TestId
    , Version(..)
    , template
    )

import Analytics
import Browser.Navigation
import Css.Global exposing (global)
import DataSource
import Html
import Html.Styled exposing (a, div, text, toUnstyled)
import Html.Styled.Attributes as Attr exposing (css)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Path exposing (Path)
import Random exposing (Generator)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import Tailwind.Breakpoints as Bp
import Tailwind.Utilities as Tw
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type Msg
    = OnPageChange
        { path : Path
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg


type alias Data =
    ()


type SharedMsg
    = RandomVersion Version


type alias Model =
    { showMobileMenu : Bool
    , test : Test
    }


init :
    Maybe Browser.Navigation.Key
    -> Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : Path
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Cmd Msg )
init navigationKey flags maybePagePath =
    let
        command =
            case maybePagePath of
                Nothing ->
                    Cmd.none

                Just pagePath ->
                    pagePath.path.path |> Path.toAbsolute |> Analytics.trackPageNavigation
    in
    ( { showMobileMenu = False, test = Test (TestId "header-test") Nothing }
    , Cmd.batch
        [ command

        -- TODO: get from localhost/write here
        , Random.generate (RandomVersion >> SharedMsg)
            randomVersion
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange newPage ->
            ( { model | showMobileMenu = False }
            , newPage.path |> Path.toAbsolute |> Analytics.trackPageNavigation
            )

        SharedMsg (RandomVersion version) ->
            let
                oldTest =
                    model.test

                newTest =
                    { oldTest | version = Just version }
            in
            ( { model | test = newTest }, Cmd.none )


subscriptions : Path -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


header : Path -> Html.Styled.Html msg
header path =
    case Path.toRelative path of
        "" ->
            div [] []

        _ ->
            div [ css [ Tw.mb_6 ] ]
                [ a
                    [ Attr.href "/"
                    , css
                        [ Tw.mt_10
                        , Tw.w_auto
                        , Tw.text_blue_600
                        ]
                    ]
                    [ text
                        "← Home"
                    ]
                ]


view :
    Data
    ->
        { path : Path
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : Html.Html msg, title : String }
view sharedData page model toMsg pageView =
    { body =
        toUnstyled <|
            div []
                [ global Tw.globalStyles
                , div
                    [ css
                        [ Tw.bg_gray_100
                        , Tw.font_sans
                        , Tw.text_lg
                        , Tw.flex
                        , Tw.justify_center
                        , Tw.h_full
                        , Tw.min_h_screen
                        , Tw.text_gray_700
                        ]
                    ]
                    [ div
                        [ css [ Bp.md [ Tw.mt_8 ], Tw.max_w_3xl, Tw.flex_col ] ]
                        (header page.path :: pageView.body)
                    ]
                ]
    , title = pageView.title
    }


randomVersion : Generator Version
randomVersion =
    Random.map
        (\x ->
            if x == 1 then
                A

            else
                B
        )
        (Random.int 1 2)


type Version
    = A
    | B


type TestId
    = TestId String


type alias Test =
    { testId : TestId
    , version : Maybe Version
    }
