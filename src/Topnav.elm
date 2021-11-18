module Topnav exposing (..)

import Browser exposing (UrlRequest(..))
import Button exposing (button, button2)
import Element exposing (..)
import Element.Background as Background
import Element.Border exposing (rounded, shadow)
import Element.Events exposing (onClick, onLoseFocus)
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (style)
import Svg.Attributes as SvgAttr
import SvgIcons.RoundedDown exposing (roundedDown)
import Types exposing (FrontendMsg(..), FrontendModel)


topNav : FrontendModel -> Element FrontendMsg
topNav model =
    row
        [ Font.color (Element.rgb 0 0 0)
        , Font.size 18
        , Font.family
            [ Font.typeface "Open Sans"
            , Font.sansSerif
            ]
        , Element.width fill
        , centerX
        , Background.color color.white
        ]
        [ Input.button
            [ alignLeft
            , Element.paddingXY 20 21
            , Font.semiBold
            , focused
                [ Background.color color.white ]
            ]
            { onPress = Just (NavigateTo "/"), label = text "Lamdera Demo" }
        , button [ paddingXY 10 21 ] (text "About") (NavigateTo "/about")
        , button [ paddingXY 10 21 ] (text "Users") (NavigateTo "/users")
        , button [ paddingXY 10 21 ] (text "Demo") (NavigateTo "/demo")
        , el
            [ Element.below <| moreDropdown model ]
            (button
                [ alignRight
                , paddingXY 10 17
                , onLoseFocus <| ToggleMoreDropdown False
                , onClick <| ToggleMoreDropdown <| not model.moreDropdownActive
                ]
                (row
                    []
                    [ text "More"
                    , el
                        [ paddingEach { top = 3, right = 0, bottom = 0, left = 5 } ]
                        (roundedDown <| [ SvgAttr.fill "#483fc7" ])
                    ]
                )
                NoOpFrontendMsg
            )
        , el
            [ Element.below (loginDropdown model), alignRight ]
            (button
                [ alignRight
                , paddingXY 10 21
                , onClick <| ToggleLogin <| not model.loginActive
                ]
                (row [] [ text "Log In" ])
                NoOpFrontendMsg
            )
        ]


moreDropdown model =
    el
        [ alignLeft
        , Element.width <| px 150
        , paddingXY 0 10
        , Background.color color.white
        , shadow { offset = ( 0, 10 ), size = -1, blur = 15, color = color.dropShadow }
        , Element.Border.widthEach { top = 2, right = 0, bottom = 0, left = 0 }
        , Element.Border.solid
        , Element.Border.color <| rgb255 0xDF 0xDF 0xDF
        , transparent <| not model.moreDropdownActive
        ]
    <|
        column [ Element.width fill ]
            [ button [ Font.size 14, paddingXY 10 10, Element.width fill ] (text "First Element") NoOpFrontendMsg
            , button [ Font.size 14, paddingXY 10 10, Element.width fill ] (text "Second Element") NoOpFrontendMsg
            , button [ Font.size 14, paddingXY 10 10, Element.width fill ] (text "Third Element") NoOpFrontendMsg
            ]


loginDropdown model =
    el
        [ alignLeft
        , Element.width <| px 250
        , paddingXY 0 10
        , Background.color color.white
        , moveLeft 179
        , shadow { offset = ( 0, 10 ), size = -1, blur = 15, color = color.dropShadow }
        , Element.Border.widthEach { top = 2, right = 0, bottom = 0, left = 0 }
        , Element.Border.solid
        , Element.Border.color <| rgb255 0xDF 0xDF 0xDF
        , Element.htmlAttribute
            (style "visibility"
                (if model.loginActive then
                    "visible"

                 else
                    "hidden"
                )
            )
        ]
    <|
        column [ Element.width fill ]
            [ el
                [ Font.size 13
                , paddingXY 10 10
                , Element.width fill
                ]
                (Input.text [ Element.width <| maximum 300 fill ]
                    { onChange = TypedUsername
                    , text = model.userNameText
                    , label = Input.labelHidden "username"
                    , placeholder = Just <| Input.placeholder [] <| text "Username"
                    }
                )
            , el
                [ paddingXY 10 10
                , Element.width fill
                ]
                (Input.newPassword [ Element.width <| maximum 300 fill, Font.size 13 ]
                    { onChange = TypedPassword
                    , text = model.passwordText
                    , label = Input.labelHidden "password"
                    , placeholder = Just <| Input.placeholder [] <| text "Password"
                    , show = model.showPassword
                    }
                )
            , Input.checkbox [ Font.size 13, paddingXY 10 10 ]
                { onChange = ToggleShowPassword
                , icon = Input.defaultCheckbox
                , checked = model.showPassword
                , label = Input.labelRight [] <| text "Show password"
                }
            , el [ paddingEach { top = 5, right = 10, bottom = 0, left = 10 } ] <|
                button2
                    [ padding 10
                    , Font.size 13
                    , Element.Border.solid
                    , Element.Border.width 1
                    , Element.Border.color (rgb255 0xC2 0xC5 0xBF)
                    , rounded 3
                    ]
                    (text "Submit")
                    NoOpFrontendMsg
            ]


color =
    { blue = rgb255 0x72 0x9F 0xCF
    , darkCharcoal = rgb255 0x2E 0x34 0x36
    , lightBlue = rgb255 0xC5 0xE8 0xF7
    , lightGrey = rgb255 0xE0 0xE0 0xE0
    , white = rgb255 0xFF 0xFF 0xFF
    , gainsboro = rgb255 0xD4 0xD4 0xD4
    , navBackground = rgb255 0xD4 0xD4 0xD4
    , navHover = rgb255 0xFA 0xFA 0xFA
    , navTextHover = rgb255 0x48 0x5F 0xC7
    , dropShadow = rgba 0.04 0.04 0.04 0.1
    }
