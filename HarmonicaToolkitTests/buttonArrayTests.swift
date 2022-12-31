//
//  buttonArrayTests.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 30/12/2022.
//

import XCTest
@testable import HarmonicaToolkit
import SwiftUI




final class buttonArrayTests: XCTestCase {
    
    
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlats =  ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    
    let pianoNotes : [String] = [
        "C1", "C♯1", "D1", "D♯1", "E1", "F1", "F♯1", "G1", "G♯1", "A1", "A♯1", "B1", // 0-11
        "C2", "C♯2", "D2", "D♯2", "E2", "F2", "F♯2", "G2", "G♯2", "A2", "A♯2", "B2", //12-23
        "C3", "C♯3", "D3", "D♯3", "E3", "F3", "F♯3", "G3", "G♯3", "A3", "A♯3", "B3", //24-35
        "C4", "C♯4", "D4", "D♯4", "E4", "F4", "F♯4", "G4", "G♯4", "A4", "A♯4", "B4", //36-47
        "C5", "C♯5", "D5", "D♯5", "E5", "F5", "F♯5", "G5", "G♯5", "A5", "A♯5", "B5", //48-59
        "C6", "C♯6", "D6", "D♯6", "E6", "F6", "F♯6", "G6", "G♯6", "A6", "A♯6", "B6", //60-71
        "C7", "C♯7", "D7", "D♯7", "E7", "F7", "F♯7", "G7", "G♯7", "A7", "A♯7", "B7", //72-83
        "C8", "C♯8", "D8", "D♯8", "E8", "F8", "F♯8", "G8", "G♯8", "A8", "A♯8", "B8"  //84-95
        
    ]
    
    let richterOffsets : [[Int]] =
    [[],
     [-1,   3,  8,  12,  15, 18,  22, -1,  -1,  -1,  34, -1], //1
     [-1,  -1, -1,  -1,  -1, -1,  -1, 23,  27,  30,  35, -1], //2
     [-1,   0,  4,   7,  12, 16,  19, 24,  28,  31,  36, -1], //3
     
     [-1,  -1, -1,  -1,  -1, -1,  -1, -1,  -1,  -1,  -1, -1], //4
     
     [-1,   2,  7,  11,  14, 17,  21, 23,  26,  29,  33, -1], //5
     [-1,   1,  6,  10,  13, 16,  20, -1,  -1,  -1,  -1, -1], //6
     [-1,  -1,  5,   9,  -1, -1,  -1, -1,  -1,  -1,  -1, -1], //7
     [-1,  -1, -1,   8,  -1, -1,  -1, 25,  29,  32,  37, -1]  //8
     ,[]
     ,[]
    ]
    
    /// Struct Allows testing of the array of buttons in isolation
    struct buttonArrayStruct
    {
        
        let keyboard : [[interfaceButton]]
        
        init (harmonicaBase : Int) {
            keyboard = buttonArray(note: "C5", noteHistory: [noteDetail ( note: "£", sustainLength : 1, pianoKey: 0)], position: 0, harmonicaBase: harmonicaBase, sharpsFlats: 1, mode: 0, register: 0, translationMap: [0:0])
            
        }
    }
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCHarp305isC5 () throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let x = buttonArrayStruct(harmonicaBase: 13)
        
        print (x.keyboard[1][0])
        print ("Top Left")
        
        for (n, i) in  x.keyboard.enumerated() {
            for (m, j) in i.enumerated() {print (n, m, j)}
        }
        
