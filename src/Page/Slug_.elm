module Page.Slug_ exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import DataSource.File as StaticFile
import DataSource.Glob as Glob exposing (Glob)
import Head
import Head.Seo as Seo
import Html.Styled as Html exposing (Html)
import Markdown.Block as Block exposing (Block)
import Markdown.Parser
import Markdown.Renderer
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import TailwindMarkdownRenderer
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    { slug : String }


page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = data
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    content |> DataSource.map (List.map (\x -> RouteParams x.slug))


data : RouteParams -> DataSource Data
data routeParams =
    DataSource.map Data (pageBody routeParams)


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    { body : List (Html Msg) }


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = "test title"
    , body = static.data.body
    }


type alias Section =
    { filePath : String
    , slug : String
    }


content : DataSource (List Section)
content =
    Glob.succeed Section
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
        |> Glob.toDataSource


pageBody : RouteParams -> DataSource (List (Html msg))
pageBody routeParams =
    routeParams
        |> filePathDataSource
        |> DataSource.andThen
            (withoutFrontmatter TailwindMarkdownRenderer.renderer)


withoutFrontmatter :
    Markdown.Renderer.Renderer view
    -> String
    -> DataSource (List view)
withoutFrontmatter renderer filePath =
    (filePath
        |> StaticFile.bodyWithoutFrontmatter
        |> DataSource.andThen
            (\rawBody ->
                rawBody
                    |> Markdown.Parser.parse
                    |> Result.mapError (\_ -> "Couldn't parse markdown.")
                    |> DataSource.fromResult
            )
    )
        |> DataSource.andThen
            (\blocks ->
                blocks
                    |> Markdown.Renderer.render renderer
                    |> DataSource.fromResult
            )


filePathDataSource : RouteParams -> DataSource String
filePathDataSource routeParams =
    Glob.expectUniqueMatch (findBySlug routeParams.slug)


findBySlug : String -> Glob String
findBySlug slug =
    Glob.succeed identity
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/")
        |> Glob.match (Glob.literal slug)
        |> Glob.match (Glob.literal ".md")
