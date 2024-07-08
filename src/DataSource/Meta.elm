module DataSource.Meta exposing (Meta, empty)

import Route


type alias Meta =
    { title : String
    , description : String
    , rss : Bool
    , date : String
    , route : Route.Route
    }


empty : Meta
empty =
    { title = "empty"
    , description = "empty"
    , rss = False
    , route = Route.SPLAT__ { splat = [ "empty" ] }
    , date = "empty"
    }
