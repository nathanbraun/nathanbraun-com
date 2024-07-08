module View exposing (View, map)

{-|

@docs View, map

-}

import DataSource.Meta exposing (Meta)
import Html.Styled as Html exposing (Html)
import Route exposing (Route)


{-| -}
type alias View msg =
    { title : String
    , content : List (Html msg)
    , route : Route
    , published : Bool
    , meta : Meta
    }


{-| -}
map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn doc =
    { title = doc.title
    , content = List.map (Html.map fn) doc.content
    , route = doc.route
    , published = doc.published
    , meta = doc.meta
    }
