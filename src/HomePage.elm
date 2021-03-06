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


type Model = Struc {category: Category, otherCategories: Model} | Categories (List Category)
lastTwoCagories = Categories [categoryTwo, categoryThree]
bottomCategories = Struc {category = categoryOne, otherCategories = lastTwoCagories}
initialModel : Model
initialModel = Struc {category = categoryOverAll, otherCategories = bottomCategories}

type Msg = OptionButtonClicked Category | OptionSelectClicked Category Option | ClickedOutside
update : Msg -> Model -> Model
update msg model =
    case model of
        Struc rec ->
            Struc {rec | category = (respond msg rec.category), otherCategories = (update msg rec.otherCategories)}
        Categories categories ->
            Categories (List.map (respond msg) categories)

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


type alias Option = {status: Bool, text: String}
type alias Options = List Option
type alias Category = {name: String, dropdownStatus: Bool, options: Options, text: String}

categoryOverAll = Category "Overall" False options ""
categoryOne = Category "Category 1" False options ""
categoryTwo = Category "Category 2" False options ""
categoryThree = Category "Category 3" False options ""

options : Options
options = List.map makeOption (List.range 1 10)
makeOption : Int -> Option
makeOption num = Option False ("Option " ++ (String.fromInt num))

-- view model = div [class "level_1_container", onClick (ClickedOutside)] (List.map makeCategory model)
view model = div [class "level_1_container", onClick (ClickedOutside)] [createDivsFromModel 1000 model]


createDivsFromModel : Int -> Model -> Html Msg
createDivsFromModel height model =
    case model of
        Struc rec ->
            div (divStyle height) [makeCategory (height//2) rec.category, createDivsFromModel (height//2) rec.otherCategories]
        Categories categories ->
            div (divStyle height) (List.map (makeBottomCategory (height)) categories)


makeCategory : Int -> Category -> Html Msg
makeCategory height category =
        div (divStyle height) [
                        contentSection category
                        ,optionsSection category
                     ]
makeBottomCategory : Int -> Category -> Html Msg
makeBottomCategory height category =
    div (lowerDivStyle  height) [
         contentSection category
         ,optionsSection category
        ]

contentSection : Category -> Html Msg
contentSection category =
    div contentSectionStyle [
                            h1 [] [text category.name]
                            ,p [] [text (showSelectedOptions category.options)]
                            ]

optionsSection : Category -> Html Msg
optionsSection category =
    div optionsSectionStyle [optionsButton category, makeDropdown category]

optionsButton : Category -> Html Msg
optionsButton category =
    -- button [onClick (OptionButtonClicked category)] [text "Compare"]
    div [onClick (OptionButtonClicked category), roundBorder_style, margin_style, grayColor] [text "Compare"]

grayColor = style "background-color" "#999999"
shadowStyle = style "box-shadow" "3px 3px 3px 3px  #888888"


showSelectedOptions : Options -> String
showSelectedOptions option_s =
    String.join ", " (List.map (\option -> option.text) (List.filter (\option -> option.status) option_s))

-- dropdown
dropDownStyle = [white_style, dropdown_width_style, dropdown_scroll_style, dropdown_height_style, relativePosition_style, onTop_style, shadowStyle]
optionsSectionStyle = [optionsSection_width_style, floatRight_style, optionsSection_height_style]
contentSectionStyle = [contentSection_width_style, floatLeft_style, verticalAlign]
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
        --div dropDownStyle []

makeParagraphFromOption : Category -> Option -> Html Msg
makeParagraphFromOption category option =
    p [onClick (OptionSelectClicked category option), optionColor option.status] [text option.text]

optionColor : Bool -> (Html.Attribute msg)
optionColor status =
    if status then
        style "background-color" "blue"
    else
        style "background-color" "white"

divStyle height = [border_style, (height_style height), displayGrid_style, roundBorder_style]
lowerDivStyle height = [margin_style, half_width_style, border_style, (height_style height), inline_style, roundBorder_style]

displayGrid_style = style "display" "grid | inline-grid"
roundBorder_style = style "border-radius" "20px"

margin_bottom_style = style "margin-bottom" "30px"
margin_style = style "margin" "5px"
border_style = style "border" "solid 1px"
half_width_style = style "width" "49.5%"
inline_style = style "display" "inline-block"
red_style = style "background-color" "blue"
white_style = style "background-color" "white"
height_style height =
    style "height" ((String.fromInt height) ++ "px")

onTop_style = style "z-index" "10"
relativePosition_style = style "position" "relative"
dropdown_width_style = style "width" "100%"
dropdown_height_style = style "height" "80%"
dropdown_scroll_style = style "overflow-y" "scroll"
optionsSection_width_style = style "width" "12%"
contentSection_width_style = style "width" "87%"
contentSection_height_style = style "height" "100%"
optionsSection_height_style = style "height" "100%"
floatTop_style = style "float" "top"
floatRight_style = style "float" "right"
floatLeft_style = style "float" "left"
verticalAlign = style "veritcal-align" "top"
