module Effect exposing
    ( Effect(..), batch, fromCmd, map, none, perform
    , pushUrl
    )

{-|

@docs Effect, batch, fromCmd, map, none, perform

-}

-- import Interop exposing (IncomingData(..), OutgoingData(..), TaggedValue)

import Browser.Navigation
import Form
import Http
import Json.Decode as Decode
import Pages.Fetcher
import Types exposing (Model)
import Url exposing (Url)


{-| -}
type Effect msg
    = None
    | Cmd (Cmd msg)
    | Batch (List (Effect msg))
    | PushUrl String
    | SetField { formId : String, name : String, value : String }
    | FetchRouteData
        { data : Maybe FormData
        , toMsg : Result Http.Error Url -> msg
        }
    | Submit
        { values : FormData
        , toMsg : Result Http.Error Url -> msg
        }
    | SubmitFetcher (Pages.Fetcher.Fetcher msg)


{-| -}
type alias RequestInfo =
    { contentType : String
    , body : String
    }


{-| -}
none : Effect msg
none =
    None


pushUrl : String -> Effect msg
pushUrl url =
    PushUrl url


{-| -}
batch : List (Effect msg) -> Effect msg
batch =
    Batch


{-| -}
fromCmd : Cmd msg -> Effect msg
fromCmd =
    Cmd


{-| -}
map : (a -> b) -> Effect a -> Effect b
map fn effect =
    case effect of
        None ->
            None

        Cmd cmd ->
            Cmd (Cmd.map fn cmd)

        Batch list ->
            Batch (List.map (map fn) list)

        PushUrl url ->
            PushUrl url

        FetchRouteData fetchInfo ->
            FetchRouteData
                { data = fetchInfo.data
                , toMsg = fetchInfo.toMsg >> fn
                }

        Submit fetchInfo ->
            Submit
                { values = fetchInfo.values
                , toMsg = fetchInfo.toMsg >> fn
                }

        SetField info ->
            SetField info

        SubmitFetcher fetcher ->
            fetcher
                |> Pages.Fetcher.map fn
                |> SubmitFetcher



-- sendOut : OutgoingData -> Effect msg
-- sendOut info =
--     Interop.encodeOut info |> (outgoing >> Cmd)
-- getIncoming : Model -> (IncomingData -> msg) -> (String -> msg) -> Sub msg
-- getIncoming model tagger onError =
--     incoming (Interop.decodeIn { fbCookies = model.fbCookies } tagger onError)


{-| -}
perform :
    { fetchRouteData :
        { data : Maybe FormData
        , toMsg : Result Http.Error Url -> pageMsg
        }
        -> Cmd msg
    , submit :
        { values : FormData
        , toMsg : Result Http.Error Url -> pageMsg
        }
        -> Cmd msg
    , runFetcher :
        Pages.Fetcher.Fetcher pageMsg
        -> Cmd msg
    , fromPageMsg : pageMsg -> msg
    , key : Browser.Navigation.Key
    , setField : { formId : String, name : String, value : String } -> Cmd msg
    }
    -> Effect pageMsg
    -> Cmd msg
perform ({ fromPageMsg, key } as helpers) effect =
    case effect of
        None ->
            Cmd.none

        Cmd cmd ->
            Cmd.map fromPageMsg cmd

        SetField info ->
            helpers.setField info

        Batch list ->
            Cmd.batch (List.map (perform helpers) list)

        PushUrl url ->
            Browser.Navigation.pushUrl key url

        FetchRouteData fetchInfo ->
            helpers.fetchRouteData
                fetchInfo

        Submit record ->
            helpers.submit record

        SubmitFetcher record ->
            helpers.runFetcher record


type alias FormData =
    { fields : List ( String, String )
    , method : Form.Method
    , action : String
    , id : Maybe String
    }



-- port outgoing : TaggedValue -> Cmd msg
-- port incoming : (TaggedValue -> msg) -> Sub msg
