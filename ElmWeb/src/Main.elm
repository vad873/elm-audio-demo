port module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events


port startAudioRecording : String -> Cmd msg


port stopAudioRecording : String -> Cmd msg



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
    | StartAudioRecording
    | StopAudioRecording


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        StartAudioRecording ->
            ( { model | action = Just "Audio recording" }, startAudioRecording "" )

        StopAudioRecording ->
            ( { model | action = Just "Audio stopped" }, stopAudioRecording "" )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , Html.button [ Html.Events.onClick StartAudioRecording ] [ Html.text "Record" ]
        , Html.button [ Html.Events.onClick StopAudioRecording ] [ Html.text "Stop" ]
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
