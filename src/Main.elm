module Main exposing (main)

-- import PodcastFeed

import Analytics
import Color
import Data.Author as Author
import Date
import Element exposing (Element)
import Element.Font as Font
import Feed
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes
import Index
import Json.Decode
import Layout
import Markdown.Block as Block exposing (Block, Inline, ListItem(..), Task(..))
import Markdown.Parser
import Markdown.Renderer
import Metadata exposing (Metadata)
import MySitemap
import Page.Article
import Pages exposing (images, pages)
import Pages.Manifest as Manifest
import Pages.Manifest.Category
import Pages.PagePath as PagePath exposing (PagePath)
import Pages.Platform
import Pages.StaticHttp as StaticHttp
import Palette
import Render exposing (elmUiRenderer)


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
    , icons = []
    }


type alias Rendered =
    Element Msg


main : Pages.Platform.Program Model Msg Metadata Rendered Pages.PathKey
main =
    Pages.Platform.init
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , documents = [ markdownDocument ]
        , manifest = manifest
        , canonicalSiteUrl = canonicalSiteUrl
        , onPageChange = Just UrlChange

        -- , onPageChange = Nothing
        , internals = Pages.internals
        }
        |> Pages.Platform.withFileGenerator generateFiles
        -- |> Pages.Platform.withFileGenerator PodcastFeed.generate
        |> Pages.Platform.toProgram



-- onPageChange :
--     { path : PagePath Pages.PathKey
--     , query : Maybe String
--     , fragment : Maybe String
--     }
--     -> Cmd a
-- onPageChange path =
--     Analytics.trackPageNavigation "fantasymath"


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


type alias Url =
    { path : PagePath Pages.PathKey
    , query : Maybe String
    , fragment : Maybe String
    }


type alias UrlPlus =
    { path : PagePath Pages.PathKey
    , query : Maybe String
    , fragment : Maybe String
    , metadata : Metadata
    }



-- init : ( Model, Cmd Msg )
-- init =
--     ( Model, Cmd.none )


init : Maybe { path : Url, metadata : metadata } -> ( Model, Cmd Msg )
init maybeUrl =
    case maybeUrl of
        Nothing ->
            ( Model, Cmd.none )

        Just url ->
            ( Model
            , url.path.path
                |> PagePath.toString
                |> Analytics.trackPageNavigation
            )


type Msg
    = UrlChange UrlPlus


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange url ->
            let
                rawUrlString =
                    PagePath.toString url.path

                urlString =
                    if rawUrlString == "" then
                        "/"

                    else
                        rawUrlString
            in
            ( model
            , Analytics.trackPageNavigation <| urlString
            )



-- subscriptions : Model -> Sub Msg


subscriptions _ _ _ =
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
                            { url = images.nIcon
                            , alt = "N"
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
                        , siteName = "Nathan Braun"
                        , image =
                            { url = meta.avatar
                            , alt = meta.name ++ "'s posts"
                            , dimensions = Nothing
                            , mimeType = Nothing
                            }
                        , description = meta.bio
                        , locale = Nothing
                        , title = meta.name ++ "'s posts"
                        }
                        |> Seo.profile
                            { firstName = firstName
                            , lastName = lastName
                            , username = Nothing
                            }

                Metadata.BlogIndex ->
                    Seo.summaryLarge
                        { canonicalUrlOverride = Nothing
                        , siteName = "Nathan Braun"
                        , image =
                            { url = images.nIcon
                            , alt = "N"
                            , dimensions = Nothing
                            , mimeType = Nothing
                            }
                        , description = siteTagline
                        , locale = Nothing
                        , title = "Nathan Braun"
                        }
                        |> Seo.website
           )


canonicalSiteUrl : String
canonicalSiteUrl =
    "https://nathanbraun.com"


siteTagline : String
siteTagline =
    "Nathan Braun's Homepage"
