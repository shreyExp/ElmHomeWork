module HomePage exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)

main =
    view "dummy model"

-- put the super container in the model
view model =
    level_1

level_1 = div [class "level_1_container"][ category_one_container, other_categories_container ]


category_one_container = div [class "level_2_container", id "category_one"] [paragraph]
other_categories_container = div [class "level_2_container"] other_categories
other_categories = [category_two, category_three, category_four]

category_two = div [class "level_3_container"] [paragraph]
category_three = div [class "level_3_container"] [paragraph]
category_four = div [class "level_3_container"] [paragraph]



paragraph = p []
    [ text "Hi How are you doing"]




