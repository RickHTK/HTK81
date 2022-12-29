
//import UIKit
import SwiftUI

func getNotes( flatsSharps: Int) -> [Notes]{
    
    var _notes = [Notes]()
    
    if _notes.count > 0 {
        return _notes
    }
    
    if let allData = NSArray(contentsOfFile: AUTO_PLIST_NOTES_PATH!) {
        
        for dict in allData {
            guard let dict = dict as? [String: AnyObject] else {continue}
            let notes = Notes()
            notes.pianoKey = dict["pianoKey" ] as? Int // pianoKey
            notes.noteNameSharps = dict["noteNameSharps"] as? String // noteName
            notes.noteNameFlats = dict["noteNameFlats"] as? String // noteName
            if flatsSharps == 1 {
                notes.noteName = notes.noteNameSharps
            }
            else {
                notes.noteName = notes.noteNameFlats
                
            }
            //print ("This Note: ", notes.noteName, notes.noteNameSharps, notes.noteNameFlats)
            notes.frequency = (dict["frequency"] as? NSString)?.floatValue // frequency
            _notes.append(notes)
            notes.defaultAction = dict["defaultAction"] as! Int
        }
    }
    return _notes
}

func getColor (colour: String) -> UIColor
{
    
let black = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
let lblue1 = UIColor(red: 38/255.0, green: 49/255.0, blue: 197/255.0, alpha: 0.5) // sRGB
let lblue2 = UIColor(red: 38/255.0, green: 49/255.0, blue: 197/255.0, alpha: 0.7) // sRGB
let lblue3 = UIColor(red: 38/255.0, green: 49/255.0, blue: 190/255.0, alpha: 0.9) // sRGB
let lorange1 = UIColor(red: 255/255.0, green: 150/255.0, blue: 75/255.0, alpha: 0.8) // sRGB
let orange = UIColor(red: 255/255.0, green: 150/255.0, blue: 75/255.0, alpha: 0.8) // sRGB
let green = UIColor(red: 0/255.0, green: 150/255.0, blue: 75/255.0, alpha: 1.0) // sRGB
let lgreen = UIColor(red: 0/255.0, green: 150/255.0, blue: 75/255.0, alpha: 0.4) // sRGB
let blowColor = UIColor(red: 1.0, green:1.0, blue: 0.717, alpha: 1.0) // sRGB
let drawColor = UIColor(red: 1.0, green:0.8, blue: 0.417, alpha: 0.7) // sRGB


var colourRet : UIColor
switch colour
{
case "white":
    colourRet = white
case "black":
    colourRet = black
case "lblue1":
    colourRet = lblue1
case "lblue2":
    colourRet = lblue2
case "lblue3":
    colourRet = lblue3
case "orange":
    colourRet = orange
case "lorange1":
    colourRet = lorange1
case "green":
    colourRet = green
case "lgreen":
    colourRet = lgreen
case "blowColor":
    colourRet = blowColor
case "drawColor":
    colourRet = drawColor
default:
    colourRet = white
}
return colourRet
}


struct KeyboardButton {
    var button : Int = 0; // button
    var offset : Int? = nil; // offset
    var wingdings : String? = nil; // wingDings
    //var background : String? = nil; // background
    var backColor : UIColor? = nil; // background
    var displayed : String? = nil; // displayed Y/N
    var textColor : UIColor? = nil; // Text Colour
    //var foreColor : UIColor? = nil; // Text Colour
    var boilerplate : String? = nil; // Text displayed
    var buttonLabel : String? = nil; // Text displayed
    var fontSize : Int = 10; // text size
    
}

