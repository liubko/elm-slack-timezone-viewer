module App exposing (..)

import Config
import Timezone exposing (timezones, Timezone)
import Html exposing (Html, text, div, img, ul, li)
import Html.Attributes exposing (src, style)
import Http
import Json.Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (..)


type alias User =
    { id : String
    , name : String
    , presence : String
    , tzOffset : Float
    , image : String
    }


type alias Model =
    { users : List User
    , fetchUsersError : String
    , timezones : List Timezone
    }


initialModel : Model
initialModel =
    { users = []
    , fetchUsersError = ""
    , timezones = timezones
    }


init : String -> ( Model, Cmd Msg )
init _ =
    ( initialModel, fetchUsers )


responseDecoder : Decoder (List User)
responseDecoder =
    let
        userDecoder =
            decode User
                |> required "id" Json.Decode.string
                |> optional "real_name" Json.Decode.string ""
                |> optional "presence" Json.Decode.string ""
                |> optional "tz_offset" Json.Decode.float 0
                |> optionalAt [ "profile", "image_72" ] Json.Decode.string ""
    in
        Json.Decode.at [ "members" ] (Json.Decode.list userDecoder)



---- UPDATE ----


type Msg
    = FetchUsers
    | HandleFetchUsersResponse (Result Http.Error (List User))


fetchUsers : Cmd Msg
fetchUsers =
    let
        url =
            "https://slack.com/api/users.list?presence=true&token="
                ++ Config.slackToken

        request =
            Http.get url responseDecoder
    in
        Http.send HandleFetchUsersResponse request


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchUsers ->
            ( { model | fetchUsersError = "" }, fetchUsers )

        HandleFetchUsersResponse (Ok users) ->
            let
                normalizedUsers =
                    users
                        |> List.filter (\user -> String.length user.name > 0)
                        |> List.sortBy .tzOffset
                        |> List.map (\user -> { user | tzOffset = user.tzOffset / 3600 })
            in
                ( { model | users = normalizedUsers, fetchUsersError = "" }, Cmd.none )

        HandleFetchUsersResponse (Err err) ->
            let
                _ =
                    Debug.log "Can't fetch users" err
            in
                ( { model | fetchUsersError = "Can't fetch users :(" }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ (renderError model.fetchUsersError)
        , ul [] (List.map (\timezone -> renderTimezone timezone model.users) model.timezones)
        ]


renderError : String -> Html Msg
renderError err =
    div []
        [ text err
        ]


renderTimezone : Timezone -> List User -> Html Msg
renderTimezone timezone users =
    li []
        [ div []
            [ text (timezone.text ++ " ")
            ]
        , div
            []
            (List.map renderUser (getUsersInTimeZone timezone.offset users))
        ]


renderUser : User -> Html Msg
renderUser user =
    let
        textColor =
            if user.presence == "active" then
                "green"
            else
                "red"
    in
        div
            [ style [ ( "color", textColor ) ] ]
            [ text (user.name ++ " ")
            , img [ src user.image ] []
            ]



---- PROGRAM ----


getUsersInTimeZone : Float -> List User -> List User
getUsersInTimeZone tzOffset users =
    List.filter (\user -> user.tzOffset == tzOffset) users


main : Program String Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
