//
//  HarmonicaToolkitJsonLoadTests.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 08/05/2023.
//

import XCTest
@testable import HarmonicaToolkit

final class HarmonicaToolkitJsonLoadTests: XCTestCase {



    //var htkDB : MiniDBMS = MiniDBMS()
    var testdby : OpaquePointer?
    var harmonicaKeyboard : [KeyboardRow] = []
    //var pianoKeyboard : [PianoKey] = []
    let pianoKeyboard : [PianoKey] = setupPiano().getPianoFromJSON()
   

    override func setUpWithError() throws {
        /*
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

        */
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetHarmonicaFromJSON () throws {
        
        //let keyboard = setupKeyboard(pianoKeyPlaying: <#Int#>, callType: <#keyDisplayType#>, harmonicaBase: <#Int#>, sharpsFlats: <#Int#>)
        //try keyboard.getHarmonicaFromJSON()
        //keyboard.getKeyboardDisplayed (note: "C4", callType: .dynamicDisplayKey, harmonicaBase: 17, sharpsFlats: 0)
            
        
        
    }
    
    func testGetPianoFromJSON () throws {
        

   
        
        print ("PIANO: ", pianoKeyboard, type (of: pianoKeyboard))
        

            

        
    }
    
   
    

}