// Uses a PLIST to get the current button definitions
// Runs in dynamic or static mode.
// in dynamic mode (call type = dynamic) displayed for the note being played is set to P which highlights the button
func getButtonDefs(note: String, callType: String, harmonicaBase: Int, sharpsFlats: Int) -> [KeyboardButton]{ //Type is not used
    
    var _buttonDefns = [KeyboardButton]() //Declare empty array
    var thisButton : KeyboardButton
    let notes = getNotes(flatsSharps: sharpsFlats)
    
    if let allData = NSArray(contentsOfFile: AUTO_PLIST_HARPDEF_PATH!) {
        
        
        for dict in allData {
            
            guard let dict = dict as? [String: AnyObject] else {continue}
            
            thisButton = KeyboardButton (   button: (dict["button"] as? Int)!,
                                            offset: (dict["offset"] as? Int)!,
                                            wingdings: (dict["wingDings"] as? String)!,
                                            backColor: getColor (colour: (dict["background"] as? String ?? "white")),
                                            displayed: dict["displayed"] as? String,
                                            textColor: getColor (colour: (dict["textColor"] as? String ?? "white")),
                                            boilerplate: dict["boilerplate"] as? String
                                            )
            
            
            // Boilerplate buttons
            if thisButton.displayed == "B" {
                thisButton.buttonLabel = thisButton.boilerplate
                
            }
            
            // Playing buttons
            else if thisButton.displayed == "1" {
                
                let holeNote =  notesBase + thisButton.offset! + harmonicaBase // B-Maj harmonica gives note 102, C-maj shows rest
                //let holeNote =  harmonica_base  + harmonicaBase // B-Maj harmonica gives note 102, C-maj shows rest
                
                //do {
                thisButton.buttonLabel = notes[holeNote].noteName! as String //try
                //} catch {}

                //print ("noteName in buttondefs : ", notes[holeNote].noteName!)
                
                // The note being played currently
                if notes[holeNote].noteNameSharps! == note  && callType == "dynamic" && thisButton.button != 103 && thisButton.button != 207  { //Not for buttons that play the same note as the main buttons
                        
                    thisButton.displayed = "P"
                        
                    }
            }
            
            // History buttons
            else if thisButton.displayed == "H"  {
                thisButton.buttonLabel = thisButton.wingdings
            }
            
            else {
                thisButton.buttonLabel = "NA" // changed
            }
            //if callType != "static" && buttonDefns.button != 103 && buttonDefns.button != 207 {
                _buttonDefns.append(thisButton)
                
            //}
        }
    }
    
    return _buttonDefns
     
}





// This defines the style of the button label
struct keyboardButtonLabelStyle: ButtonStyle {

    var fontSize : CGFloat
    var fontName :String
    var textColor : UIColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Color(textColor))
            .font(.custom(fontName, size: fontSize))
    }
}


// HARMONICA BUTTON
// These are the buttons in the keyboard below



struct interfaceButton  : View, Identifiable, Hashable {
    
    
    // Function to conform to equatable
    static func == (lhs: interfaceButton, rhs: interfaceButton) -> Bool {
        return
        
            lhs.Tag == rhs.Tag
        && lhs.displayed == rhs.displayed
        && lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.wingdings == rhs.wingdings
    }
    
    
    var id = UUID() // Variable to satisfy Identifiable
    
    //var nonDisplayedColor : UIColor = .white
    
    // variable parameters  passed from Array
    var buttonColor: UIColor // = .blue
    var textColor: UIColor // = .black
    var title: String
    var wingdings: String
    var rowNo: Int
    var colNo: Int
    var Tag: Int
    var displayed: String
    
    
    //var fontType: Bool = true
    
    // Function to conform to hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(Tag)
    }
    
    

    var body: some View {
        
        let historyButtonStyle = keyboardButtonLabelStyle (fontSize: 24, fontName: "Wingdings2", textColor: textColor)
        let playingButtonStyle = keyboardButtonLabelStyle (fontSize: 20, fontName: "AppleSymbols", textColor: textColor)
        let BoilerplateButtonStyle = keyboardButtonLabelStyle (fontSize: 11, fontName: "", textColor: textColor)
        let NotDisplayed = keyboardButtonLabelStyle (fontSize: 14, fontName: "", textColor: textColor)
        let NotePlayingButtonStyle = keyboardButtonLabelStyle (fontSize: 20, fontName: "AppleSymbols", textColor: .white)
        
        if #available(iOS 15.0, *) {
        Button {}
            
        // This is the label text shown on the button
        label: { Text (title)}
            .frame ( minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .center )
            .buttonStyle (displayed == "H" ? historyButtonStyle : ( displayed == "1" ? playingButtonStyle : (displayed == "B" ? BoilerplateButtonStyle : (displayed == "P" ? NotePlayingButtonStyle : NotDisplayed))))
            .tag (rowNo * 100 + colNo)
            .background(displayed == "P" ? .black  : Color(buttonColor))
            .clipped()
            
        }
        else {
            // Fallback on earlier versions
        }
    }
}





// KEYBOARD
// View of the Harmonica being played recieves the note being played by the conductor (state object)
// Called by Tuner

