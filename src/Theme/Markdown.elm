module Theme.Markdown exposing (renderer)

import Components.Heading
import Css
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Markdown.Block as Block
import Markdown.Html
import Markdown.Renderer
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Theme.All
import Types exposing (GlobalData, Model, Msg)


renderer : Model -> GlobalData -> Markdown.Renderer.Renderer (Html Msg)
renderer model global =
    { heading = Components.Heading.new >> Components.Heading.view
    , paragraph =
        \children ->
            -- fromHtml <| Html.blockquote [] (asHtml children)
            div
                [ css
                    [ Tw.flex
                    , Tw.items_center
                    , Tw.justify_center
                    , Tw.mb_4
                    ]
                ]
                [ p
                    [ css
                        [ Bp.sm [ Tw.mx_0 ]
                        , Tw.mx_4
                        , Tw.my_0
                        , Tw.flex_grow
                        ]
                    ]
                    children
                ]
    , blockQuote =
        \children ->
            p
                [ css
                    [ Bp.md
                        [ Tw.border
                        , Tw.border_solid
                        , Tw.border
                        , Tw.rounded
                        , Tw.bg_color Theme.white
                        , Tw.shadow_lg
                        , Tw.italic
                        , Tw.my_6
                        ]
                    , Tw.px_6
                    , Tw.py_4
                    ]
                ]
                children

    -- , html = Markdown.Html.oneOf []
    , html = Theme.All.htmlMapping model global

    -- @TODO preserve newlines on... new lines?
    , text =
        \content ->
            text content
    , codeSpan = \content -> code [ css [] ] [ text content ]
    , strong = \content -> strong [ css [ Tw.font_bold ] ] content
    , emphasis = \content -> span [ css [ Tw.italic ] ] content
    , hardLineBreak = div [] []
    , link =
        \{ title, destination } list ->
            a
                [ Attr.href destination
                , css
                    [ Tw.underline
                    , Tw.text_color Theme.blue_600
                    , Css.visited [ Tw.text_color Theme.purple_800 ]
                    ]
                ]
                list
    , image =
        \{ alt, src, title } ->
            img
                [ css [ Tw.object_scale_down, Tw.w_full ]
                , Attr.src src
                , Attr.alt alt
                ]
                []
    , unorderedList =
        \items ->
            --     none
            div
                [ css
                    [ Tw.flex
                    , Tw.justify_center
                    ]
                ]
                [ ul
                    [ css
                        [ Tw.list_disc
                        , Tw.ml_10
                        , Tw.mb_2
                        , Tw.flex_grow
                        , Bp.md
                            [ Tw.mr_0
                            ]
                        , Tw.mr_6
                        ]
                    ]
                    (items
                        |> List.map
                            (\item ->
                                case item of
                                    Block.ListItem task children ->
                                        let
                                            checkbox =
                                                case task of
                                                    Block.NoTask ->
                                                        text ""

                                                    Block.IncompleteTask ->
                                                        input
                                                            [ Attr.disabled True
                                                            , Attr.checked False
                                                            , Attr.type_ "checkbox"
                                                            ]
                                                            []

                                                    Block.CompletedTask ->
                                                        input
                                                            [ Attr.disabled True
                                                            , Attr.checked True
                                                            , Attr.type_ "checkbox"
                                                            ]
                                                            []
                                        in
                                        li [] (checkbox :: children)
                            )
                    )
                ]
    , orderedList =
        \startingIndex items ->
            ol
                (case startingIndex of
                    1 ->
                        [ Attr.start startingIndex
                        , css
                            [ Tw.list_decimal
                            , Tw.ml_10
                            ]
                        ]

                    _ ->
                        []
                )
                (items
                    |> List.map
                        (\itemBlocks ->
                            li [ css [ Bp.md [ Tw.mr_0 ], Tw.mr_6 ] ]
                                itemBlocks
                        )
                )
    , codeBlock =
        \{ body, language } ->
            case language of
                Nothing ->
                    div [] []

                Just "elm" ->
                    div [] []

                Just other ->
                    div [] []
    , thematicBreak = hr [] []
    , table = \children -> div [] children
    , tableHeader = \children -> div [] children
    , tableBody = \children -> div [] children
    , tableRow = \children -> div [] children
    , tableCell = \alignment children -> div [] children
    , tableHeaderCell = \alignmentM children -> div [] children
    , strikethrough = \children -> Html.del [] children
    }
