module Theme.Helpers exposing (addId)

import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr


addId : Maybe String -> Attribute msg -> List (Attribute msg)
addId id attr =
    let
        attrId =
            case id of
                Just i ->
                    [ Attr.id i ]

                Nothing ->
                    []
    in
    attr :: attrId
