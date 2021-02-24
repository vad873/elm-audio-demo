port module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events


port startRecording : String -> Cmd msg


port stopRecording : String -> Cmd msg


port helloWorld : String -> Cmd msg



---- MODEL ----


type alias Model =
    { action : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { action = Nothing }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | StartRecording
    | StopRecording


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        StartRecording ->
            ( { model | action = Just "recording" }, startRecording "" )

        StopRecording ->
            ( { model | action = Just "stopped" }, stopRecording "" )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , Html.button [ Html.Events.onClick StartRecording ] [ Html.text "Record" ]
        , Html.button [ Html.Events.onClick StopRecording ] [ Html.text "Stop" ]
        , Html.div [] [ Html.text (model.action |> Maybe.withDefault "") ]
        , Html.div [ Html.Attributes.attribute "id" "recordings" ] []
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
