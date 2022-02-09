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
        "Hello"
        


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

makeCategory x =
        div divStyle [ 
                         h1 [] [text x.name]
                        ,button [onClick (Msg x.name)] [text "Options"]
                        ,div [] (showOptions x.options)
                        ,p [] [text x.text]

                     ]

-- showOptions : Options -> List Html.html
showOptions option_s =
    List.map makeParagraphFromOption option_s

-- makeParagraphFromOption : Option -> Html.html
makeParagraphFromOption option =
    p [] [text option.text]

divStyle = [margin_style, border_style, height_style]


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
