module Evergreen.Migrate.V3 exposing (..)

import Evergreen.V1.Types as Old
import Evergreen.V3.Types as New
import Lamdera.Migrations exposing (..)
import Browser.Navigation exposing (..)

frontendModel : Old.FrontendModel -> ModelMigration New.FrontendModel New.FrontendMsg
frontendModel old =
    ModelMigrated
        ( { key = old.key
          , message = old.message
          , counter = old.counter 
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
    MsgMigrated
        ( case old of
            Old.UrlClicked x -> New.UrlClicked x
            Old.UrlChanged x -> New.UrlChanged x
            Old.Increment -> New.Increment
            Old.Decrement -> New.Decrement
            Old.NoOpFrontendMsg -> New.NoOpFrontendMsg
        , Cmd.none
        )

toBackend : Old.ToBackend -> MsgMigration New.ToBackend New.BackendMsg
toBackend old =
    MsgUnchanged


backendMsg : Old.BackendMsg -> MsgMigration New.BackendMsg New.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Old.ToFrontend -> MsgMigration New.ToFrontend New.FrontendMsg
toFrontend old =
    MsgUnchanged