module Page.Slug_ exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import DataSource.File as StaticFile
import DataSource.Glob as Glob exposing (Glob)
import Head
import Head.Seo as Seo
import Html.Styled as Html exposing (Html)
import Markdown.Block exposing (Block)
import Markdown.Parser
import Markdown.Renderer
import OptimizedDecoder exposing (Decoder)
import Page exposing (Page, StaticPayload)
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


type alias Data =
    { metadata : PageMetadata
    , body : Shared.Model -> List (Html Msg)
    }


type alias PageMetadata =
    { title : String
    }


type alias Route =
    { filePath : String
    , slug : String
    }


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
    pageBody routeParams


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head _ =
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


frontmatterDecoder : OptimizedDecoder.Decoder PageMetadata
frontmatterDecoder =
    OptimizedDecoder.map PageMetadata
        (OptimizedDecoder.field "title" OptimizedDecoder.string)


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view _ sharedModel static =
    { title = "test title"
    , body = static.data.body sharedModel
    }


content : DataSource (List Route)
content =
    Glob.succeed Route
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
        |> Glob.toDataSource


pageBody : RouteParams -> DataSource Data
pageBody routeParams =
    routeParams
        |> filePathDataSource
        |> DataSource.andThen
            (withFrontmatter
                Data
                frontmatterDecoder
                renderer2
            )


withFrontmatter :
    (frontmatter -> (Shared.Model -> List (Html msg)) -> value)
    -> Decoder frontmatter
    -> (List Block -> DataSource (Shared.Model -> List (Html msg)))
    -> String
    -> DataSource value
withFrontmatter constructor frontmatterDecoder2 renderer filePath =
    DataSource.map2 constructor
        (StaticFile.onlyFrontmatter
            frontmatterDecoder2
            filePath
        )
        ((StaticFile.bodyWithoutFrontmatter
            filePath
            |> DataSource.andThen
                (\rawBody ->
                    rawBody
                        |> Markdown.Parser.parse
                        |> Result.mapError (\_ -> "Couldn't parse markdown.")
                        |> DataSource.fromResult
                )
         )
            |> DataSource.andThen
                renderer
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


renderer2 : List Block -> DataSource (Shared.Model -> List (Html msg))
renderer2 blocks =
    blocks
        |> Markdown.Renderer.render TailwindMarkdownRenderer.renderer
        |> Result.map
            (\blockViews model ->
                blockViews
                    |> renderAll model
            )
        |> DataSource.fromResult


renderAll : model -> List (model -> view) -> List view
renderAll model =
    List.map ((|>) model)
