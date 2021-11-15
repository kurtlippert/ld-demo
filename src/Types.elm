module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
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
    = UrlClicked UrlRequest
    | UrlChanged Url
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