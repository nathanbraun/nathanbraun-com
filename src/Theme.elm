module Theme exposing (view)

import Css.Global exposing (global)
import Html exposing (Html)
import Html.Styled exposing (a, div, text, toUnstyled)
import Html.Styled.Attributes as Attr exposing (css)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Types
import UrlPath exposing (UrlPath)
import View


view :
    UrlPath
    -> { a | isDev : Bool }
    -> (Types.Msg -> wrapperMsg)
    -> Types.Model
    -> View.View wrapperMsg
    -> Html wrapperMsg
view path globalData toWrapperMsg model static =
    toUnstyled <|
        div []
            [ global Tw.globalStyles
            , Html.Styled.main_
                [ css
                    [ Tw.bg_color Theme.gray_100
                    , Tw.font_sans
                    , Tw.text_lg
                    , Tw.flex
                    , Tw.justify_center
                    , Tw.h_full
                    , Tw.min_h_screen
                    , Tw.text_color Theme.gray_700
                    ]
                ]
                [ div
                    [ css [ Bp.md [ Tw.mt_8 ], Tw.max_w_3xl, Tw.flex_col ] ]
                    (header path :: static.content)
                ]
            ]


header : UrlPath -> Html.Styled.Html msg
header path =
    case UrlPath.toRelative path of
        "" ->
            div [] []

        "posts" ->
            div [ css [ Bp.md [ Tw.ml_0 ], Tw.ml_3, Tw.mt_4, Tw.mb_6 ] ]
                [ a
                    [ Attr.href "/"
                    , css
                        [ Tw.w_auto
                        , Tw.text_color Theme.blue_600
                        ]
                    ]
                    [ text
                        "← Home"
                    ]
                , text " | "
                , a
                    [ Attr.href "/feed.xml"
                    , css
                        [ Tw.w_auto
                        , Tw.text_color Theme.blue_600
                        ]
                    ]
                    [ text
                        "RSS"
                    ]
                ]

        _ ->
            div [ css [ Bp.md [ Tw.ml_0 ], Tw.ml_3, Tw.mt_4, Tw.mb_6 ] ]
                [ a
                    [ Attr.href "/"
                    , css
                        [ Tw.mt_10
                        , Tw.w_auto
                        , Tw.text_color Theme.blue_600
                        ]
                    ]
                    [ text
                        "← Home"
                    ]
                , text " | "
                , a
                    [ Attr.href "/posts"
                    , css
                        [ Tw.mt_10
                        , Tw.w_auto
                        , Tw.text_color Theme.blue_600
                        ]
                    ]
                    [ text
                        "Posts"
                    ]
                ]
