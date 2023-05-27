//
//  HarmonicaToolkitTranslationTests.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 20/05/2023.
//

import XCTest
@testable import HarmonicaToolkit



final class HarmonicaToolkitTranslationTests: XCTestCase {
    
    let HarmonicaOffset = 0
    
    let AUTO_PLIST_HARPDEF_PATH = getFile("richterHarmonicaTesting", withExtension: "plist")

    
    
    //let mapping1 = getMapping(sharpsFlats: 0, mode: 1, register: -1, selectedPosition: "2nd")
    
    //let mapping2 = getMapping(sharpsFlats: 0, mode: 1, register: 0, selectedPosition: "2nd")
    
    class testKeyboardDef {
        var button : Int = 0; // button
        var offset : Int? = nil; // offset
        //var wingdings : String? = nil; // wingDings
        //var backColor : UIColor? = nil; // background
        var displayed : String? = nil; // displayed Y/N
        //var textColor : UIColor? = nil; // Text Colour
        //var boilerplate : String? = nil; // Text displayed
        //var buttonLabel : String? = nil; // Text displayed
        //var fontSize : Int = 10; // text size
        
    }
    
    static func getFile(_ name: String, withExtension: String) -> String? {
        print ("GETFILE **")
        guard let url = Bundle(for: Self.self)
            .url(forResource: name, withExtension: withExtension)
        else {
            print ("Failed 1")
            return nil
            
        }
        
        guard let path = Bundle(for: Self.self)
            .path(forResource: name, ofType: withExtension) else { return nil }
        print ("URL: ", url)
        print ("PATH: ", path)
        guard let data = try? Data(contentsOf: url)
        else {
            print ("Failed 2")
            return nil
            
        }
        return path
    }
    
    func getRichterHarmonicaDictionaryFromPlist () -> [testKeyboardDef] {  // -> [Int:Int] {
        var _notes = [testKeyboardDef]()
        
        if let allData2 = NSArray(contentsOfFile: AUTO_PLIST_HARPDEF_PATH!) {
            print ("type allData: ", type(of: allData2))
            
            for dict in allData2 {
                guard let dict = dict as? [String: AnyObject] else {continue}
                let thisButtonDef =  testKeyboardDef()
                thisButtonDef.button  = (dict["button"] as? Int)! // pianoKey
                thisButtonDef.offset = dict["offset"] as? Int
                thisButtonDef.displayed = dict["displayed"] as? String
                /*
                thisButtonDef.wingdings = dict["wingdings"] as? String
                thisButtonDef.backColor = dict["backColor"] as? UIColor
                thisButtonDef.textColor = dict["textColor"] as? UIColor
                thisButtonDef.boilerplate = dict["boilerplate"] as? String
                thisButtonDef.buttonLabel = dict["buttonLabel"] as? String
                thisButtonDef.fontSize = dict["fontSize"] as? Int ?? 10
                */
                
                _notes.append(thisButtonDef)
                
            }
            
        }
        
        
        
        
        return _notes
    }
    
    
    func getButtonOffsetDict () -> [Int:Int] {
        let _notes = getRichterHarmonicaDictionaryFromPlist ()
        let buttonOffsetDict = Dictionary(uniqueKeysWithValues: _notes.map{ ($0.button , $0.offset ?? 0) })
        return buttonOffsetDict
    }
    func getButtonDisplayTypeDict () -> [Int:String] {
        let _notes = getRichterHarmonicaDictionaryFromPlist ()
        let buttonDisplayTypeDict = Dictionary(uniqueKeysWithValues: _notes.map{ ($0.button , $0.displayed ?? "") })
        return buttonDisplayTypeDict
    }
    