func buttonArray (note: String, noteHistory : [noteDetail] , position : Int, harmonicaBase : Int, sharpsFlats : Int, mode : Int, register : Int, translationMap : [Int : Int] ) -> [[interfaceButton]] {
    
    let buttonColumns = [0,1,2,3,4,5,6,7,8,9,10,11]
    let actionRows = [1,2,3,4,5,6,7,8]
    var buttonArray : [[interfaceButton]] = [[]]
    var buttonRow : [interfaceButton] = []
    var buttonRow2 : [interfaceButton] = []
    let buttonKey = getButtonDefs(note: note, callType: "dynamic", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
    let staticButtonKey = getButtonDefs(note: note, callType: "static", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
    
    
    print ("Note ", note)
    
    // Creates the Array of buttons
    // 1. Creates a grid
    
    for rowValue in actionRows {
        
        for columnValue in buttonColumns {
            
            let buttonTagNo = (rowValue * 100) + columnValue
            
            let chosenButton = (
                buttonKey.first (where: {$0.button == buttonTagNo})
                                   )
            
            let currentButton = interfaceButton (buttonColor: chosenButton!.backColor!,
                                                 textColor: chosenButton!.textColor!,
                                                 title: (chosenButton?.buttonLabel)!,
                                                 wingdings: chosenButton!.wingdings!,
                                                 rowNo: rowValue,
                                                 colNo: columnValue,
                                                 Tag: rowValue * 100 + columnValue,
                                                 displayed: chosenButton!.displayed!
            )
            buttonRow.append (currentButton)
            
        }
        buttonArray.append( buttonRow)
        buttonRow = []
    }
    
    // 2. Adds the notes played  buttons at the bottom
    for (index, playedNote) in noteHistory.enumerated() {
        // This is the history of notes played
        guard let chosenButton = (
            staticButtonKey.first (where: {$0.buttonLabel! == playedNote.note && $0.button != 103 && $0.button != 207 }) //there is more than one button for the same note 103, 107
        ) else {
            print ("NOT FOUND!", playedNote)
            continue
        }
        
        let currentButton = interfaceButton (buttonColor: chosenButton.backColor!,
                                             textColor: chosenButton.textColor!,
                                             title: (chosenButton.wingdings)!,
                                             wingdings: chosenButton.wingdings!,
                                             rowNo: 9,
                                             colNo: 99,
                                             Tag: 900 + index,
                                             displayed: "H"
        )
        buttonRow.append (currentButton)
        
        // 3. adds the Translate  button  row at the bottom
        if position != 0 {
        
            guard let translationButton = (
                //staticButtonKey.first (where: {$0.button == standardPosMapping[chosenButton.button]![position]})
                staticButtonKey.first (where: {$0.button == translationMap[chosenButton.button] ?? 9999})
            ) else {print ("NOT FOUND!"); continue}
            
            
            
            let currentTranslationButton = interfaceButton (buttonColor: translationButton.backColor!,
                                                 textColor: translationButton.textColor!,
                                                 title: (translationButton.wingdings)!,
                                                 wingdings: translationButton.wingdings!,
                                                 rowNo: 10,
                                                 colNo: 99,
                                                 Tag: 1000 + index,
                                                 displayed: "H"
            )
            
            buttonRow2.append (currentTranslationButton)
        }
        else {
            buttonRow2.append (
                interfaceButton (buttonColor: .white,
                                 textColor: .white,
                                 title: "",
                                 wingdings: "",
                                 rowNo: 10,
                                 colNo: 99,
                                 Tag: 1000 + index,
                                 displayed: "N"
                                 )
            
            )
            }
        
    } // END OF LOOP
    
    buttonArray.append(buttonRow)
    buttonArray.append(buttonRow2)
    
    return buttonArray
}

//KEYBOARD Calls Button Array -- Called by Tuner View
func keyboard2 (buttonArray: [[interfaceButton]]) -> some View {
    
    var body: some View {
        VStack (spacing: 3) {
            
            ForEach (buttonArray, id:\.self) { buttonRow in
                HStack (spacing: 3) {
                    ForEach(buttonRow, id:\.self) { buttonKey in
                        buttonKey
                    } // END OF INNER LOOP
                    
                }// END OF HSTACK

        } //END OF OUTER LOOP
            
    } //END OF VSTACK
        
    
}

return body

}

