module Render exposing (elmUiRenderer)

import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Font as Font
import Element.Input
import Element.Region
import Form
import Html exposing (Html)
import Html.Attributes
import Markdown.Block as Block exposing (Block, Inline, ListItem(..), Task(..))
import Markdown.Html
import Markdown.Renderer


elmUiRenderer : Markdown.Renderer.Renderer (Element msg)
elmUiRenderer =
    { heading = heading
    , paragraph =
        Element.paragraph
            [ Element.spacing 8, Element.width Element.fill ]
    , thematicBreak =
        Element.row
            [ Element.width Element.fill
            , Element.Border.widthEach
                { top = 0
                , right = 0
                , bottom = 3
                , left = 0
                }
            , Element.paddingXY 0 10
            , Element.Border.color (Element.rgb255 145 145 145)
            , Element.Background.color (Element.rgb255 245 245 245)
            ]
            [ Element.none ]
    , text = Element.text
    , strong = Element.row [ Font.bold ]
    , emphasis = Element.row [ Font.italic ]
    , codeSpan = code
    , link =
        \{ title, destination } body ->
            Element.link
                [ Element.htmlAttribute
                    (Html.Attributes.style "display"
                        "inline-flex"
                    )
                ]
                { url = destination
                , label =
                    Element.paragraph
                        [ Font.color (Element.rgb255 7 81 219)
                        ]
                        body
                }
    , hardLineBreak = Html.br [] [] |> Element.html
    , image =
        \image ->
            case image.title of
                Just title ->
                    Element.image [ Element.width Element.fill ]
                        { src =
                            image.src
                        , description = image.alt
                        }

                Nothing ->
                    Element.image [ Element.width Element.fill ]
                        { src =
                            image.src
                        , description = image.alt
                        }
    , blockQuote =
        \children ->
            Element.column
                [ Element.Border.widthEach
                    { top = 0
                    , right = 0
                    , bottom = 0
                    , left = 10
                    }
                , Element.padding 10
                , Element.Border.color (Element.rgb255 145 145 145)
                , Element.Background.color (Element.rgb255 245 245 245)
                ]
                children
    , unorderedList =
        \items ->
            Element.paragraph
                [ Element.spacing 6
                , Element.paddingXY 5 0
                , Element.width Element.fill
                ]
                (items
                    |> List.map
                        (\(ListItem task children) ->
                            Element.row [ Element.spacing 5 ]
                                [ Element.row
                                    [ Element.alignTop ]
                                    ((case task of
                                        IncompleteTask ->
                                            Element.Input.defaultCheckbox False

                                        CompletedTask ->
                                            Element.Input.defaultCheckbox True

                                        NoTask ->
                                            Element.el
                                                [ Font.size 24
                                                , Element.paddingXY 10 0
                                                , Element.alignTop
                                                ]
                                                (Element.text "•")
                                     )
                                        :: Element.text " "
                                        :: [ Element.paragraph [] children ]
                                    )
                                ]
                        )
                )
    , orderedList =
        \startingIndex items ->
            Element.column [ Element.spacing 15 ]
                (items
                    |> List.indexedMap
                        (\index itemBlocks ->
                            Element.row [ Element.spacing 5 ]
                                [ Element.row [ Element.alignTop ]
                                    (Element.text
                                        (String.fromInt
                                            (index
                                                + startingIndex
                                            )
                                            ++ " "
                                        )
                                        :: itemBlocks
                                    )
                                ]
                        )
                )
    , codeBlock = codeBlock
    , html =
        Markdown.Html.oneOf
            [ Markdown.Html.tag "emphasize"
                (\name children ->
                    Element.column [ Font.size 56 ] (Element.text name :: children)
                )
                |> Markdown.Html.withAttribute "name"
            , Markdown.Html.tag "contact-form"
                (\children -> Form.view [] |> Element.html)
            ]
    , table = Element.column []
    , tableHeader = Element.column []
    , tableBody = Element.column []
    , tableRow = Element.row []
    , tableHeaderCell =
        \maybeAlignment children ->
            Element.paragraph [] children
    , tableCell = Element.paragraph []
    }


codeBlock : { body : String, language : Maybe String } -> Element msg
codeBlock details =
    Element.el
        [ Element.Background.color (Element.rgba 0 0 0 0.03)
        , Element.htmlAttribute (Html.Attributes.style "white-space" "pre")
        , Element.padding 20
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
                , name = "Source Code Pro"
                }
            ]
        ]
        (Element.text details.body)


code : String -> Element msg
code snippet =
    Element.el
        [ Element.Background.color
            (Element.rgba 0 0 0 0.04)
        , Element.Border.rounded 2
        , Element.paddingXY 5 3
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
                , name = "Source Code Pro"
                }
            ]
        ]
        (Element.text snippet)


heading :
    { level : Block.HeadingLevel
    , rawText : String
    , children :
        List (Element msg)
    }
    -> Element msg
heading { level, rawText, children } =
    Element.paragraph
        [ Font.size
            (case level of
                Block.H1 ->
                    36

                Block.H2 ->
                    28

                _ ->
                    20
            )
        , Font.bold
        , Font.family [ Font.typeface "Roboto" ]
        , Element.paddingEach { bottom = 0, left = 0, right = 0, top = 15 }
        , Element.Region.heading (Block.headingLevelToInt level)
        , Element.htmlAttribute
            (Html.Attributes.attribute "name" (rawTextToId rawText))
        , Element.htmlAttribute
            (Html.Attributes.id (rawTextToId rawText))
        ]
        children


rawTextToId rawText =
    rawText
        |> String.split " "
        |> String.join "-"
        |> String.toLower
