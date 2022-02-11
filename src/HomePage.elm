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
--view model =
 --   level_1 model

type alias Model = List Category
initialModel : Model
initialModel =
    [
        categoryOne,
        categoryTwo,
        categoryThree,
        categoryFour
    ]

type Msg = OptionButtonClicked Category | OptionSelectClicked Category Option | ClickedOutside
update : Msg -> Model -> Model
update msg model =
    List.map (respond msg) model

respond : Msg -> Category -> Category
respond msg cat =
    case msg of
        ClickedOutside ->
            cat
        OptionButtonClicked category ->
            if cat.name == category.name then
                {cat | dropdownStatus = not cat.dropdownStatus}
            else
                cat
        OptionSelectClicked category option ->
            if cat.name == category.name then
                {cat | options = (changeStateOfOptions option cat.options)}
            else
                cat


changeStateOfOptions : Option -> Options -> Options
changeStateOfOptions option option_s =
    List.map (changeStateOfOption option) option_s

changeStateOfOption : Option -> Option -> Option
changeStateOfOption optionSelected option =
    if optionSelected.text == option.text then
        {option | status = not option.status}
    else
        option

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

view model = div [class "level_1_container", onClick (ClickedOutside)] (List.map makeCategory model)

makeCategory : Category -> Html Msg
makeCategory category =
        div divStyle [
                         h1 [] [text category.name]
                        -- Maybe implement here what the category paragraph must contain
                        -- ,p [] [text category.text]
                        ,p [] [text (showSelectedOptions category.options)]
                        ,button [onClick (OptionButtonClicked category)] [text "Options"]
                        --,div dropDownStyle (showOptions category.dropdownStatus category.options)
                        ,makeDropdown category

                     ]
showSelectedOptions : Options -> String
showSelectedOptions option_s =
    String.join ", " (List.map (\option -> option.text) (List.filter (\option -> option.status) option_s))
dropDownStyle = [relativePosition_style, onTop_style, white_style, dropdown_width_style, border_style, dropdown_scroll_style, dropdown_height_style]


showOptions : Category -> List (Html Msg)
showOptions category =
    if category.dropdownStatus then
        List.map (makeParagraphFromOption category) category.options
    else
        []

makeDropdown : Category -> Html Msg
makeDropdown category =
    if category.dropdownStatus then
        div dropDownStyle (showOptions category)
    else
        div [] []

makeParagraphFromOption : Category -> Option -> Html Msg
makeParagraphFromOption category option =
    p [onClick (OptionSelectClicked category option), optionColor option.status] [text option.text]

optionColor : Bool -> (Html.Attribute msg)
optionColor status =
    if status then
        style "background-color" "blue"
    else
        style "background-color" "white"



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
