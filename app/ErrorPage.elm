module ErrorPage exposing
    ( ErrorPage(..)
    , Model
    , Msg
    , head
    , init
    , internalError
    , notFound
    , statusCode
    , update
    , view
    )

import DataSource.Meta
import Effect exposing (Effect)
import Head
import Html.Styled as Html exposing (Html, text)
import Route exposing (Route(..))
import View exposing (View)


type Msg
    = Increment


type alias Model =
    { count : Int
    }


init : ErrorPage -> ( Model, Effect Msg )
init errorPage =
    ( { count = 0 }
    , Effect.none
    )


update : ErrorPage -> Msg -> Model -> ( Model, Effect Msg )
update errorPage msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Effect.none )


head : ErrorPage -> List Head.Tag
head errorPage =
    []


type ErrorPage
    = NotFound
    | InternalError String


notFound : ErrorPage
notFound =
    NotFound


internalError : String -> ErrorPage
internalError =
    InternalError


view : ErrorPage -> Model -> View Msg
view error model =
    let
        { title, content } =
            errorToHtml error
    in
    { title = title
    , content = [ content ]
    , route = SPLAT__ { splat = [ "404" ] }
    , published = True
    , meta = DataSource.Meta.empty
    }


statusCode : ErrorPage -> number
statusCode error =
    case error of
        NotFound ->
            404

        InternalError _ ->
            500


errorToHtml : ErrorPage -> { title : String, content : Html msg }
errorToHtml error =
    case error of
        NotFound ->
            { title = "404"
            , content = text "404 not found!"
            }

        InternalError str ->
            { title = "Internal error"
            , content = text <| "Internal error: " ++ str
            }
