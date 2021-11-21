module Evergreen.Migrate.V6 exposing (..)

import Evergreen.V3.Types as Old
import Evergreen.V6.Route exposing (Route)
import Evergreen.V6.Types as New
import Lamdera.Migrations exposing (..)
import Route


frontendModel : Old.FrontendModel -> ModelMigration New.FrontendModel New.FrontendMsg
frontendModel old =
    ModelMigrated
        ( { key = old.key
          , route = Route.Home
          , moreDropdownActive = False
          , loginActive = False
          , showPassword = False
          , userNameText = ""
          , passwordText = ""
          }
        , Cmd.none
        )


backendModel : Old.BackendModel -> ModelMigration New.BackendModel New.BackendMsg
backendModel old =
    ModelUnchanged


frontendMsg : Old.FrontendMsg -> MsgMigration New.FrontendMsg New.FrontendMsg
frontendMsg old =
    case old of
        Old.UrlClicked x ->
            MsgMigrated ( New.UrlClicked x, Cmd.none )

        Old.UrlChanged x ->
            MsgMigrated ( New.UrlChanged x, Cmd.none )

        Old.NavigateTo x ->
            MsgMigrated ( New.NavigateTo x, Cmd.none )

        Old.ToggleMoreDropdown x ->
            MsgMigrated ( New.ToggleMoreDropdown x, Cmd.none )

        Old.ToggleLogin x ->
            MsgMigrated ( New.ToggleLogin x, Cmd.none )

        Old.ToggleShowPassword x ->
            MsgMigrated ( New.ToggleShowPassword x, Cmd.none )

        Old.TypedUsername x ->
            MsgMigrated ( New.TypedUsername x, Cmd.none )

        Old.TypedPassword x ->
            MsgMigrated ( New.TypedPassword x, Cmd.none )

        Old.Increment ->
            MsgOldValueIgnored

        Old.Decrement ->
            MsgOldValueIgnored

        Old.NoOpFrontendMsg ->
            MsgMigrated ( New.NoOpFrontendMsg, Cmd.none )


toBackend : Old.ToBackend -> MsgMigration New.ToBackend New.BackendMsg
toBackend old =
    MsgUnchanged


backendMsg : Old.BackendMsg -> MsgMigration New.BackendMsg New.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Old.ToFrontend -> MsgMigration New.ToFrontend New.FrontendMsg
toFrontend old =
    MsgUnchanged
