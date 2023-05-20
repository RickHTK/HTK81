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

    let mapping1 = getMapping(sharpsFlats: 0, mode: 1, register: -1, selectedPosition: "2nd")
    let mapping2 = getMapping(sharpsFlats: 0, mode: 1, register: 0, selectedPosition: "2nd")
    
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
        print ("Notes is type: ", type(of: _notes))
        
        print ("File Location: ", AUTO_PLIST_HARPDEF_PATH)
        
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
        
        let x = getButtonOffsetDict ()
        let y = getButtonDisplayTypeDict()
        
        for i in x {
            //print ("Display Type", y[i.key], i.key)
            if y[i.key] == "1" {
                print (i.key, i.value, mapping1[i.key], mapping2[i.key], y[i.key]
                )
                
                let mapping1Result =  x[mapping1[i.key] ?? 0]
                let mapping2Result =  x[mapping2[i.key] ?? 0]
                print ("mapping results" , mapping1Result, mapping2Result)
                if mapping1Result != nil && mapping2Result != nil {
                    XCTAssertTrue(mapping2Result == (mapping1Result ?? 0) + 12)
                }
                else if mapping1Result != nil || mapping2Result != nil
                {
                    print ("not mapped" , mapping1Result, mapping2Result)
                    print (i.key, i.value)
                }
            }
        }
        
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
        

    

}
