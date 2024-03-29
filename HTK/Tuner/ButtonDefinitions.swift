import SwiftUI



// This defines the style of the button label
struct keyboardButtonLabelStyle: ButtonStyle {

    var fontSize : CGFloat
    var fontName : String
    var textColor : UIColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Color(textColor))
            .font(.custom(fontName, size: fontSize))
    }
}






func getColor (colour: String) -> UIColor
{
    
    let black = UIColor(.black)
//    let black = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)

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


extension Color {
    static let lblue1 =  Color( UIColor (red: 38/255.0, green: 49/255.0, blue: 197/255.0, alpha: 0.5))
    static let lblue2 = Color  ( UIColor(red: 38/255.0, green: 49/255.0, blue: 197/255.0, alpha: 0.7))
    static let lblue3 =  Color   (UIColor(red: 38/255.0, green: 49/255.0, blue: 190/255.0, alpha: 0.9))
    static let lorange1  = Color   (  UIColor(red: 255/255.0, green: 150/255.0, blue: 75/255.0, alpha: 0.8))
    static let lgreen    = Color   (  UIColor(red: 0/255.0, green: 150/255.0, blue: 75/255.0, alpha: 0.4))
    static let blowColor = Color   (  UIColor(red: 1.0, green:1.0, blue: 0.717, alpha: 1.0))
    static let drawColor = Color   (  UIColor(red: 1.0, green:0.8, blue: 0.417, alpha: 0.7))
 
}

extension UIColor{
    class func getCustomBlueColor() -> UIColor{
        return UIColor(red:0.043, green:0.576 ,blue:0.588 , alpha:1.00)
    }
}


struct KeyboardButton {
    var buttonId : Int = 0; // button
    var offset : Int? = nil; // offset
    var wingdings : String? = nil; // wingDings
    var backColor : UIColor? = nil; // background
    var displayed : String? = nil; // displayType
    var textColor : UIColor? = nil; // Text Colour
    var boilerplate : String? = nil; // Text displayed
    var buttonLabel : String? = nil; // Text displayed
    var fontSize : Int = 10; // text size
    
}

struct KeyboardButton2 : Codable {
    var buttonId : Int = 0; // button
    var offset : Int = 0; // offset
    var wingdings : String? = nil; // wingDings
    
    var backColor : String? = nil; // background
    var displayed : String? = nil; // displayed Y/N
    var textColor : String? = nil; // Text Colour
    //var foreColor : UIColor? = nil; // Text Colour
    var boilerplate : String? = nil; // Text displayed

    
}

// Uses a PLIST to get the current button definitions
// Runs in dynamic or static mode.
// in dynamic mode (call type = dynamic) displayed for the note being played is set to P which highlights the button
/*
func getButtonDefs(note: Int, callType: String, harmonicaBase: Int, sharpsFlats: Int) -> [KeyboardButton]{ //Type is not used
    
    var _buttonDefns = [KeyboardButton]() //Declare empty array
    var thisButton : KeyboardButton
    //let notes2 = getNotes(flatsSharps: sharpsFlats)
    let pianoNotes = setupPiano().getPianoFromJSON()
    
    if let harpDef = NSArray(contentsOfFile: AUTO_PLIST_HARPDEF_PATH!) {
        
        
        for plistData in harpDef {
            
            
            guard let dict = plistData as? [String: AnyObject] else {continue}
            //let dict2 = plistData as? KeyboardButton2 //else {continue}
            
            
            //print ("D2***")
            //print ("DICT2: ", dict2, type(of: dict2))
            //print  ("BackColor" , dict2?.backColor)
            
            
            thisButton = KeyboardButton (   buttonId: (dict["button"] as? Int)!,
                                            offset: (dict["offset"] as? Int)!,
                                            wingdings: (dict["wingDings"] as? String)!,
                                            backColor: getColor (colour: (dict["background"] as? String ?? "white")),
                                            displayed: dict["displayed"] as? String,
                                            textColor: getColor (colour: (dict["textColor"] as? String ?? "white")),
                                            boilerplate: dict["boilerplate"] as? String
                                            )
            
            
            // labels for boilerplate buttons
            if thisButton.displayed == "B" {
                thisButton.buttonLabel = thisButton.boilerplate
                
            }
            
            // labels for Playing buttons
            else if thisButton.displayed == "1" {
                
                let holeNote =  notesBase + thisButton.offset! + harmonicaBase // B-Maj harmonica gives note 102, C-maj shows rest
                
                
           
                if sharpsFlats == 0 {
                    thisButton.buttonLabel = pianoNotes[holeNote].noteNameFlats
                    
                    
                }
                else {
                    thisButton.buttonLabel = pianoNotes[holeNote].noteNameSharps
                    //thisButton.buttonLabel = String(pianoNotes[holeNote].pianoKey)
                }


                //print ("noteName in buttondefs : ", notes[holeNote].noteName!)
                
                // The note being played currently
                if  holeNote == note  && callType == "dynamic" && thisButton.buttonId != 103 && thisButton.buttonId != 207  { //Not for buttons that play the same note as the main buttons
                    print ("Setting to P For : ", holeNote, pianoNotes[holeNote].pianoKey)
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
     
}*/
