module Theme.All exposing (htmlMapping)

import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (css)
import Markdown.Html
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Types
    exposing
        ( ButtonAction(..)
        , GlobalData
        , Model
        , Msg(..)
        , SharedMsg(..)
        )


htmlMapping :
    Model
    -> GlobalData
    ->
        Markdown.Html.Renderer
            (List (Html Msg)
             -> Html Msg
            )
htmlMapping model _ =
    Markdown.Html.oneOf
        [
        ]
