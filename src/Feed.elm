module Feed exposing (fileToGenerate)

import HtmlStringMarkdownRenderer
import Json.Decode as Decode exposing (Decoder)
import Metadata exposing (Metadata(..))
import Pages
import Pages.PagePath as PagePath exposing (PagePath)
import Rss


fileToGenerate :
    { siteTagline : String
    , siteUrl : String
    }
    ->
        List
            { path : PagePath Pages.PathKey
            , frontmatter : Metadata
            , body : String
            }
    ->
        { path : List String
        , content : String
        }
fileToGenerate config siteMetadata =
    { path = [ "feed.xml" ]
    , content = generate config siteMetadata
    }


generate :
    { siteTagline : String
    , siteUrl : String
    }
    ->
        List
            { path : PagePath Pages.PathKey
            , frontmatter : Metadata
            , body : String
            }
    -> String
generate { siteTagline, siteUrl } siteMetadata =
    Rss.generate
        { title = "Nathan Braun"
        , description = siteTagline
        , url = "https://nathanbraun.com"
        , lastBuildTime = Pages.builtAt
        , generator = Just "Nathan Braun"
        , items = siteMetadata |> List.filterMap metadataToRssItem
        , siteUrl = siteUrl
        }


metadataToRssItem :
    { path : PagePath Pages.PathKey
    , frontmatter : Metadata
    , body : String
    }
    -> Maybe Rss.Item
metadataToRssItem page =
    case page.frontmatter of
        Article article ->
            if article.draft then
                Nothing

            else
                Just
                    { title = article.title
                    , description = article.description
                    , url = PagePath.toString page.path
                    , categories = []
                    , author = "Nathan Braun"
                    , pubDate = Rss.Date article.published
                    , content = Nothing
                    , enclosure = Nothing
                    , contentEncoded =
                        page.body
                            |> HtmlStringMarkdownRenderer.renderMarkdown
                            |> Result.toMaybe
                    }

        _ ->
            Nothing


bodyDecoder : String -> Decoder String
bodyDecoder body =
    case HtmlStringMarkdownRenderer.renderMarkdown body of
        Ok renderedBody ->
            Decode.succeed renderedBody

        Err error ->
            Decode.fail error
