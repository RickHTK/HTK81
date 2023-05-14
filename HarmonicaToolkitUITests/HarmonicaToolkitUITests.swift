//
//  HarmonicaToolkitV103UITests.swift
//  HarmonicaToolkitV103UITests
//
//  Created by HarmonicaToolkit on 26/04/2023.
//

import XCTest

final class HarmonicaToolkitV103UITests: XCTestCase {
    
    let harmonicaList =
    [ "Low G",
      "Low Ab",
      "Low A",
      "Low Bb",
      "Low B",
      "Low C",
      "Low C#",
      "Low D",
      "Low Eb",
      "Low E",
      "Low F",
      "Low F#",
      "G-Maj",
      "Ab-Maj",
      "A-Maj",
      "Bb-Maj",
      "B-Maj",
      "C-Maj",
      "C#-Maj",
      "D-Maj",
      "Eb-Maj",
      "E-Maj",
      "F-Maj"/*,
              "F#-Maj"*/
    ]
    
    let positionDict : [String : Int] =
    [
        "1st" : 0,
        "2nd" : 1,
        "3rd" : 2,
        "4th" : 3,
        "5th" : 4,
        "6th" : 5,
        "7th" : 6,
        "8th" : 7,
        "9th" : 8,
        "10th" : 9,
        "11th" : 10,
        "12th" : 11
    ]
    
    let registerDict : [ String : Int ]
    =
    [
        "Low" : -1,
        "High" : 0 //,
        //"" : 98
    ]
    
    
    let modeDict : [String : Int] // Name, Index, Best Position
    =
    [
        
        "Major Key": 0,
        "Mixilodian" : 1,
        "Dorian": 2 ,
        "Aeolian": 3,
        "Phrygian" : 4,
        "Locrian" : 5,
        "Lydian" : 6
        
    ]
    
    var noteList =
    [
        "C",
        "C#",
        "D",
        "Eb",
        "E",
        "F",
        "F#",
        "G",
        "Ab",
        "A",
        "Bb",
        "B"
    ]
    
    
    
    
    
