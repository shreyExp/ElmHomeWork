module HomePage exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser


main = 
    Browser.sandbox
    {
         init = initialModel
        ,view = view
        ,update = update
    }

-- put the super container in the model
view model =
    level_1 model

type alias Model = List Category
initialModel : Model
initialModel =
    [
        categoryOne,
        categoryTwo,
        categoryThree,
        categoryFour
    ]

-- type Msg = Clicked String| NotClicked String
-- type Event = optionButtonClicked | optionSelectClicked
-- type alias Msg = {event: Event, category: Category, option: Option}
type alias Msg = {name: String}
update : Msg -> Model -> Model
update msg model =
    List.map (respond msg) model

respond : Msg -> Category -> Category
respond msg cat =
    if msg.name == cat.name then
        Category cat.name (not cat.dropdownStatus) cat.options (makeText cat.dropdownStatus)
    else
        cat

makeText : Bool -> String
makeText status =
    if status then
        ""
    else
        ""
        
type alias Option = {status: Bool, text: String}
type alias Options = List Option
type alias Category = {name: String, dropdownStatus: Bool, options: Options, text: String}

categoryOne = Category "CategoryOne" False options ""
categoryTwo = Category "CategoryTwo" False options ""
categoryThree = Category "CategoryThree" False options ""
categoryFour = Category "CategoryFour" False options ""

options : Options
options = List.map makeOption (List.range 1 10)
makeOption : Int -> Option
makeOption num = Option False ("Option " ++ (String.fromInt num))

level_1 model = div [class "level_1_container"] (List.map makeCategory model)

makeCategory : Category -> Html Msg
makeCategory category =
        div divStyle [ 
                         h1 [] [text category.name]
                        ,button [onClick (Msg category.name)] [text "Options"]
                        --,div dropDownStyle (showOptions category.dropdownStatus category.options)
                        ,makeDropdown category
                        ,p [] [text category.text]

                     ]
dropDownStyle = [relativePosition_style, onTop_style, white_style, dropdown_width_style, border_style, dropdown_scroll_style, dropdown_height_style]

showOptions : Bool -> Options -> List (Html Msg)
showOptions dropdownStatus option_s =
    if dropdownStatus then
        List.map makeParagraphFromOption option_s
    else
        []

makeDropdown : Category -> Html Msg
makeDropdown category =
    if category.dropdownStatus then
        div dropDownStyle (showOptions category.dropdownStatus category.options)
    else
        div [] []

makeParagraphFromOption : Option -> Html Msg
makeParagraphFromOption option =
    p [] [text option.text]

divStyle = [margin_style, border_style, height_style]


margin_style = style "margin" "5px"
margin_bottom_style = style "margin-bottom" "30px"
border_style = style "border" "solid 1px"
half_width_style = style "width" "49%"
inline_style = style "display" "inline-block"
red_style = style "background-color" "blue"
white_style = style "background-color" "white"
green_style = style "color" "green"
height_style = style "height" "200px"
onTop_style = style "z-index" "10"
relativePosition_style = style "position" "relative"
dropdown_width_style = style "width" "100px"
dropdown_height_style = style "height" "50%"
dropdown_scroll_style = style "overflow-y" "scroll"

paragraph = p []
    [ text "Hi How are you doing"]
