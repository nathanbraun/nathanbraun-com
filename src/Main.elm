module Main exposing (main)

import Color
import Data.Author as Author
import Date
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Font as Font
import Element.Input
import Element.Region
import Feed
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes
import Index
import Json.Decode
import Layout
import Markdown.Block as Block exposing (Block, Inline, ListItem(..), Task(..))
import Markdown.Html
import Markdown.Parser
import Markdown.Renderer
import Metadata exposing (Metadata)
import MySitemap
import Page.Article
import Pages exposing (images, pages)
import Pages.Manifest as Manifest
import Pages.Manifest.Category
import Pages.PagePath exposing (PagePath)
import Pages.Platform
import Pages.StaticHttp as StaticHttp
import Palette


manifest : Manifest.Config Pages.PathKey
manifest =
    { backgroundColor = Nothing
    , categories = [ Pages.Manifest.Category.education ]
    , displayMode = Manifest.Standalone
    , orientation = Manifest.Portrait
    , description = "Nathan Braun's Homepage"
    , iarcRatingId = Nothing
    , name = "Nathan Braun"
    , themeColor = Nothing
    , startUrl = pages.index
    , shortName = Nothing
    , sourceIcon = images.nIcon
    }


type alias Rendered =
    Element Msg


main : Pages.Platform.Program Model Msg Metadata Rendered
main =
    Pages.Platform.init
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , documents = [ markdownDocument ]
        , manifest = manifest
        , canonicalSiteUrl = canonicalSiteUrl
        , onPageChange = Nothing
        , internals = Pages.internals
        }
        |> Pages.Platform.withFileGenerator generateFiles
        |> Pages.Platform.toProgram


generateFiles :
    List
        { path : PagePath Pages.PathKey
        , frontmatter : Metadata
        , body : String
        }
    ->
        StaticHttp.Request
            (List
                (Result String
                    { path : List String
                    , content : String
                    }
                )
            )
generateFiles siteMetadata =
    StaticHttp.succeed
        [ Feed.fileToGenerate
            { siteTagline = siteTagline
            , siteUrl =
                canonicalSiteUrl
            }
            siteMetadata
            |> Ok
        , MySitemap.build { siteUrl = canonicalSiteUrl } siteMetadata |> Ok
        ]


markdownDocument :
    { extension : String
    , metadata :
        Json.Decode.Decoder Metadata
    , body : String -> Result String (Element msg)
    }
markdownDocument =
    { extension = "md"
    , metadata = Metadata.decoder
    , body =
        \markdownBody ->
            -- Html.div [] [ Markdown.toHtml [] markdownBody ]
            Markdown.Parser.parse markdownBody
                |> Result.mapError
                    (\error ->
                        error
                            |> List.map
                                Markdown.Parser.deadEndToString
                            |> String.join "\n"
                    )
                |> Result.andThen (Markdown.Renderer.render elmUiRenderer)
                |> Result.map
                    (Element.column
                        [ Element.width Element.fill
                        , Element.spacing 20
                        ]
                    )
    }


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( Model, Cmd.none )


type alias Msg =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        () ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view :
    List ( PagePath Pages.PathKey, Metadata )
    ->
        { path : PagePath Pages.PathKey
        , frontmatter : Metadata
        }
    ->
        StaticHttp.Request
            { view : Model -> Rendered -> { title : String, body : Html Msg }
            , head : List (Head.Tag Pages.PathKey)
            }
view siteMetadata page =
    StaticHttp.succeed
        { view =
            \model viewForPage ->
                Layout.view (pageView model siteMetadata page viewForPage) page
        , head = head page.frontmatter
        }


pageView :
    Model
    -> List ( PagePath Pages.PathKey, Metadata )
    -> { path : PagePath Pages.PathKey, frontmatter : Metadata }
    -> Rendered
    -> { title : String, body : List (Element Msg) }
