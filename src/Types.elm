module Types exposing
    ( ButtonAction(..)
    , GlobalData
    , Location(..)
    , Model
    , Msg(..)
    , RouteParams
    , SharedMsg(..)
    )

-- import Effect exposing (Effect)

import Elm exposing (alias)
-- import Interop exposing (IncomingData)
import Json.Decode as Decode
import ScrollTo
import Time
import UrlPath exposing (UrlPath)


type Msg
    = OnPageChange
        { path : UrlPath
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg


type SharedMsg
    = ScrollToId String
    | ScrollToMsg ScrollTo.Msg


type alias Model =
    { showMenu : Bool
    , scrollTo : ScrollTo.State
    }


type alias GlobalData =
    { isDev : Bool
    }


type Location
    = Url String
    | Scroll String


type ButtonAction msg
    = GoToUrl String
    | Action msg
    | NoAction


type alias RouteParams =
    { splat : List String }