    //var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample2() throws {
        let app = XCUIApplication()
        app.launch()
        
        
    }
    
    func testCanSelectAllHarmonicas() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        
        //app.buttons["HarmonicaPicker"].tap()
        //app.collectionViews.buttons["Low C"].tap()
        
        for testHarmonica in harmonicaList
        {
            print (testHarmonica)
            app.buttons["HarmonicaPicker"].tap()
            //app.buttons["HarmonicaPicker"]
            //app.buttons["HarmonicaPicker"].swipeDown()
            //print ("coll view element",
            
            print  ("button exists : ", app.collectionViews.buttons[testHarmonica].exists)
            
            /// When not found on list, scroll
            if !app.collectionViews.buttons[testHarmonica].exists
            {
                app.buttons["HarmonicaPicker"].swipeDown()
            }
            
            app.collectionViews.buttons[testHarmonica].tap()
            
            
        }
    }
    
    func testCanSelectAllModes() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        
        app.buttons["PositionPicker"].tap()
        app.collectionViews.buttons["2nd"].tap()
        
        for mode in modeDict
        {
            
            print (mode.key)
            app.buttons["ModePicker"].tap()
            app.collectionViews.buttons[mode.key].tap()
        }
    }
    
    func testCanSelectAllRegisters() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        
        app.buttons["PositionPicker"].tap()
        app.collectionViews.buttons["2nd"].tap()
        
        for register in registerDict
        {
            
            print (register.key)
            app.buttons["RegisterPicker"].tap()
            app.collectionViews.buttons[register.key].tap()
        }
    }
    
    func testCanSelectAllValidCombinations() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        
        //app.buttons["HarmonicaPicker"].tap()
        //app.collectionViews.buttons["Low C"].tap()
        
        
        
        
        for testHarmonica in harmonicaList
        {
            print (testHarmonica)
            app.buttons["HarmonicaPicker"].tap()
            //app.buttons["HarmonicaPicker"]
            //app.buttons["HarmonicaPicker"].swipeDown()
            //print ("coll view element",
            
            print  ("button exists : ", app.collectionViews.buttons[testHarmonica].exists)
            
            /// When not found on list, scroll
            if !app.collectionViews.buttons[testHarmonica].exists
            {
                app.buttons["HarmonicaPicker"].swipeDown()
            }
            
            app.collectionViews.buttons[testHarmonica].tap()
            
            for testPosition in positionDict
            {
                print (testPosition.key)
                app.buttons["PositionPicker"].tap()
                
                if !app.collectionViews.buttons[testPosition.key].exists
                {
                    app.buttons["PositionPicker"].swipeDown()
                }
                
                app.collectionViews.buttons[testPosition.key].tap()
                
                print ("test picker mode exists", testPosition.key, app.buttons["ModePicker"].exists)
                if testPosition.key != "1st"
                {
                    XCTAssertTrue(app.buttons["ModePicker"].exists)
                    XCTAssertTrue(app.buttons["RegisterPicker"].exists)
                    XCTAssertTrue(app.buttons["HarmonicaPicker"].exists)
                    XCTAssertTrue(app.buttons["PositionPicker"].exists)
                    for register in registerDict
                    {
                        
                        print (register.key)
                        app.buttons["RegisterPicker"].tap()
                        app.collectionViews.buttons[register.key].tap()
                        for mode in modeDict
                        {
                            
                            print (mode.key)
                            app.buttons["ModePicker"].tap()
                            app.collectionViews.buttons[mode.key].tap()
                        }
                    }
                }
                else
                {
                    XCTAssertFalse(app.buttons["ModePicker"].exists)
                    XCTAssertFalse(app.buttons["RegisterPicker"].exists)
                    XCTAssertTrue(app.buttons["HarmonicaPicker"].exists)
                    XCTAssertTrue(app.buttons["PositionPicker"].exists)
                }
                
            }
            
            
        }
    }
    
    
    func testCanSelectAllPositions() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        
        //app.buttons["HarmonicaPicker"].tap()
        //app.collectionViews.buttons["Low C"].tap()
        
        
        
        
        for testPosition in positionDict
        {
            print (testPosition.key)
            app.buttons["PositionPicker"].tap()
            
            if !app.collectionViews.buttons[testPosition.key].exists
            {
                app.buttons["PositionPicker"].swipeDown()
            }
            
            app.collectionViews.buttons[testPosition.key].tap()
            
            print ("test picker mode exists", testPosition.key, app.buttons["ModePicker"].exists)
            if testPosition.key != "1st"
            {
                XCTAssertTrue(app.buttons["ModePicker"].exists)
                XCTAssertTrue(app.buttons["RegisterPicker"].exists)
                XCTAssertTrue(app.buttons["HarmonicaPicker"].exists)
                XCTAssertTrue(app.buttons["PositionPicker"].exists)
            }
            else
            {
                XCTAssertFalse(app.buttons["ModePicker"].exists)
                XCTAssertFalse(app.buttons["RegisterPicker"].exists)
                XCTAssertTrue(app.buttons["HarmonicaPicker"].exists)
                XCTAssertTrue(app.buttons["PositionPicker"].exists)
            }
            
        }
        
        
    }
    
    
    
    func testCanSelectAllKeys2() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        
        //app.buttons["HarmonicaPicker"].tap()
        //app.collectionViews.buttons["Low C"].tap()
        
        //app.buttons.element(boundBy: 1).tap()
        
        
        for testHarmonica in harmonicaList
        {
            print (testHarmonica)
            //app.buttons["HarmonicaPicker"].tap()
            app.buttons.element(boundBy: 1).tap()
            //app.buttons["HarmonicaPicker"]
            //app.buttons["HarmonicaPicker"].swipeDown()
            //print ("coll view element",
            
            print  ("button exists : ", app.collectionViews.buttons[testHarmonica].exists)
            
            
            if !app.collectionViews.buttons[testHarmonica].exists
            {
                app.buttons["HarmonicaPicker"].swipeDown()
            }
            
            app.collectionViews.buttons[testHarmonica].tap()
            
            
            
            
            /*
             if app.collectionViews.buttons[testHarmonica].buttons[testHarmonica] == "Low E"
             {
             app.buttons["HarmonicaPicker"].swipeDown()
             }*/
            //app.menuButtons.buttons[testHarmonica].tap()
            
            sleep (UInt32(0.5))
            
        }
        
        
        print ("Text fields", app.textFields["TxtF1"].value)
        print ("Text fields", app.textFields["TxtF1"].exists)
        
        print ("Images", app.images.element.label)
        print ("Images", app.images["Globe"].exists)
        
        print ("Pickers", app.pickers["TestPicker"].exists)
        print ("Pickers", app.pickers.firstMatch)
        
        print ("Pickers", app.pickers.keys.element)
        
        print ("PickerWheels", app.pickerWheels)
        print ("PickerWheels", app.pickerWheels.element)
        print ("PickerWheels", app.pickerWheels.accessibilityAttributedValue)
        
        sleep (1)
        
        print ("Views", app.accessibilityAttributedLabel)
        
        print (app.accessibilityUserInputLabels)
        print (app.pickers)
        print (app.launchArguments)
        
        print ("test picker", app.buttons["TestPicker"].exists)
        print ("test picker mode exists", app.buttons["ModePicker"].exists)
        print ("test picker harmonica exists", app.buttons["Harmonica"].exists)
        print ("test picker P1 exists", app.buttons["P1"].exists)
        
        
        app/*@START_MENU_TOKEN@*/.buttons["TestPicker"]/*[[".buttons[\"B\"]",".buttons[\"TestPicker\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["A"]/*[[".cells.buttons[\"A\"]",".buttons[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["PositionPicker"].tap()
        app.collectionViews.buttons["2nd"].tap()
        
        print ("mode picker mode exists", app.buttons["ModePicker"].exists)
        print ("position picker exists", app.buttons["PositionPicker"].exists)
        
        print ("collection views", app.collectionViews.buttons["Mode"].exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["HarmonicaPicker"]/*[[".buttons[\"C-Maj\"]",".buttons[\"HarmonicaPicker\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        
        
        
        //let addTaskButton = app.pickers["P1"]
        //let addTaskButton = app.buttons["P1"]
        //app.pickers.element.adjust(toPickerWheelValue: "C-Maj")
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
    }
    
    
    func testExample3() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.buttons.element(boundBy: 0).tap()
        let exp = expectation(description: "Test after 1 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            app.buttons.element(boundBy: 2).tap()
            XCTAssert(app.staticTexts["Selected value two"].exists)
        } else {
            XCTFail("Delay interrupted")
        }
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testGoesToHarmonicaScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.buttons.element(boundBy: 0).tap()
        
        
        // How to know which screen we are on?
        
        
        
        
        //XCTAssertTrue(app.buttons["112"].exists)
        
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testHarmonicaScreenDrawn() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.buttons.element(boundBy: 0).tap()
        
        print ("BASE KEY: " , app.buttons["400"].label)
        
        for row in (1...8)
        {
            for column in (0 ... 11)
            {
                print (String (row*100+column))
                XCTAssertTrue(app.buttons[String (row*100+column)].exists)
                print ("" , app.buttons[String (row*100+column)].label)
                
            }
        }
        
        XCTAssertTrue(app.buttons["102"].label == "G♯4")
        
        print ("" , app.buttons["100"].label)
        print ("" , app.buttons["101"].label)
        
        print ("" , app.buttons["102"].label)
        print ("" , app.buttons["103"].label)
        print ("" , app.buttons["104"].label)
        print ("" , app.buttons["105"].label)
        print ("" , app.buttons["106"].label)
        print ("" , app.buttons["107"].label)
        print ("" , app.buttons["105"].label)
        print ("" , app.buttons["108"].label)
        print ("" , app.buttons["109"].label)
        print ("" , app.buttons["110"].label)
        
        print ("" , app.buttons["111"].label)
        
        
        
        XCTAssertTrue(app.buttons["101"].exists)
        XCTAssertTrue(app.buttons["102"].exists)
        XCTAssertTrue(app.buttons["103"].exists)
        XCTAssertTrue(app.buttons["104"].exists)
        XCTAssertTrue(app.buttons["105"].exists)
        XCTAssertTrue(app.buttons["106"].exists)
        XCTAssertTrue(app.buttons["107"].exists)
        XCTAssertTrue(app.buttons["108"].exists)
        XCTAssertTrue(app.buttons["109"].exists)
        XCTAssertTrue(app.buttons["110"].exists)
        XCTAssertTrue(app.buttons["111"].exists)
        
        
        
        
        
        //XCTAssertTrue(app.buttons["112"].exists)
        
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
                
            }
        }
    }
    
    static func getFile(_ name: String, withExtension: String) -> String? {
        guard let url = Bundle(for: Self.self)
            .url(forResource: name, withExtension: withExtension) else { return nil }
        guard let path = Bundle(for: Self.self)
            .path(forResource: name, ofType: withExtension) else { return nil }
        print ("URL: ", url)
        print ("PATH: ", path)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return path
    }
    
    func testGetFile() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let xmlData = Self.getFile("pianoNotes", withExtension: "plist")
        print (xmlData)
        XCTAssertNotNil(xmlData, "File not found")
    }
    
    
    class Notes {
        var pianoKey : Int? = nil; // pianoKey
        var noteNameSharps : String? = nil; // noteName
        var noteNameFlats : String? = nil; // noteName
        var noteName : String? = nil; // noteName
        var frequency : Float? = nil; // frequency
        var defaultAction : Int = 0
    }
    
    func getNotesTest () ->  [Notes]  {
        
        //let app = XCUIApplication()
        //app.launch()
        
        
        
        let flatsSharps : Int = 0
        //let AUTO_PLIST_HARPDEF_PATH = Bundle.main.path(forResource: "richterHarmonica", ofType: "plist")
        let AUTO_PLIST_HARPDEF_PATH = Self.getFile("richterHarmonica", withExtension: "plist")
        
        //let AUTO_PLIST_NOTES_PATH = Bundle.main.path(forResource: "pianoNotes", ofType: "plist", inDirectory: ".")
        let AUTO_PLIST_NOTES_PATH = Self.getFile("pianoNotes", withExtension: "plist")
        
        
        var _notes = [Notes]()
        
        
        
        
        
        
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
                notes.frequency = (dict["frequency"] as? NSString)?.floatValue // frequency
                _notes.append(notes)
                notes.defaultAction = dict["defaultAction"] as! Int
                print ("This Note: ", notes.noteName, notes.noteNameSharps, notes.noteNameFlats, notes.frequency)
                
            }
            
        }
        return _notes
        
        
    }
    
    class ButtonDef {
        var button : Int = 0; // button
        var offset : Int? = nil; // offset
        var wingdings : String? = nil; // wingDings
        var backColor : UIColor? = nil; // background
        var displayed : String? = nil; // displayed Y/N
        var textColor : UIColor? = nil; // Text Colour
        var boilerplate : String? = nil; // Text displayed
        var buttonLabel : String? = nil; // Text displayed
        var fontSize : Int = 10; // text size
        
    }
    
    
    func getButtonDefsTest () -> [Int: ButtonDef]{ //Type is not used
        
        //let app = XCUIApplication()
        //app.launch()
        

        //let AUTO_PLIST_HARPDEF_PATH = Bundle.main.path(forResource: "richterHarmonica", ofType: "plist")
        let AUTO_PLIST_HARPDEF_PATH = Self.getFile("richterHarmonica", withExtension: "plist")
        
        var _buttonDefns2 = [ButtonDef]()
        
        if let allData2 = NSArray(contentsOfFile: AUTO_PLIST_HARPDEF_PATH!) {
            
            
            
            for dict in allData2 {
                
                guard let dict = dict as? [String: AnyObject] else {continue}
                let thisButtonDef =  ButtonDef()
                thisButtonDef.button  = (dict["button" ] as? Int)! // pianoKey
                thisButtonDef.offset = dict["offset"] as? Int
                thisButtonDef.wingdings = dict["wingdings"] as? String
                thisButtonDef.backColor = dict["backColor"] as? UIColor
                thisButtonDef.displayed = dict["displayed"] as? String
                thisButtonDef.textColor = dict["textColor"] as? UIColor
                thisButtonDef.boilerplate = dict["boilerplate"] as? String
                thisButtonDef.buttonLabel = dict["buttonLabel"] as? String
                thisButtonDef.fontSize = dict["fontSize"] as? Int ?? 10
                
                
                _buttonDefns2.append(thisButtonDef)
            }
        }
        
        var buttonDefDict: [Int: ButtonDef] = [:]
        
        for buttondef in _buttonDefns2 {
            buttonDefDict.updateValue(buttondef, forKey: buttondef.button)
        }
        
        
        return buttonDefDict
        
    }
    
    func testCorrectHarmonicaBase  () throws {
        
        
        let noteDict =  getNotesTest()
        let harpDef =  getButtonDefsTest()
        
        //let app = XCUIApplication()
        //app.launch()
        //app.buttons.element(boundBy: 0).tap()
        
        
        print ("NOTEDICT", noteDict[1].frequency)
        print ("NOTEDICT", noteDict[2].frequency)
        print ("NOTEDICT", noteDict[3].frequency)
        print ("NOTEDICT", noteDict[4].frequency)
        print ("NOTEDICT", noteDict[5].frequency)
        //print ("NOTEDICT", noteDict[].frequency)
        
        //print ("TESTING HARMONICA BASE" , app.buttons["301"].label)
        
        
        
        print ("301", harpDef[301]!.offset)
        print ("302", harpDef[302]!.offset)
        
        
    }
    
    func testHarmonicaNotesCorrectC3() throws {
        // UI tests must launch the application that they test.
        
        let harpDef =  getButtonDefsTest()
        let noteArr =  getNotesTest()
        let noteNameDict = getNoteNameDictTest()
        let pianoKeyDict = getPianoKeyDictTest()
        var noteCount  : Int = 0
        
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons.element(boundBy: 0).tap()
        
        let harmonicaBaseScreen =  app.buttons["400"].label
        let harmonicaBasePiano = noteNameDict[harmonicaBaseScreen]?.pianoKey
        
        
        
        //print ("BASE KEY: " , app.buttons["400"].label)
        
        for row in (1...8)
        {
            for column in (0 ... 11)
            {
                let thisButton : Int = row*100+column
                //print ("Checking Button:" , thisButton)
                //print (harpDef[thisButton]?.button, harpDef[thisButton]!.offset, harpDef[thisButton]!.displayed, harpDef[thisButton]!.boilerplate)
                let pianoKey = harmonicaBasePiano! + harpDef[thisButton]!.offset!
                let expectedLabel = pianoKeyDict [pianoKey]
                

                
                if harpDef[thisButton]!.displayed == "1" {
                    
                    //print ("expected label: ", expectedLabel?.noteNameSharps)
                    //print ("actual label" , app.buttons[String(thisButton)].label)
                    XCTAssertEqual(expectedLabel?.noteNameSharps, app.buttons[String(thisButton)].label)
                    noteCount += 1
                }
            }
        }
        
        print ("Number of notes Checked" , noteCount)

        
        XCTAssertEqual(noteCount, 45) //44 notes plus button 400
        
        
        
        //XCTAssertTrue(app.buttons["112"].exists)
        
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    func getPianoKeyDictTest () -> ([Int: Notes]) {
        
        let noteArr =  getNotesTest()
        var pianoKeyLookup: [Int: Notes] = [:]
        //var noteNameLookup: [String: Notes] = [:]
        
        
        
        for i in noteArr {
            print (i.noteName, i.pianoKey)
            pianoKeyLookup.updateValue(i, forKey: i.pianoKey!)
            //noteNameLookup.updateValue(i, forKey: i.noteName!)
        }
        
        print ("37", pianoKeyLookup[37]?.pianoKey)
        
        return pianoKeyLookup
        
    }
    
    func getNoteNameDictTest () -> ([String: Notes]) {
        
        let noteArr =  getNotesTest()
        //var pianoKeyLookup: [Int: Notes] = [:]
        var noteNameLookup: [String: Notes] = [:]
        
        
        
        for i in noteArr {
            print (i.noteName, i.pianoKey)
            //pianoKeyLookup.updateValue(i, forKey: i.pianoKey!)
            noteNameLookup.updateValue(i, forKey: i.noteName!)
        }
        
        
        
        return noteNameLookup
        
    }
    
    
}
