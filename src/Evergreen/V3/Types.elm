module Evergreen.V3.Types exposing (..)

import Browser
import Browser.Navigation
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : String
    , counter : Int
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
    | Increment
    | Decrement
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
