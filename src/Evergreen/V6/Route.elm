module Evergreen.V6.Route exposing (..)


type Route
    = Home
    | About
    | Users
    | Demo
    | DemoControl String
    | UserRoute Int
    | NotFound
