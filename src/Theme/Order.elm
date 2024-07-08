module Theme.Order exposing (view)

import Api.Email exposing (EmailField(..))
import Api.Order
    exposing
        ( Download(..)
        , Gifted(..)
        , OrderPage(..)
        , OrderProduct
        , Redeem(..)
        )
import Api.Site exposing (Site)
import Css
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Html.Styled.Events exposing (onClick, onInput, onSubmit)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Types exposing (Model, Msg(..), SharedMsg(..))


view : Site -> OrderPage -> Html Msg
view site page =
    let
        sport =
            site |> Api.Site.toData
    in
    case page of
        RedeemPage (RedeemTaskFetching id _) ->
            div [] [ text "Getting details about your gift" ]

        RedeemPage (AlreadyRedeemed email) ->
            div []
                [ h3
                    [ css
                        [ Tw.text_2xl
                        , Bp.md
                            [ Tw.text_3xl
                            , Tw.tracking_tight
                            ]
                        , Tw.font_extrabold
                        , Tw.text_color Theme.gray_500
                        , Tw.text_center
                        , Tw.tracking_tight
                        ]
                    ]
                    [ text "This gift has been redeemed" ]
                , div [ css [ Tw.mt_6, Tw.text_color Theme.gray_500 ] ]
                    [ p [ css [ Tw.mb_4 ] ] [ text "This gift was already redeemed." ]
                    , p [ css [ Tw.mt_4 ] ]
                        [ text "If you think you're seeing this in error please email "
                        , a [ Attr.href "mailto:nate@nathanbraun.com", css [ Tw.text_color Theme.blue_600, Tw.underline ] ] [ text "nate@nathanbraun.com" ]
                        , text " and I'll get you squared away ASAP."
                        ]
                    ]
                ]

        RedeemPage RedeemError ->
            div []
                [ h3
                    [ css
                        [ Tw.text_2xl
                        , Bp.md
                            [ Tw.text_3xl
                            , Tw.tracking_tight
                            ]
                        , Tw.font_extrabold
                        , Tw.text_color Theme.gray_500
                        , Tw.text_center
                        , Tw.tracking_tight
                        ]
                    ]
                    [ text "Dang. Something went wrong." ]
                , div [ css [ Tw.mt_6, Tw.text_color Theme.gray_500 ] ]
                    [ p [ css [ Tw.mb_4 ] ] [ text "Unable to get a link to your gift right now." ]
                    , p [ css [ Tw.mt_4 ] ]
                        [ text "If you think you're seeing this in error please email "
                        , a [ Attr.href "mailto:nate@nathanbraun.com", css [ Tw.text_color Theme.blue_600, Tw.underline ] ] [ text "nate@nathanbraun.com" ]
                        , text " and I'll get you squared away ASAP."
                        ]
                    ]
                ]

        RedeemPage (RedeemDetails details email) ->
            div [ css [ Tw.text_color Theme.gray_500 ] ]
                [ h3
                    [ css
                        [ Tw.text_2xl
                        , Bp.md
                            [ Tw.text_3xl
                            , Tw.tracking_tight
                            ]
                        , Tw.font_extrabold
                        , Tw.text_center
                        , Tw.tracking_tight
                        ]
                    ]
                    [ text ("You got " ++ sport.short ++ " as a gift!") ]
                , p [ css [ Tw.mt_6 ] ]
                    [ text (details.buyerName ++ " has bought you a copy of Learn to Code with " ++ sport.name ++ "!") ]
                , p [ css [ Tw.mt_4 ] ]
                    [ text "Enter your email* to get your download link." ]
                , form
                    [ css
                        [ Tw.flex
                        , Tw.flex_wrap
                        , Bp.md [ Tw.flex_nowrap ]
                        , Tw.items_center
                        , Tw.justify_start
                        , Tw.w_full
                        , Tw.mt_8
                        ]
                    , onSubmit (SharedMsg (RedeemGift email details.giftId))
                    ]
                    [ label
                        [ Attr.for "emailAddress"
                        , css []
                        ]
                        []
                    , input
                        [ Attr.id "emailAddress"
                        , Attr.name "email"
                        , Attr.type_ "email"
                        , Attr.attribute "autocomplete" "email"
                        , Attr.required True
                        , Attr.value email
                        , onInput (UpdateEmail RedeemEmail >> SharedMsg)
                        , css
                            [ Tw.w_full
                            , Tw.placeholder_color Theme.gray_500
                            , Tw.border_color Theme.gray_200
                            , Tw.rounded_xl
                            , Tw.py_3
                            , Tw.px_2
                            , Tw.text_base
                            , Tw.mr_2
                            , Css.focus
                                [ Tw.ring_color Theme.indigo_500
                                , Tw.border_color Theme.indigo_500
                                ]
                            ]
                        , Attr.placeholder "Email"
                        ]
                        []
                    , div
                        [ css
                            [ Tw.rounded_md
                            , Tw.shadow
                            , Tw.flex_none
                            , Tw.mx_auto
                            ]
                        ]
                        [ button
                            [ Attr.type_ "submit"
                            , css
                                [ Tw.w_full
                                , Bp.md [ Tw.mt_0 ]
                                , Tw.mt_4
                                , Tw.px_5
                                , Tw.py_3
                                , Tw.text_base
                                , Tw.font_medium
                                , Tw.rounded_md
                                , Tw.text_color Theme.white
                                , Tw.bg_color Theme.blue_500
                                , Tw.font_semibold
                                , Css.focus
                                    [ Tw.outline_none
                                    , Tw.ring_2
                                    , Tw.ring_offset_2
                                    , Tw.ring_color Theme.blue_400
                                    ]
                                , Css.hover
                                    [ Tw.bg_color Theme.blue_600
                                    ]
                                ]
                            ]
                            [ text "Redeem Order" ]
                        ]
                    ]
                , p [ css [ Tw.mt_4 ] ]
                    [ text "Please don't hesitate to reach out (my email is "
                    , a [ Attr.href "mailto:nate@nathanbraun.com", css [ Tw.text_color Theme.blue_600, Tw.underline ] ] [ text "nate@nathanbraun.com" ]
                    , text ") with any questions or issues."
                    ]
                , p [ css [ Tw.mt_4 ] ]
                    [ text "* This is just so I can notify you about any changes (the book includes lifetime updates) and so that you find information about your order and download it again if you ever need to." ]
                ]

        DownloadPage (DownloadFetching _ _) ->
            div [] [ text "Grabbing your download link(s) now" ]

        DownloadPage DownloadError ->
            div []
                [ h3
                    [ css
                        [ Tw.text_2xl
                        , Bp.md
                            [ Tw.text_3xl
                            , Tw.tracking_tight
                            ]
                        , Tw.font_extrabold
                        , Tw.text_color Theme.gray_500
                        , Tw.text_center
                        , Tw.tracking_tight
                        ]
                    ]
                    [ text "Dang. Something went wrong." ]
                , div [ css [ Tw.mt_6, Tw.text_color Theme.gray_500 ] ]
                    [ p [ css [ Tw.mb_4 ] ] [ text "Unable to get a link to your book right now." ]
                    , p [ css [ Tw.mt_4 ] ]
                        [ text "If you think you're seeing this in error please email "
                        , a [ Attr.href "mailto:nate@nathanbraun.com", css [ Tw.text_color Theme.blue_600, Tw.underline ] ] [ text "nate@nathanbraun.com" ]
                        , text " and I'll get you squared away ASAP."
                        ]
                    ]
                ]

        StripePage _ ->
            div [] [ text "Getting details about your order" ]

        PayPalPage _ ->
            div [] [ text "Getting details about your order" ]

        DownloadPage (DownloadDetails customer order) ->
            div [ css [ Tw.text_color Theme.gray_500 ] ]
                [ h3
                    [ css
                        [ Tw.text_2xl
                        , Bp.md
                            [ Tw.text_3xl
                            , Tw.tracking_tight
                            ]
                        , Tw.font_extrabold
                        , Tw.text_center
                        , Tw.tracking_tight
                        ]
                    ]
                    [ text "Thanks for buying!" ]
                , p [ css [ Tw.mb_4, Tw.mt_4 ] ] [ text "Your download link(s) are here:" ]
                , div [] (List.map viewOrder order)
                , p [ css [ Tw.mt_4 ] ]
                    [ text "This has also been sent to "
                    , span [ css [ Tw.italic ] ]
                        [ text customer.email
                        ]
                    ]
                , p [ css [ Tw.mt_4 ] ]
                    [ text "Please don't hesitate to "
                    , a [ Attr.href "mailto:nate@nathanbraun.com", css [ Tw.text_color Theme.blue_600, Tw.underline ] ] [ text "reach out" ]
                    , text " with any questions or issues."
                    ]
                ]

        GiftedPage (GiftTaskFetching _) ->
            div [] [ text "Getting details about your gift" ]

        GiftedPage (GiftDetails giftInfo _) ->
            div [ css [ Tw.text_color Theme.gray_500 ] ]
                [ h3
                    [ css
                        [ Tw.text_2xl
                        , Bp.md
                            [ Tw.text_3xl
                            , Tw.tracking_tight
                            ]
                        , Tw.font_extrabold
                        , Tw.text_center
                        , Tw.tracking_tight
                        ]
                    ]
                    [ text "Your gift is ready to deliver!" ]
                , p [ css [ Tw.mt_6 ] ]
                    [ text "To give it, just send the recipient this link:" ]
                , p [ css [ Tw.mt_4 ] ]
                    [ a [ Attr.href ("/link?id=" ++ giftInfo.giftId), css [ Tw.text_color Theme.blue_600, Tw.underline ] ] [ text (sport.domain ++ "/link?id=" ++ giftInfo.giftId) ]
                    ]
                , p [ css [ Tw.mt_4 ] ]
                    [ text "There they'll be able to enter their email (so they can hear about any updates) and get their own link to the book." ]
                , p [ css [ Tw.mt_4 ] ]
                    [ text "Please don't hesitate to "
                    , a [ Attr.href "mailto:nate@nathanbraun.com", css [ Tw.text_color Theme.blue_600, Tw.underline ] ] [ text "reach out" ]
                    , text " with any questions or issues."
                    ]
                ]

        _ ->
            div [] []


viewOrder : OrderProduct -> Html Msg
viewOrder order =
    div [ css [ Tw.mt_4, Tw.text_color Theme.gray_500 ] ]
        [ a
            [ Attr.href order.download
            , css
                [ Tw.text_color Theme.blue_600, Tw.underline ]
            ]
            [ text order.productName ]
        ]
