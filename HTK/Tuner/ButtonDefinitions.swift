import SwiftUI






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
let black =     UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
let white =     UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
let lblue1 =    UIColor(red: 38/255.0, green: 49/255.0, blue: 197/255.0, alpha: 0.5) // sRGB
let lblue2 =    UIColor(red: 38/255.0, green: 49/255.0, blue: 197/255.0, alpha: 0.7) // sRGB
let lblue3 =    UIColor(red: 38/255.0, green: 49/255.0, blue: 190/255.0, alpha: 0.9) // sRGB
let lorange1 =  UIColor(red: 255/255.0, green: 150/255.0, blue: 75/255.0, alpha: 0.8) // sRGB
let orange =    UIColor(red: 255/255.0, green: 150/255.0, blue: 75/255.0, alpha: 0.8) // sRGB
let green =     UIColor(red: 0/255.0, green: 150/255.0, blue: 75/255.0, alpha: 1.0) // sRGB
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


/// The following two structs could be merged
///  The merger needs to conform as for interfaceButton
///
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




struct KeyboardButton {
    
    /// 7 Attributes fron richterHarmonica plist
    var button : Int; /// Identifier
    var offset : Int? = nil; // offset
    var wingdings : String? = nil; // wingDings
    var backColor : UIColor? = nil; // background
    var displayed : String? = nil; // displayed Y/N
    var textColor : UIColor? = nil; // Text Colour
    var boilerplate : String? = nil; // Text displayed
    
    ///    Added by GetButtonDefns
    ///    Uses a calculation based on the other values
    var buttonLabel : String? = nil; // Text displayed
}





// Uses a PLIST to get the current button definitions
// Runs in dynamic or static mode.
// in dynamic mode (call type = dynamic) displayed for the note being played is set to P which highlights the button
func getButtonDefs(note: String, callType: String, harmonicaBase: Int, sharpsFlats: Int) -> [KeyboardButton]{ //Type is not used
    
    var _buttonDefns = [KeyboardButton]() //Declare empty array
    var thisButton : KeyboardButton
    let notes = getNotes(flatsSharps: sharpsFlats)
    
    /// Plist data structure is restrictive but flexible.
    
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

            /// Move all the functionality below to button array script
                        
            /// Boilerplate buttons
            if thisButton.displayed == "B" {
                thisButton.buttonLabel = thisButton.boilerplate
            }
            
            /// Playing buttons
            else if thisButton.displayed == "1" {
                
                let holeNote =  notesBase + thisButton.offset! + harmonicaBase
                
                thisButton.buttonLabel = notes[holeNote].noteName! as String
                
                /// The note being played currently
                if notes[holeNote].noteNameSharps! == note  && callType == "dynamic" && thisButton.button != 103 && thisButton.button != 207  { //Not for buttons that play the same note as the main buttons
                        
                    thisButton.displayed = "P"
                        
                    }
            }
            
            /// History buttons
            else if thisButton.displayed == "H"  {
                thisButton.buttonLabel = thisButton.wingdings
            }
            
            else {
                thisButton.buttonLabel = "NA" // changed
            }
            
                _buttonDefns.append(thisButton)
        }
    }
    
    return _buttonDefns
     
}


// The following two structs could be merged
///  The merger needs to conform as for interfaceButton
///
struct newInterfaceButton  : View, Identifiable, Hashable {
    
    
    // Function to conform to equatable
    static func == (lhs: newInterfaceButton, rhs: newInterfaceButton) -> Bool {
        return
        
        lhs.Tag == rhs.Tag
        && lhs.displayedType == rhs.displayedType
        && lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.wingdings == rhs.wingdings
    }
    
    
    var id = UUID() // Variable to satisfy Identifiable
    
    
    
    // variable parameters  passed from Array
    
    var rowNo: Int
    var colNo: Int
    var Tag: Int
    
    var buttonColor: UIColor
    var textColor: UIColor
    
    var displayedType: String
    var offset: Int
    
    var title: String
    var wingdings: String
    var boilerplate: String
    
    
    
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
                .buttonStyle (displayedType == "H" ? historyButtonStyle : ( displayedType == "1" ? playingButtonStyle : (displayedType == "B" ? BoilerplateButtonStyle : (displayedType == "P" ? NotePlayingButtonStyle : NotDisplayed))))
                .tag (rowNo * 100 + colNo)
                .background(displayedType == "P" ? .black  : Color(buttonColor))
                .clipped()
            
        }
        else {
            // Fallback on earlier versions
        }
    }
    
}
   
