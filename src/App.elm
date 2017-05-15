module App exposing (..)

import Config
import Timezone exposing (timezones, Timezone)
import Html exposing (Html, text, div, img, ul, li, section, h1, h2, footer, p, strong, a, i, span, label, input, header, br, nav)
import Html.Attributes exposing (src, style, class, href, title, type_, checked)
import Html.Events exposing (onClick)
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
    , showEmptyTZ : Bool
    }


initialModel : Model
initialModel =
    { users = []
    , fetchUsersError = ""
    , timezones = timezones
    , showEmptyTZ = False
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
    | ToggleShowEmptyZones


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

        ToggleShowEmptyZones ->
            ( { model | showEmptyTZ = not model.showEmptyTZ }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "page-layout" ]
        [ renderNavbar
        , renderHero
        , renderContent model
        ]


renderContent : Model -> Html Msg
renderContent model =
    section []
        [ (renderError model.fetchUsersError)
        , section [ class "section" ] (List.map (\tz -> renderTZ tz model.users model.showEmptyTZ) model.timezones)
        ]


renderError : String -> Html Msg
renderError err =
    div []
        [ text err
        ]


renderNavbar : Html Msg
renderNavbar =
    nav [ class "nav" ]
        [ div [ class "nav-left" ]
            [ a [ class "nav-item", href "#" ]
                [ text "elm-slack-tz-viewer" ]
            ]
        , div [ class "nav-right nav-menu" ]
            [ a [ class "nav-item", href "https://github.com/liubko/elm-slack-timezone-viewer" ]
                [ span [ class "icon" ] [ i [ class "fa fa-github" ] [] ] ]
            ]
        ]


renderHero : Html Msg
renderHero =
    section [ class "hero is-info is-bold" ]
        [ div [ class "hero-body" ]
            [ div [ class "container" ]
                [ div [ class "columns is-vcentered" ]
                    [ div [ class "column" ] [ p [ class "title" ] [ text "Ahrefs team by TZ" ] ]
                    , div [ class "column is-one-quarter" ]
                        [ div [ class "card settings" ]
                            [ header [ class "card-header" ] [ p [ class "card-header-title" ] [ text "Settings" ] ]
                            , div [ class "card-content" ]
                                [ div [ class "content" ]
                                    [ label [ class "checkbox" ]
                                        [ renderCheckbox ToggleShowEmptyZones "Show empty TZ" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


renderCheckbox : msg -> String -> Html msg
renderCheckbox msg name =
    label []
        [ input [ type_ "checkbox", onClick msg ] []
        , text name
        ]


renderTZ : Timezone -> List User -> Bool -> Html Msg
renderTZ tz users showEmptyTZ =
    let
        usersInTZ =
            getUsersInTZ tz.offset users

        isTZEmpty =
            List.length usersInTZ <= 0

        tzNode =
            div [ class "card" ]
                [ div [ class "card-content" ]
                    [ div [ class "columns card-content" ]
                        [ div [ class "column is-one-quarter" ]
                            [ p [ class "title" ]
                                [ text tz.utc ]
                            , p [ class "subtitle" ]
                                [ text tz.text ]
                            ]
                        , div [ class "column columns is-multiline userList" ]
                            (List.map renderUser usersInTZ)
                        ]
                    ]
                ]
    in
        case ( isTZEmpty, showEmptyTZ ) of
            ( _, True ) ->
                tzNode

            ( False, False ) ->
                tzNode

            ( True, False ) ->
                div [] []


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
        div [ class "user is-narrow column" ]
            [ img [ src user.image ]
                []
            , br [] []
            , span [] [ text user.name ]
            ]



---- PROGRAM ----


getUsersInTZ : Float -> List User -> List User
getUsersInTZ tzOffset users =
    List.filter (\user -> user.tzOffset == tzOffset) users


main : Program String Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