    override func setUpWithError() throws {
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

        
        
    func testGetTranslation() throws {
        
        let buttonOffset = getButtonOffsetDict ()
        let displayType = getButtonDisplayTypeDict()
        
        for position in positionDict
        {
            for sharpsFlats in 0 ... 1
            {
                for mode in modeDictRev {
                    
                    let translation1 = getMapping(sharpsFlats: sharpsFlats, mode: mode.key, register: -1, selectedPosition: position.key)
                    let translation2 = getMapping(sharpsFlats: sharpsFlats, mode: mode.key, register: 0, selectedPosition: position.key)
                   
                    for offset in buttonOffset {
                        //print ("Display Type", y[i.key], i.key)
                        if displayType[offset.key] == "1" {

                            let mapping1Result =  buttonOffset[translation1[offset.key] ?? 0]
                            let mapping2Result =  buttonOffset[translation2[offset.key] ?? 0]
                            
                            if mapping1Result != nil && mapping2Result != nil {
                                //print ("mapped results" , mapping1Result, mapping2Result)
                                XCTAssertTrue(mapping2Result == (mapping1Result ?? 0) + 12)
                            }
                            else if mapping1Result != nil || mapping2Result != nil
                            {
                                print ("not mapped", mode, mapping1Result, mapping2Result)
                                print (offset.key, offset.value)
   
                            }
                            else {
                                print ("Both nil", mode, mapping1Result, mapping2Result, "semitones",  offset.value ,"above", offset.key, displayType[offset.key])
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    func testGetCtoDTranslation() throws {
        
        let harmonicaBasePiano = 17 + 23  /// Piano Key of a C Harmonica
        let buttonOffset = getButtonOffsetDict ()
        let displayType = getButtonDisplayTypeDict()
        let modeUnderTest = 1 // 0.Mixolodian 2nd, 1.Dorian 3rd, 2.Aeolian 4th, 3.Phrygian 5th, 4.Locrian 6th, 5.Lydian 12th, 6.Harmonic Minor
        
        let translationMap = getMapping(sharpsFlats: 0, mode: modeUnderTest, register: 0, selectedPosition: "3rd")
        print ("TRANSLATION: ", translationMap)
        for translationPair in translationMap {
            print (translationPair)
            if translationPair.value != 999 {
                
                let translateFromPianoKey = buttonOffset[translationPair.key]! + harmonicaBasePiano
                let translateToPianoKey =  buttonOffset[translationPair.value]! + harmonicaBasePiano
                //XCTAssertTrue(translateToPianoKey == translateFromPianoKey + 2 )
                
                
                
            }
        }
        
        let x = setupKeyboard (pianoKeyPlaying: 0, callType: .staticDisplayKey, harmonicaBase: 17, harmonicaName: "TEST", sharpsFlats: 0)
        let y = x.getKeyboardDisplayed()
        print ("Keyboard row 1: " , y[1][1].Tag)
        
        
        for harmonicaActionRow in 1 ... 8 {
            for holeNumber in 1 ... 10 {
                let holeAction = harmonicaActionRow * 100 + holeNumber
                if displayType[holeAction] == "1"
                {
                    /// Offset of the original hole
                    print ("holeaction", holeAction)
                    print ("Keyboard row 1: " , y[harmonicaActionRow])
                    
                    let offsetOfPlayingHole = buttonOffset[holeAction]!
                    
                    /// Offset Action For the position
                    let modeOffsetIndex = (modeUnderTest + 1)  * 7 % 12

                    /// Offset adjustment for mode
                    let noteNumber = buttonOffset[holeAction]! % 12
                    
                    let offsetAdjustment =  modeOffset[noteNumber]![modeUnderTest]
                    
                    let expectedOffset = offsetOfPlayingHole + modeOffsetIndex + offsetAdjustment
                    let translatedOffset = translationMap [holeAction]
                    
                    print ("expected hole translates to key: ", holeAction, translatedOffset, expectedOffset )
                }
            }
        }
        
        
        print ("BUTTOFF", buttonOffset)
        print ("ModeOffset", modeOffset[1])
        
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
        
    func testuttonGrid () throws {
    
        let buttonGrid = setupKeyboard(pianoKeyPlaying: 40 , callType: .dynamicDisplayKey, harmonicaBase: 17, harmonicaName: "Test", sharpsFlats: 0).getKeyboardDisplayed()
        
        for buttonRow in buttonGrid {
            for i in buttonRow {
                print(i.buttonColor, i.title, i.Tag, i.rowNo*100 + i.colNo)
                print (i)
                
        
                //XCTAssertEqual(i.Tag, i.rowNo * 100 + i.colNo)
                
                
            }
        }
    }
    
    
    

}




