module MarkdownCodec exposing
    ( PageMetadata
    , frontmatterDecoder
    , pageBody
    , pageBodyByRoute
    , pageBodyBySplat
    , withFrontmatter
    )

import DataSource exposing (DataSource)
import DataSource.File as StaticFile
import DataSource.Glob as Glob exposing (Glob)
import Html.Styled as Html exposing (Html)
import Markdown.Block exposing (Block)
import Markdown.Parser
import OptimizedDecoder exposing (Decoder)
import Shared
import TailwindMarkdownRenderer


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


frontmatterDecoder : OptimizedDecoder.Decoder PageMetadata
frontmatterDecoder =
    OptimizedDecoder.map PageMetadata
        (OptimizedDecoder.field "title" OptimizedDecoder.string)


type alias PageMetadata =
    { title : String
    }


pageBodyBySplat :
    { route | splat : List String }
    ->
        (PageMetadata
         ->
            (Shared.Model
             -> List (Html msg)
            )
         -> value
        )
    -> DataSource value
pageBodyBySplat routeParams constructor =
    Glob.expectUniqueMatch (findBySplat routeParams.splat)
        |> DataSource.andThen
            (withFrontmatter
                constructor
                frontmatterDecoder
                TailwindMarkdownRenderer.render
            )


pageBodyByRoute :
    { route | slug : String }
    ->
        (PageMetadata
         ->
            (Shared.Model
             -> List (Html msg)
            )
         -> value
        )
    -> DataSource value
pageBodyByRoute routeParams constructor =
    Glob.expectUniqueMatch (findBySlug routeParams.slug)
        |> DataSource.andThen
            (withFrontmatter
                constructor
                frontmatterDecoder
                TailwindMarkdownRenderer.render
            )


pageBody :
    (PageMetadata
     ->
        (Shared.Model
         -> List (Html msg)
        )
     -> value
    )
    -> DataSource value
pageBody constructor =
    Glob.expectUniqueMatch (findBySlug "index")
        |> DataSource.andThen
            (withFrontmatter
                constructor
                frontmatterDecoder
                TailwindMarkdownRenderer.render
            )


findBySlug : String -> Glob String
findBySlug slug =
    Glob.succeed identity
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/")
        |> Glob.match (Glob.literal slug)
        |> Glob.match (Glob.literal ".md")


findBySplat : List String -> Glob String
findBySplat splat =
    Glob.succeed identity
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/")
        |> Glob.match (Glob.literal (String.join "/" splat))
        |> Glob.match (Glob.literal ".md")
