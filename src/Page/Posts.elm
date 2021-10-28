module Page.Posts exposing (Data, Model, Msg, page)

import Css
import DataSource exposing (DataSource)
import Date
import Head
import Head.Seo as Seo
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Post
import Route exposing (Route)
import Shared
import Tailwind.Breakpoints as Bp
import Tailwind.Utilities as Tw
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


type alias Data =
    List ( Route, Post.PostMetadata )


data : DataSource Data
data =
    Post.allMetadata


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


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = "all posts"
    , body =
        [ div [ css [] ]
            [ h1
                [ css
                    [ Bp.md [ Tw.text_left, Tw.mx_0, Tw.text_4xl ]
                    , Tw.text_4xl
                    , Tw.mt_6
                    , Tw.mb_6
                    , Tw.font_sans
                    , Tw.font_bold
                    , Tw.font_header
                    , Tw.text_gray_800
                    , Tw.tracking_tight
                    , Tw.text_center
                    ]
                ]
                [ text ("All Posts" ++ " (")
                , a [ Attr.href "/feed.xml", css [ Tw.underline, Tw.text_blue_600 ] ] [ text "RSS Here" ]
                , text ")"
                ]
            , div [ css [ Bp.md [ Tw.mx_0, Tw.space_y_1 ], Tw.mx_3, Tw.space_y_3 ] ]
                (List.map viewPost static.data)
            ]
        ]
    }


viewPost : ( Route, Post.PostMetadata ) -> Html msg
viewPost ( route, info ) =
    div [ css [ Tw.flex ] ]
        [ span [ css [ Tw.hidden, Bp.md [ Tw.inline ] ] ]
            [ text
                (info.published |> Date.format "yyyy-MM-dd")
            ]
        , div [ css [ Tw.flex ] ]
            [ span [ css [ Tw.mx_2 ] ] [ text " - " ]
            , link route
                [ css
                    [ Tw.underline
                    , Tw.text_blue_600
                    , Css.visited [ Tw.text_purple_800 ]
                    ]
                ]
                [ text info.title ]
            ]
        ]


link : Route.Route -> List (Attribute msg) -> List (Html msg) -> Html msg
link route attrs children =
    Route.toLink
        (\anchorAttrs ->
            a
                (List.map Attr.fromUnstyled anchorAttrs ++ attrs)
                children
        )
        route
