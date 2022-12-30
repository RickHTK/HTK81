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
    
    /// Struct Allows testing of the array of buttons in isolation
    struct buttonArrayStruct
    {
        
        let keyboard : [[interfaceButton]]
        
        init (harmonicaBase : Int) {
            keyboard = buttonArray(note: "", noteHistory: [noteDetail ( note: "£", sustainLength : 1, pianoKey: 0)], position: 0, harmonicaBase: harmonicaBase, sharpsFlats: 1, mode: 0, register: 0, translationMap: [0:0])
            
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

    /// Harmonica index out of range
    func testHarpIndexTooHigh() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        
        XCTExpectFailure ("Thread 1: Fatal error: Index out of range") {
            let x = buttonArrayStruct(harmonicaBase: 52)
        }
        /*
        print (x.keyboard[1][0])
        print ("Top Left")
        
        for (n, i) in  x.keyboard.enumerated() {
            for (m, j) in i.enumerated() {print (n, m, j)}
        }
        
        XCTAssertTrue(x.keyboard[3][5].title == "C5")
        XCTExpectFailure ("Fatal error: Index out of range") {}*/
    }


    func testHarp305isCorrect () throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        for i in  -23...51 {
            let x = buttonArrayStruct(harmonicaBase: i)
            print (i)
            print (x.keyboard[3][5].title)
            
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

    
}


