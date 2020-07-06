module Form exposing (view)

import Element exposing (Element)
import Html
    exposing
        ( Html
        , button
        , div
        , form
        , h2
        , img
        , input
        , label
        , p
        , text
        , textarea
        )
import Html.Attributes
    exposing
        ( alt
        , attribute
        , class
        , for
        , method
        , name
        , placeholder
        , rows
        , src
        , type_
        , value
        )
import Pages
import Pages.ImagePath as ImagePath


view : List (Html msg) -> Html msg
view _ =
    form
        [ name "contact"
        , method "POST"
        , attribute "data-netlify" "true"
        , attribute "data-netlify-honeypot" "bot-field"
        , class "form flex -j-center -i-center max-w-40 w-90 mx-auto px-sm-5 mb-5 py-5"
        ]
        [ input [ class "input py-1 px-2", type_ "hidden", name "form-name", value "contact" ] []
        , formField <|
            inputWithLabel "email" "" "Email"
        , formField <|
            button [ type_ "submit", class "button bg-primary fs-6 w-100" ]
                [ text "Contact"
                ]
        ]


formField : Html msg -> Html msg
formField child =
    div [ class "pt-2 w-100 mb-2" ] [ child ]


inputWithLabel : String -> String -> String -> Html msg
inputWithLabel idName placeholderText title =
    div [ class "w-100 br-2" ]
        [ label [ for idName, class "w-100 text-light text-bold fs-5 label" ] [ text title ]
        , div [ class "mt-1 relative rounded-md shadow-sm" ]
            [ input
                [ name idName
                , class "input py-1 px-2 b-lightgrey fs-5 w-100"
                , placeholder placeholderText
                ]
                []
            ]
        ]
