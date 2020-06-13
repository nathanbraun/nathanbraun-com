module Layout exposing (view)

import DocumentSvg
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Font as Font
import Element.Region
import Html exposing (Html)
import Metadata exposing (Metadata)
import Pages
import Pages.Directory as Directory exposing (Directory)
import Pages.ImagePath as ImagePath
import Pages.PagePath as PagePath exposing (PagePath)
import Palette


view :
    { title : String, body : List (Element msg) }
    ->
        { path : PagePath Pages.PathKey
        , frontmatter : Metadata
        }
    -> { title : String, body : Html msg }
view document page =
    { title = document.title
    , body =
        Element.column
            [ Element.width Element.fill
            , Element.Background.color
                (Element.rgb255 245 245 245)
            ]
            [ Element.column
                [ Element.paddingXY 30 35
                , Element.spacing 15
                , Element.Region.mainContent
                , Element.width (Element.fill |> Element.maximum 800)
                , Element.centerX
                ]
                (header page.path
                    :: document.body
                )
            ]
            |> Element.layout
                [ Element.width Element.fill
                , Font.size 18
                , Font.light
                , Font.family [ Font.typeface "IBM Plex Sans" ]
                , Font.color (Element.rgba255 0 0 0 0.8)
                ]
    }


header : PagePath Pages.PathKey -> Element msg
header currentPath =
    Element.column [ Element.width Element.fill, Font.regular ]
        [ Element.row
            [ Element.spaceEvenly
            , Element.width Element.fill
            , Element.Region.navigation
            ]
            (case PagePath.toString currentPath of
                "" ->
                    [ Element.none ]

                _ ->
                    [ Element.link []
                        { url = ""
                        , label =
                            Element.paragraph
                                [ Font.color (Element.rgb255 7 81 219)
                                ]
                                [ Element.text "← Back to Nathan's Homepage" ]
                        }
                    ]
            )
        ]


highlightableLink :
    PagePath Pages.PathKey
    -> Directory Pages.PathKey Directory.WithIndex
    -> String
    -> Element msg
highlightableLink currentPath linkDirectory displayName =
    let
        isHighlighted =
            currentPath |> Directory.includes linkDirectory
    in
    Element.link
        (if isHighlighted then
            [ Font.underline
            , Font.color Palette.color.primary
            ]
         else
            []
        )
        { url = linkDirectory |> Directory.indexPath |> PagePath.toString
        , label = Element.text displayName
        }
