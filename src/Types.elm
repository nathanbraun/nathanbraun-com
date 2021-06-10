module Types exposing (Model, Msg(..), Url, UrlPlus)

import Metadata exposing (Metadata)
import Pages exposing (images, pages)
import Pages.PagePath as PagePath exposing (PagePath)


type alias Model =
    { test : String }


type Msg
    = UrlChange UrlPlus


type alias UrlPlus =
    { path : PagePath Pages.PathKey
    , query : Maybe String
    , fragment : Maybe String
    , metadata : Metadata
    }


type alias Url =
    { path : PagePath Pages.PathKey
    , query : Maybe String
    , fragment : Maybe String
    }
