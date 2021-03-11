port module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events


port startAudioRecording : String -> Cmd msg


port stopAudioRecording : String -> Cmd msg


port startVideoRecording : String -> Cmd msg


port stopVideoRecording : String -> Cmd msg



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
    | StartVideoRecording
    | StopVideoRecording


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        StartAudioRecording ->
            ( { model | action = Just "Audio recording" }, startAudioRecording "" )

        StopAudioRecording ->
            ( { model | action = Just "Audio stopped" }, stopAudioRecording "" )

        StartVideoRecording ->
            ( { model | action = Just "Video recording" }, startVideoRecording "" )

        StopVideoRecording ->
            ( { model | action = Just "Video stopped" }, stopVideoRecording "" )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , Html.h1 [] [ Html.text (model.action |> Maybe.withDefault "") ]
        , Html.hr [] []
        , Html.button [ Html.Events.onClick StartAudioRecording ] [ Html.text "Record Audio" ]
        , Html.button [ Html.Events.onClick StopAudioRecording ] [ Html.text "Stop Audio Recording" ]
        , Html.div [ Html.Attributes.attribute "id" "recordings" ] []
        , Html.hr [] []
        , Html.video
            [ Html.Attributes.attribute "id" "preview"
            , Html.Attributes.attribute "autoplay" ""
            , Html.Attributes.attribute "mute" ""
            , Html.Attributes.attribute "width" "480"
            , Html.Attributes.attribute "height" "320"
            , Html.Attributes.attribute "style" "width: 480px; height: 320px"
            ]
            []
        , Html.video
            [ Html.Attributes.attribute "id" "recording"
            , Html.Attributes.attribute "width" "480"
            , Html.Attributes.attribute "height" "320"
            , Html.Attributes.attribute "style" "width: 480px; height: 320px"
            ]
            []
        , Html.button [ Html.Events.onClick StartVideoRecording ] [ Html.text "Start Video Recording" ]
        , Html.button [ Html.Events.onClick StopVideoRecording ] [ Html.text "Stop Video Recording" ]
        , Html.div [ Html.Attributes.attribute "id" "video-recordings" ] []
        , Html.hr [] []
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