pageView model siteMetadata page viewForPage =
    case page.frontmatter of
        Metadata.Page metadata ->
            { title = metadata.title
            , body =
                [ viewForPage
                ]

            --        |> Element.textColumn
            --            [ Element.width Element.fill
            --            ]
            }

        Metadata.Article metadata ->
            Page.Article.view metadata viewForPage

        Metadata.Author author ->
            { title = author.name
            , body =
                [ Palette.blogHeading author.name
                , Author.view [] author
                , Element.paragraph [ Element.centerX, Font.center ] [ viewForPage ]
                ]
            }

        Metadata.BlogIndex ->
            { title = "Nathan Braun's Blog"
            , body =
                [ Element.column [ Element.padding 20, Element.centerX ]
                    [ Index.view siteMetadata
                    ]
                ]
            }


commonHeadTags : List (Head.Tag Pages.PathKey)
commonHeadTags =
    [ Head.sitemapLink "/sitemap.xml"
    ]



{- Read more about the metadata specs:

   <https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/abouts-cards>
   <https://htmlhead.dev>
   <https://html.spec.whatwg.org/multipage/semantics.html#standard-metadata-names>
   <https://ogp.me/>
-}


head : Metadata -> List (Head.Tag Pages.PathKey)
head metadata =
    commonHeadTags
        ++ (case metadata of
                Metadata.Page meta ->
                    Seo.summaryLarge
                        { canonicalUrlOverride = Nothing
                        , siteName = "Nathan Braun's Homepage"
                        , image =
                            { url = images.nIcon
                            , alt = "N"
                            , dimensions = Nothing
                            , mimeType = Nothing
                            }
                        , description = siteTagline
                        , locale = Nothing
                        , title = meta.title
                        }
                        |> Seo.website

                Metadata.Article meta ->
                    Seo.summaryLarge
                        { canonicalUrlOverride = Nothing
                        , siteName = "Nathan Braun's Homepage"
                        , image =
                            { url = meta.image
                            , alt = meta.description
                            , dimensions = Nothing
                            , mimeType = Nothing
                            }
                        , description = meta.description
                        , locale = Nothing
                        , title = meta.title
                        }
                        |> Seo.article
                            { tags = []
                            , section = Nothing
                            , publishedTime =
                                Just
                                    (Date.toIsoString
                                        meta.published
                                    )
                            , modifiedTime = Nothing
                            , expirationTime = Nothing
                            }

                Metadata.Author meta ->
                    let
                        ( firstName, lastName ) =
                            case meta.name |> String.split " " of
                                [ first, last ] ->
                                    ( first, last )

                                [ first, middle, last ] ->
                                    ( first ++ " " ++ middle, last )

                                [] ->
                                    ( "", "" )

                                _ ->
                                    ( meta.name, "" )
                    in
                    Seo.summary
                        { canonicalUrlOverride = Nothing
                        , siteName = "elm-pages-starter"
                        , image =
                            { url = meta.avatar
                            , alt = meta.name ++ "'s elm-pages articles."
                            , dimensions = Nothing
                            , mimeType = Nothing
                            }
                        , description = meta.bio
                        , locale = Nothing
                        , title = meta.name ++ "'s elm-pages articles."
                        }
                        |> Seo.profile
                            { firstName = firstName
                            , lastName = lastName
                            , username = Nothing
                            }

                Metadata.BlogIndex ->
                    Seo.summaryLarge
                        { canonicalUrlOverride = Nothing
                        , siteName = "elm-pages"
                        , image =
                            { url = images.nIcon
                            , alt = "elm-pages logo"
                            , dimensions = Nothing
                            , mimeType = Nothing
                            }
                        , description = siteTagline
                        , locale = Nothing
                        , title = "elm-pages blog"
                        }
                        |> Seo.website
           )


canonicalSiteUrl : String
canonicalSiteUrl =
    "https://nathanbraun.com"


siteTagline : String
siteTagline =
    "Nathan Braun's Homepage"


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


rawTextToId rawText =
    rawText
        |> String.split " "
        |> String.join "-"
        |> String.toLower


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
