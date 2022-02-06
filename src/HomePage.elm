module HomePage exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

main =
    view "dummy model" -- the model that we pass to view function is "dummy model"

-- put the super container in the model
view model =
    level_1

level_1 = div [class "level_1_container"][ category_one_container, other_categories_container ]

category_one_container = div category_1_properties [paragraph, dropdown]
other_categories_container = div [class "level_2_container"] other_categories
other_categories = [category_two, category_three, category_four]

type Msg = Increment | Decrement

dropdown = button [onClick Decrement] [text "Click me"]
category_two = div category_2_properties [paragraph]
category_three = div category_3_properties [paragraph]
category_four = div category_4_properties [paragraph]


category_1_properties = [class "level_2_container", id "category_one", margin_style, margin_bottom_style, height_style, border_style]
category_2_properties = [class "level_3_container", border_style, margin_style, height_style]
category_3_properties = [class "level_4_container", half_width_style, inline_style, border_style, margin_style, height_style]
category_4_properties = [class "level_4_container", half_width_style, inline_style, border_style, margin_style, height_style]

margin_style = style "margin" "5px"
margin_bottom_style = style "margin-bottom" "30px"
border_style = style "border" "solid 1px"
half_width_style = style "width" "49%"
inline_style = style "display" "inline-block"
red_style = style "background-color" "red"
green_style = style "color" "green"
height_style = style "height" "200px"

paragraph = p []
    [ text "Hi How are you doing"]
