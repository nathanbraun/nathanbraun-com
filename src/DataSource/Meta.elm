module DataSource.Meta exposing (Meta, empty)

import Date exposing (Date)
import Route
import Time exposing (Month(..))


type alias Meta =
    { title : String
    , description : String
    , rss : Bool
    , date : Date
    , route : Route.Route
    }


empty : Meta
empty =
    { title = "empty"
    , description = "empty"
    , rss = False
    , route = Route.SPLAT__ { splat = [ "empty" ] }
    , date = Date.fromCalendarDate 1970 Jan 1
    }
