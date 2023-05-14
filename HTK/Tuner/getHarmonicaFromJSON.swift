


class setupKeyboard {
    var harmonicaKeyboard : [KeyboardRow]
    var keyboardNotePlaying : String = ""
    var keyboardCallType: keyDisplayType
    var keyboardHarmonicaBase: Int
    var keyboardSharpsFlats: Int
    let pianoKeyboard = setupPiano().getPianoFromJSON ()
    
    init (note: String, callType: keyDisplayType, harmonicaBase: Int, sharpsFlats: Int) {
        harmonicaKeyboard = []
        keyboardNotePlaying = note
        keyboardCallType = callType
        keyboardHarmonicaBase = harmonicaBase
        keyboardSharpsFlats = sharpsFlats
    }
    
    
    func getHarmonicaFromJSON () throws {
        
        //testdby = htkDB.openDatabase()
        guard let harmonicaStructure = DBFileLoader.readLocalFile("richterHarmonica")
            else {
                fatalError("Unable to locate file \"richterHarmonica.json\" in main bundle.")
        }
        
        let rawHarmonica = DBFileLoader.loadHarmonicaStructureJson(harmonicaStructure)
        
        harmonicaKeyboard = rawHarmonica.keyboardRows
        
        
        
        
        
        
        
        
        //var parameterlist : [Any] = []
        
        //var thisButton : KeyboardButton
        
        
        /*
        for i in harmonicaKeyboard {
            
            let tableForInsert = String (describing: type(of: i))
            print ("Table For Insert: ", tableForInsert, type (of: tableForInsert))
            
            for j in i.keyboardKeys {
                
                let tableForInsert = String (describing: type(of: j))
                var parameterList1 = [j.button,j.offset,j.wingdings,j.background,j.displayed,j.background,j.textColor] as [Any]
                
                
                /*
                thisButton = KeyboardButton (   buttonId: j.button,
                                                offset: j.offset ,
                                                wingdings: j.wingdings ,
                                                backColor: getColor (colour: j.background),
                                                displayed: j.displayed ,
                                                textColor: getColor (colour: j.textColor),
                                                boilerplate: j.boilerplate
                )*/
                
                //htkDB.upsertDataDictionaryTable(tableName: tableForInsert, parameterList: parameterList1)
            }
            let parameterList2 = [i.rowNumber ,i.rowName] as [Any]
            //htkDB.upsertDataDictionaryTable(tableName: tableForInsert, parameterList: parameterList2 )
        }*/
        
   
    }
    
    func getKeyboardDisplayed () -> [[interfaceButton]] {
        
        var displayedKeyboardRow : [interfaceButton] = []
        var displayedKeyboard : [[interfaceButton]] = [[]]
        var buttonLabel : String = ""
        
        do
        {  try getHarmonicaFromJSON() }
        catch {print ("Failed to get keyboard")}
                
        for thisRow in harmonicaKeyboard {
            
            for (columnNumber , thisButton) in thisRow.keyboardKeys.enumerated() {
                print ("ROW: ", thisRow.rowNumber, thisRow.rowName, thisButton.button, thisButton.offset, thisButton.displayed)

                
                if thisButton.displayed == "B" {
                    buttonLabel = thisButton.boilerplate
                    
                }
                
                // Playing buttons
                else if thisButton.displayed == "1" {
                    
                    let holeNote =  notesBase + thisButton.offset + keyboardHarmonicaBase // B-Maj harmonica gives note 102, C-maj shows rest
                    
                    
               
                    if keyboardSharpsFlats == 0 {
                        buttonLabel = pianoKeyboard[holeNote].noteNameFlats
                    }
                    else {
                        buttonLabel = pianoKeyboard[holeNote].noteNameSharps
                    }


                    //print ("noteName in buttondefs : ", notes[holeNote].noteName!)
                    
                    // The note being played currently
                    if pianoKeyboard[holeNote].noteNameSharps == keyboardNotePlaying  && keyboardCallType == .dynamicDisplayKey && thisButton.button != 103 && thisButton.button != 207  { //Not for buttons that play the same note as the main buttons
                            
                        //thisButton.displayed = "P"
                            
                        }
                }
                
                // History buttons
                else if thisButton.displayed == "H"  {
                    buttonLabel = thisButton.wingdings
                }
                
                else {
                    buttonLabel = "NA" // changed
                }
                
                displayedKeyboardRow.append( interfaceButton (buttonColor: getColor(colour: thisButton.background), textColor: getColor(colour: thisButton.textColor), title: thisButton.wingdings, wingdings: thisButton.wingdings, rowNo: thisRow.rowNumber, colNo: columnNumber, Tag: 100*thisRow.rowNumber * columnNumber, displayed: thisButton.displayed))
            }
            displayedKeyboard.append (displayedKeyboardRow)
            displayedKeyboardRow = []
        }
       return displayedKeyboard
    
    }
    
}