        XCTAssertTrue(x.keyboard[3][5].title == "C5")
    }
    
    
    /// Harmonica index out of range
    func testHarpIndexTooLow() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        
        
        let x = buttonArrayStruct(harmonicaBase: -24)
        
        print (x.keyboard[1][0])
        print ("Top Left")
        
        for (n, i) in  x.keyboard.enumerated() {
            for (m, j) in i.enumerated() {print (n, m, j)}
        }
        
        XCTAssertTrue(x.keyboard[3][5].title == "C5")
    }
    
    /// Harmonica index out of range -- Will cause a fatal error index out of range
    func testHarpIndexTooHigh() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        enum HTKError: Error {
            case outOfRange
            case insufficientFunds(coinsNeeded: Int)
            case outOfStock
        }
        
        try XCTExpectFailure ("Index out of range") {
            
            do {
                let x = try buttonArrayStruct (harmonicaBase: 52)
            }
            catch{
                
            }
            
            //else {throw HTKError.outOfRange}
            
            
        }
    }
    /*
     print (x.keyboard[1][0])
     print ("Top Left")
     
     for (n, i) in  x.keyboard.enumerated() {
     for (m, j) in i.enumerated() {print (n, m, j)}
     }
     
     XCTAssertTrue(x.keyboard[3][5].title == "C5")
     XCTExpectFailure ("Fatal error: Index out of range") {}*/
    
    
    
    
    
    
    func testHarpBlowHole4IsCorrect () throws {
        
        
        /// Check each harmonica
        
        
        
        
        
        
        for i in  -19...51 {
            //for i in  15...18 {
            
            let x = buttonArrayStruct(harmonicaBase: i)
            print (i)
            print (x.keyboard[3][4].title)
            
            print (noteNamesWithSharps[abs((i+19)%12)] + String(((i+19)/12)+2))
            
            
            let expected : String =  noteNamesWithSharps[abs((i+19)%12)] + String(((i+19)/12)+2)
            print ()
            
            XCTAssertTrue(x.keyboard[3][4].title == expected)
            
        }
        /*
         let x = buttonArrayStruct(harmonicaBase: 13)
         
         print (x.keyboard[1][0])
         print ("Top Left")
         
         for (n, i) in  x.keyboard.enumerated() {
         for (m, j) in i.enumerated() {print (n, m, j)}
         }
         */
        //XCTAssertTrue(x.keyboard[3][5].title == "C5")
    }
    
    
    
    
    func testHarpsAreCorrect () throws {
        
        
        /// Check each harmonica
        
        let removeOctave: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ]
        
        
        
        
        //for i in  -23...51 {
        for i in  -19...39 { /// H39 is a harmonica starting piano C6,  H40 C#6 goes out of range at the top
            let x = buttonArrayStruct(harmonicaBase: i)
            
            let baseNote = i + 19
            //print ("basenote: ", baseNote)
            let noteOffset501 = 2
            
            let expected501 = pianoNotes [baseNote + noteOffset501]
            
            for (n, i) in  x.keyboard.enumerated() {
                // print ("row", n)
                for (m, j) in i.enumerated() {
                    
                    /// Only for harmonica rows not history
                    if n > 0 && n < 9 {
                        let noteOffset = richterOffsets [n][m]
                        if noteOffset != -1 {
                            
                            let expected = (pianoNotes [baseNote + noteOffset])
                            //print ("comparing", j.title, expected)
                            XCTAssertTrue(expected ==  j.title)
                        }
                    }
                    
                    /// Not required for these tests
                    /*
                     var noteName = j.title
                     noteName.removeAll(where: { removeOctave.contains($0) } )
                     
                     var noteNumber = j.title
                     noteNumber.removeAll(where: { !removeOctave.contains($0) } )
                     print ("Note Parts:", noteName, noteNumber)
                     let octave = Int(noteNumber)*/
                    
                }
            }
            
            
            
            
        }
        /*
         let x = buttonArrayStruct(harmonicaBase: 13)
         
         print (x.keyboard[1][0])
         print ("Top Left")
         
         for (n, i) in  x.keyboard.enumerated() {
         for (m, j) in i.enumerated() {print (n, m, j)}
         }
         */
        //XCTAssertTrue(x.keyboard[3][5].title == "C5")
    }
    
    
    
    
    
    func testPlayingNoteHighlighted () throws {
        
        
        /// Check each harmonica
        
        for i in  17...17 {
            //for i in  15...18 {
            
            let x = buttonArrayStruct(harmonicaBase: i)
            print (i)
            print (x.keyboard[3][4].title)
            for j in x.keyboard
            {
                for k in j {
                    print (k)
                    print (k.title)
                    print (k.buttonColor)
                    print (k.displayed)
                }
            }
            
            print (noteNamesWithSharps[abs((i+19)%12)] + String(((i+19)/12)+2))
            
            
            let expected : String =  noteNamesWithSharps[abs((i+19)%12)] + String(((i+19)/12)+2)
            print ()
            
            XCTAssertTrue(x.keyboard[3][4].title == expected)
            
        }
        /*
         let x = buttonArrayStruct(harmonicaBase: 13)
         
         print (x.keyboard[1][0])
         print ("Top Left")
         
         for (n, i) in  x.keyboard.enumerated() {
         for (m, j) in i.enumerated() {print (n, m, j)}
         }
         */
        //XCTAssertTrue(x.keyboard[3][5].title == "C5")
    }
    
    
    func testLoadrichterHarmonicaDict () throws {
        
        
        let x = getButtonDefs2()
            
        print ("x" , x)
        /*
         let x = buttonArrayStruct(harmonicaBase: 13)
         
         print (x.keyboard[1][0])
         print ("Top Left")
         
         for (n, i) in  x.keyboard.enumerated() {
         for (m, j) in i.enumerated() {print (n, m, j)}
         }
         */
        //XCTAssertTrue(x.keyboard[3][5].title == "C5")
    }
    
    
}
