module Page.Article exposing (view)

import Data.Author as Author
import Date exposing (Date)
import Element exposing (Element)
import Element.Font as Font
import Metadata exposing (ArticleMetadata)
import Pages
import Pages.ImagePath as ImagePath exposing (ImagePath)
import Palette


view : ArticleMetadata -> Element msg -> { title : String, body : List (Element msg) }
view metadata viewForPage =
    { title = metadata.title
    , body =
        [ viewForPage
        ]
    }


publishedDateView : { a | published : Date } -> Element msg
publishedDateView metadata =
    Element.text
        (metadata.published
            |> Date.format "MMMM ddd, yyyy"
        )
