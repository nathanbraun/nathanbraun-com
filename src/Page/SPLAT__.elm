module Page.SPLAT__ exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html.Styled as Html exposing (Html)
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Post exposing (PostMetadata)
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    { splat : List String }


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
    Post.contentGlob
        |> DataSource.map
            (List.map
                (\{ subPath, slug } ->
                    RouteParams (subPath ++ [ slug ])
                )
            )


data : RouteParams -> DataSource Data
data routeParams =
    Post.pageBody routeParams.splat Data


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Nathan Braun's Homepage"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = ""
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Nathan Braun's Homepage"
        , locale = Nothing
        , title = "Nathan Braun's Homepage" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    { metadata : PostMetadata
    , body : Shared.Model -> List (Html Msg)
    }


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view _ sharedModel static =
    { title = static.data.metadata.title
    , body = static.data.body sharedModel
    }
