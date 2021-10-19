module TailwindMarkdownRenderer exposing (renderer)

import Css
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Markdown.Block as Block exposing (Block)
import Markdown.Html
import Markdown.Renderer
import Shared exposing (Model)
import SyntaxHighlight
import Tailwind.Breakpoints as Bp
import Tailwind.Utilities as Tw


renderer : Markdown.Renderer.Renderer (Model -> Html.Html msg)
renderer =
    { heading = heading
    , paragraph =
        \children model ->
            p [ css [ Tw.mx_3, Bp.md [ Tw.mx_0 ] ] ]
                (renderAll model children)
    , blockQuote =
        \children model ->
            p
                [ css
                    [ Bp.md
                        [ Tw.border
                        , Tw.border_solid
                        , Tw.border
                        , Tw.rounded
                        , Tw.bg_white
                        , Tw.shadow_lg
                        , Tw.italic
                        ]
                    , Tw.px_4
                    ]
                ]
                (renderAll model children)
    , html =
        Markdown.Html.oneOf
            [ Markdown.Html.tag "row"
                (\children model ->
                    div
                        [ css
                            [ Tw.flex
                            , Tw.flex_wrap
                            , Tw.place_content_evenly
                            , Tw.space_x_1
                            ]
                        ]
                        (renderAll model
                            children
                        )
                )
            , Markdown.Html.tag "image"
                (\src desc _ _ ->
                    img
                        [ css [ Tw.object_scale_down, Tw.max_w_xs ]
                        , Attr.src
                            src
                        , Attr.alt desc
                        ]
                        []
                )
                |> Markdown.Html.withAttribute "src"
                |> Markdown.Html.withAttribute "desc"
            , Markdown.Html.tag "test"
                (\_ model ->
                    case model.showMobileMenu of
                        True ->
                            div [] [ text "True" ]

                        False ->
                            div [] [ text "False" ]
                )
            ]
    , text = \children _ -> text children
    , codeSpan = \_ _ -> div [] []
    , strong =
        \children model ->
            strong [ css [ Tw.font_bold ] ]
                (renderAll model children)
    , emphasis =
        \children model ->
            em [ css [ Tw.italic ] ]
                (renderAll model children)
    , hardLineBreak = \_ -> br [] []
    , link =
        \{ destination } body model ->
            a
                [ Attr.href destination
                , css
                    [ Tw.underline
                    ]
                ]
                (renderAll model body)
    , image =
        \image _ ->
            case image.title of
                Just _ ->
                    img
                        [ css [ Tw.object_scale_down, Tw.w_full ]
                        , Attr.src
                            image.src
                        , Attr.alt image.alt
                        ]
                        []

                Nothing ->
                    img
                        [ css [ Tw.object_scale_down, Tw.w_full ]
                        , Attr.src
                            image.src
                        , Attr.alt image.alt
                        ]
                        []
    , unorderedList =
        \items model ->
            Html.div [ css [ Tw.m_6 ] ]
                [ ul [ css [ Tw.list_disc, Tw.mr_2, Bp.md [ Tw.mr_0 ] ] ]
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
                                        li [] (checkbox :: renderAll model children)
                            )
                    )
                ]
    , orderedList =
        \startingIndex items model ->
            ol
                (case startingIndex of
                    1 ->
                        [ Attr.start startingIndex ]

                    _ ->
                        []
                )
                (items
                    |> List.map
                        (\itemBlocks ->
                            li []
                                (renderAll model
                                    itemBlocks
                                )
                        )
                )
    , codeBlock = codeBlock
    , thematicBreak = \_ -> hr [] []
    , table = \children model -> div [] (renderAll model children)
    , tableHeader = \children model -> div [] (renderAll model children)
    , tableBody = \children model -> div [] (renderAll model children)
    , tableRow = \children model -> div [] (renderAll model children)
    , tableCell = \maybeAlignment children model -> div [] (renderAll model children)
    , tableHeaderCell = \_ _ _ -> div [] []
    , strikethrough =
        \children model -> Html.del [] (renderAll model children)
    }


rawTextToId rawText =
    rawText
        |> String.split " "
        |> String.join "-"
        |> String.toLower


heading :
    { level : Block.HeadingLevel
    , rawText : String
    , children :
        List (Model -> Html.Html msg)
    }
    -> Model
    -> Html.Html msg
heading { level, rawText, children } model =
    let
        commonCss =
            [ Tw.font_header
            , Tw.text_gray_800
            , Tw.tracking_tight
            , Tw.text_center
            , Tw.mx_3
            , Bp.md [ Tw.text_left, Tw.mx_0 ]
            ]
    in
    case level of
        Block.H1 ->
            h1
                [ css
                    ([ Tw.text_4xl
                     , Tw.mt_4
                     , Tw.mb_4
                     ]
                        ++ commonCss
                    )
                ]
                (renderAll model children)

        Block.H2 ->
            h2
                [ Attr.id (rawTextToId rawText)
                , Attr.attribute "name" (rawTextToId rawText)
                , css
                    ([ Tw.text_3xl
                     , Tw.mt_6
                     ]
                        ++ commonCss
                    )
                ]
                (renderAll model children)

        _ ->
            (case level of
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
                (renderAll model children)


renderAll : model -> List (model -> view) -> List view
renderAll model =
    List.map ((|>) model)


codeBlock : { body : String, language : Maybe String } -> Shared.Model -> Html.Html msg
codeBlock details model =
    SyntaxHighlight.elm details.body
        |> Result.map (SyntaxHighlight.toBlockHtml (Just 1))
        |> Result.map Html.fromUnstyled
        |> Result.withDefault (Html.pre [] [ Html.code [] [ Html.text details.body ] ])
