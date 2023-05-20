


class setupKeyboard {
    var harmonicaKeyboard : [KeyboardRow]
    var keyboardNotePlaying : Int = 0
    var keyboardCallType: keyDisplayType
    var keyboardHarmonicaBase: Int
    var keyboardSharpsFlats: Int
    let pianoKeyboard = setupPiano().getPianoFromJSON ()
    let keyboardHarmonicaName : String
    
    
    enum harmonicaKeyboardLabelDisplayType : Int {
        case sharps
        case flats
        case pianoKeys
    }

    
    init (pianoKeyPlaying:Int, callType: keyDisplayType, harmonicaBase: Int, harmonicaName: String, sharpsFlats: Int) {
        harmonicaKeyboard = []
        keyboardNotePlaying = pianoKeyPlaying
        keyboardCallType = callType
        keyboardHarmonicaBase = harmonicaBase
        keyboardSharpsFlats = sharpsFlats
        keyboardHarmonicaName = harmonicaName
    }
    
    
    func getHarmonicaFromJSON () throws {
        
        //testdby = htkDB.openDatabase()
        guard let harmonicaStructure = DBFileLoader.readLocalFile("richterHarmonica")
            else {
                fatalError("Unable to locate file \"richterHarmonica.json\" in main bundle.")
        }
        
        let rawHarmonica = DBFileLoader.loadHarmonicaStructureJson(harmonicaStructure)
        harmonicaKeyboard = rawHarmonica.keyboardRows

    }
    
    func getKeyboardDisplayed () -> [[interfaceButton]] {
        
        var displayedKeyboardRow : [interfaceButton] = []
        var displayedKeyboard : [[interfaceButton]] = [[]]
        var buttonLabel : String = ""
        var labelsDisplayed : harmonicaKeyboardLabelDisplayType = .flats
        
        do
        {  try getHarmonicaFromJSON() }
        catch {print ("Failed to get keyboard")}
                
        for thisRow in harmonicaKeyboard {
            
            for (columnNumber , thisButton) in thisRow.keyboardKeys.enumerated() {
                
                print ("DISPLAYING : ", columnNumber, thisButton.displayed)
                
                var thisButtonDisplayed : harmonicaKeyboardDisplayType = thisButton.displayed
                
                /// What is shown on the button
                
                if thisButton.displayed == .boilerplate {
                    buttonLabel = thisButton.boilerplate
                    
                }
                
                // Playing buttons
                else if thisButton.displayed == .playable {
                    
                    let holeNote =  notesBase + thisButton.offset + keyboardHarmonicaBase // B-Maj harmonica gives note 102, C-maj shows rest
                    
                    //print ("KEYCHECK : ", pianoKeyboard[holeNote].pianoKey , keyboardNotePlaying)
                    
                    
               
                    if keyboardSharpsFlats == 0 {
                        buttonLabel = pianoKeyboard[holeNote].noteNameFlats
                    }
                    else {
                        switch labelsDisplayed {
                        case  .flats:
                            buttonLabel = pianoKeyboard[holeNote].noteNameFlats
                        case .sharps:
                            buttonLabel = pianoKeyboard[holeNote].noteNameSharps
                        case .pianoKeys:
                            buttonLabel = String (pianoKeyboard[holeNote].pianoKey)
                        }
                        
                    }


                    //print ("noteName in buttondefs : ", notes[holeNote].noteName!)
                    
                    // The note being played currently
                    
                    if holeNote == keyboardNotePlaying  && keyboardCallType == .dynamicDisplayKey && thisButton.button != 103 && thisButton.button != 207  { //Not for buttons that play the same note as the main buttons
                            
                        thisButtonDisplayed = .playing
                            
                        }
                }
                
                /// History buttons
                else if thisButton.displayed == .history  {
                    buttonLabel = thisButton.wingdings
                }
                /// Harmonica signature button
                else if thisButton.displayed == .signature  {
                    buttonLabel = keyboardHarmonicaName
                }
                
                
                else {
                    buttonLabel = "NA" // changed
                }

                displayedKeyboardRow.append( interfaceButton (buttonColor: getColor(colour: thisButton.background), textColor: getColor(colour: thisButton.textColor), title: buttonLabel, wingdings: thisButton.wingdings, rowNo: thisRow.rowNumber, colNo: columnNumber, Tag: 100*thisRow.rowNumber * columnNumber, displayed: thisButtonDisplayed
                                                             )
                )
            }
            displayedKeyboard.append (displayedKeyboardRow)
            displayedKeyboardRow = []
        }
       return displayedKeyboard
    
    }
    
}
