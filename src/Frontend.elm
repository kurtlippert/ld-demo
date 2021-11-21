module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Content exposing (content)
import Element
    exposing
        ( Element
        , centerX
        , centerY
        , column
        , el
        , fill
        , height
        , layout
        , padding
        , text
        , width
        )
import Lamdera
import Route exposing (Route(..), fromUrl, routeParser)
import Topnav exposing (topNav)
import Types exposing (..)
import Url
import Footer exposing (footer)


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , route = fromUrl url
      , moreDropdownActive = False
      , loginActive = False
      , passwordText = ""
      , userNameText = ""
      , showPassword = False
      }
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( { model | route = fromUrl url } , Cmd.none)

        NavigateTo href ->
            ( model, Nav.pushUrl model.key href )

        ToggleLogin isActive ->
            ( { model | loginActive = isActive }, Cmd.none )

        ToggleMoreDropdown isActive ->
            ( { model | moreDropdownActive = isActive }, Cmd.none )

        ToggleShowPassword isActive ->
            ( { model | showPassword = isActive }, Cmd.none )

        TypedUsername username ->
            ( { model | userNameText = username }, Cmd.none )

        TypedPassword password ->
            ( { model | passwordText = password }, Cmd.none )

        NoOpFrontendMsg ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )



-- view : Model -> Browser.Document FrontendMsg
-- view model =
--     { title = ""
--     , body =
--         [ Html.div [ Attr.style "text-align" "center", Attr.style "padding-top" "40px" ]
--             [ Html.img [ Attr.src "https://lamdera.app/lamdera-logo-black.png", Attr.width 150 ] []
--             , Html.div
--                 [ Attr.style "font-family" "sans-serif"
--                 , Attr.style "padding-top" "40px"
--                 ]
--                 [ Html.text model.message ]
--             , Html.div [ Attr.style "margin" "20px 5px 20px 5px" ]
--                 [ Html.button [ onClick Increment, Attr.style "margin" "10px"] [ Html.text "+" ]
--                 , Html.span [] [ Html.text <| String.fromInt model.counter ]
--                 , Html.button [ onClick Decrement, Attr.style "margin" "10px" ] [ Html.text "-" ]
--                 ]
--             , Html.div [] [ Html.text "Textual change" ]
--             ]
--         ]
--     }


router : FrontendModel -> Element FrontendMsg
router model =
    case model.route of
        About ->
            el [ padding 20, centerX, centerY ] <| text "about"

        Users ->
            el [ padding 20, centerX, centerY ] <| text "users"

        Demo ->
            content model ""

        DemoControl controlName ->
            content model controlName

        NotFound ->
            el [ padding 20, centerX, centerY ] <| text "Not Found"

        _ ->
            el [ padding 20, centerX, centerY ] <| text "generic"


view : Model -> Browser.Document FrontendMsg
view model =
    { title = "Lamdera Demos"
    , body =
        [ layout [ width fill, height fill ] <|
            column [ width fill ]
                [ topNav model
                , router model
                , footer
                ]
        ]
    }
