module Evergreen.V6.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V6.Route
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , route : Evergreen.V6.Route.Route
    , moreDropdownActive : Bool
    , loginActive : Bool
    , showPassword : Bool
    , userNameText : String
    , passwordText : String
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NavigateTo String
    | ToggleMoreDropdown Bool
    | ToggleLogin Bool
    | ToggleShowPassword Bool
    | TypedUsername String
    | TypedPassword String
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
