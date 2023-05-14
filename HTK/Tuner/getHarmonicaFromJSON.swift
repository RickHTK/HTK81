


class setupKeyboard {
    var harmonicaKeyboard : [KeyboardRow] = []
    
    
    func getHarmonicaFromJSON () throws {
        
        //testdby = htkDB.openDatabase()
        guard let harmonicaStructure = DBFileLoader.readLocalFile("richterHarmonica")
            else {
                fatalError("Unable to locate file \"richterHarmonica.json\" in main bundle.")
        }
        
        let rawHarmonica = DBFileLoader.loadHarmonicaStructureJson(harmonicaStructure)
        
        harmonicaKeyboard = rawHarmonica.keyboardRows
        
        print ("RAW H Type: " , type(of: rawHarmonica))
        print ("RAW I Type: " , type(of: rawHarmonica.instrument))
        print ("RAW KR Type: " , type(of: rawHarmonica.keyboardRows))
        
        
        for i in rawHarmonica.keyboardRows  {
            print ("KEYBOARD ROW TYPE: ", type(of: i), type(of: i.keyboardKeys))
            print ("KEYBOARD ROW: ", i)
            
            for j in i.keyboardKeys {
                print (j)
            }
        }
        
        
        
        
        
        
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
    
    func getKeyboardDisplayed (note: String, callType: keyDisplayType, harmonicaBase: Int, sharpsFlats: Int) { //}-> [[interfaceButton]] {
        
        for i in harmonicaKeyboard {
            for j in i.keyboardKeys {
                print ("ROW: ", i.rowNumber, i.rowName, j.button, j.offset, j.displayed)
                if j.displayed == "1" {
                    let keyNote = harmonicaBase + j.offset
                    print ("PLAYS: ", keyNote)
                    
                    
                }
            }
            
        }
        
        
    }
    
}
