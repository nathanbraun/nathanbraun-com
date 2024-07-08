module Components.Heading exposing (new, view)

import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Markdown.Block as Block
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw


type Heading msg
    = Settings
        { level : Block.HeadingLevel
        , rawText : String
        , children : List (Html msg)
        }


new :
    { level : Block.HeadingLevel
    , rawText : String
    , children : List (Html msg)
    }
    -> Heading msg
new props =
    Settings
        { level = props.level
        , rawText = props.rawText
        , children = props.children
        }


view : Heading msg -> Html msg
view (Settings settings) =
    -- heading :
    --     { level : Block.HeadingLevel
    --     , rawText : String
    --     , children : List (Html.Html msg)
    --     }
    --     -> Html.Html msg
    let
        commonCss =
            [ Tw.text_color Theme.gray_800
            , Tw.tracking_tight
            , Tw.font_bold
            , Bp.md [ Tw.mx_0 ]
            , Tw.mx_4
            ]
    in
    case settings.level of
        Block.H1 ->
            h1
                [ css
                    ([ Bp.sm [ Tw.text_4xl ]
                     , Tw.text_5xl
                     , Tw.mt_6
                     , Tw.mb_4
                     , Tw.font_sans
                     , Tw.font_bold
                     ]
                        ++ commonCss
                    )
                ]
                settings.children

        Block.H2 ->
            h2
                [ Attr.id (rawTextToId settings.rawText)
                , Attr.attribute "name" (rawTextToId settings.rawText)
                , css
                    ([ Tw.text_3xl
                     , Tw.mt_4
                     , Tw.mb_3
                     ]
                        ++ commonCss
                    )
                ]
                settings.children

        Block.H3 ->
            h3
                [ Attr.id (rawTextToId settings.rawText)
                , Attr.attribute "name" (rawTextToId settings.rawText)
                , css
                    ([ Tw.text_2xl
                     , Tw.mt_6
                     , Tw.mb_4
                     ]
                        ++ commonCss
                    )
                ]
                settings.children

        Block.H4 ->
            h4
                [ Attr.id (rawTextToId settings.rawText)
                , Attr.attribute "name" (rawTextToId settings.rawText)
                , css
                    ([ Tw.text_xl
                     , Tw.mt_6
                     , Tw.mb_4
                     , Tw.italic
                     ]
                        ++ commonCss
                    )
                ]
                settings.children

        _ ->
            (case settings.level of
                Block.H1 ->
                    h1

                Block.H2 ->
                    h2

                Block.H3 ->
                    h3

                Block.H4 ->
                    h4

                Block.H5 ->
                    h5

                Block.H6 ->
                    h6
            )
                [ css
                    ([ Tw.text_lg
                     , Tw.mt_4
                     ]
                        ++ commonCss
                    )
                ]
                settings.children


rawTextToId : String -> String
rawTextToId rawText =
    rawText
        |> String.split " "
        |> String.join "-"
        |> String.toLower
