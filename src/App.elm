module App exposing (..)

import Config
import Timezone exposing (timezones, Timezone)
import Html exposing (Html, text, div, img, ul, li, section, h1, h2, footer, p, strong, a, i, span)
import Html.Attributes exposing (src, style, class, href)
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
    div [ class "page-layout" ]
        [ renderHeader
        , renderContent model
        , renderFooter
        ]


renderContent : Model -> Html Msg
renderContent model =
    section []
        [ (renderError model.fetchUsersError)
        , div [] (List.map (\timezone -> renderTimezone timezone model.users) model.timezones)
        ]


renderError : String -> Html Msg
renderError err =
    div []
        [ text err
        ]


renderHeader : Html Msg
renderHeader =
    section [ class "hero is-info is-bold" ]
        [ div [ class "hero-body" ]
            [ div [ class "container" ]
                [ h1 [ class "title" ]
                    [ text "Primary title" ]
                , h2 [ class "subtitle" ]
                    [ text "Primary subtitle" ]
                ]
            ]
        ]


renderFooter : Html Msg
renderFooter =
    footer [ class "footer" ]
        [ div [ class "container" ]
            [ div [ class "content has-text-centered" ]
                [ p []
                    [ strong []
                        [ text "Bulma by" ]
                    , a [ href "http://jgthms.com" ]
                        [ text "Jeremy Thomas. The source code is licensed" ]
                    , a [ href "http://opensource.org/licenses/mit-license.php" ]
                        [ text "MIT. The website content\n        is licensed" ]
                    , a [ href "http://creativecommons.org/licenses/by-nc-sa/4.0/" ]
                        [ text "CC ANS 4.0." ]
                    ]
                , p []
                    [ a [ class "icon", href "https://github.com/jgthms/bulma" ]
                        [ i [ class "fa fa-github" ]
                            []
                        ]
                    ]
                ]
            ]
        ]


renderTimezone : Timezone -> List User -> Html Msg
renderTimezone timezone users =
    div [ class "card" ]
        [ div [ class "columns card-content" ]
            [ div [ class "column is-one-quarter" ]
                [ p [ class "title" ]
                    [ text timezone.utc ]
                , p [ class "subtitle" ]
                    [ text timezone.text ]
                ]
            , div [ class "column tile is-ancestor" ]
                (List.map renderUser (getUsersInTimeZone timezone.offset users))
            ]
        ]


renderUser : User -> Html Msg
renderUser user =
    let
        textColor =
            if user.presence == "active" then
                "green"
            else
                "red"

        -- style [ ( "color", textColor ) ]
    in
        div [ class "tile" ]
            [ img [ src user.image ]
                []
            , strong []
                [ text user.name ]
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
