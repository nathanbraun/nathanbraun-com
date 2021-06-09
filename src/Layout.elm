module Layout exposing (view)

import DocumentSvg
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Font as Font
import Element.Region
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Metadata exposing (Metadata)
import Pages
import Pages.Directory as Directory exposing (Directory)
import Pages.ImagePath as ImagePath
import Pages.PagePath as PagePath exposing (PagePath)
import Palette
import String.Extra exposing (toTitleCase)
import Tailwind.Breakpoints as Bp
import Tailwind.Utilities as Tw


view :
    { title : String, body : List (Html.Styled.Html msg) }
    ->
        { path : PagePath Pages.PathKey
        , frontmatter : Metadata
        }
    -> { title : String, body : Html.Html msg }
view document page =
    { title = document.title
    , body =
        toUnstyled <|
            div
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
                [ div [ css [ Bp.md [ Tw.mt_8 ], Tw.max_w_3xl, Tw.flex_col ] ]
                    (header page.path
                        :: document.body
                    )
                ]
    }


header : PagePath Pages.PathKey -> Html.Styled.Html msg
header currentPath =
    div [ css [] ]
        [ case PagePath.toString currentPath |> String.split "/" of
            [] ->
                div [ css [ Tw.mt_10 ] ] []

            "" :: [] ->
                div [ css [ Tw.mt_10 ] ] []

            path :: [] ->
                div [ css [ Tw.mb_6 ] ]
                    [ a [ Attr.href "", css [ Tw.no_underline, Tw.w_auto ] ]
                        [ text
                            "← Home"
                        ]
                    ]

            sub :: other ->
                div [ css [ Tw.mt_6, Tw.mb_8 ] ]
                    [ a [ Attr.href sub, css [ Tw.no_underline, Tw.w_auto ] ]
                        [ text
                            ("← " ++ (sub |> toTitleCase))
                        ]
                    ]
        ]
