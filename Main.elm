module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit)


type alias Model =
    { email : String
    , message : String
    , submitting : Bool
    }


initialModel : Model
initialModel =
    { email = ""
    , message = ""
    , submitting = False
    }


type Msg
    = InputEmail String
    | InputMessage String
    | Submit


main : Program Never Model Msg
main =
    program
        { init = ( initialModel, Cmd.none )
        , update = update
        , subscriptions = \model -> Sub.none
        , view = view
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputEmail e ->
            ( { model | email = String.toLower e }, Cmd.none )

        InputMessage m ->
            ( { model | message = m }, Cmd.none )

        Submit ->
            ( { model | submitting = True }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        header =
            div [] [ h1 [] [ text "Contact us" ] ]

        body model =
            div []
                [ div [] [ input [ (value model.email), type_ "email", placeholder "your email", onInput InputEmail ] [] ]
                , div [] [ textarea [ rows 7, placeholder "your message", onInput InputMessage ] [ text model.message ] ]
                ]

        footer =
            div [] [ button [] [ text "Submit" ] ]
    in
        Html.form
            [ onSubmit Submit ]
            [ header, body model, footer, div [] [ model |> toString |> text ] ]
