//
//  HarmonicaToolkitTests.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 30/12/2022.
//

import XCTest
import AVFoundation
//import AudioKit
//import SoundpipeAudioKit
//import AudioKitEX
//import CAudioKitEX
@testable import HarmonicaToolkit


/* Not used extension creates a dummy update function in tuner conductor
 
extension TunerConductor {
    func update(_ pitch: AUValue, _ amp: AUValue, sustainSensitivity : Int) {
        
        
        print ("update_test")
        data.pitch = 400
        data.amplitude = 1000
        //data.noteName = "C5"
        data.noteName = lastSustainedNote
        data.lastNotes = [dummyNote,dummyNote,dummyNote,dummyNote,dummyNote]
        
        for i in 1...10
        {
            data.pitch = 500
            print (data.noteName)
        }
        
    }
    
}*/

final class HarmonicaToolkitTunerConductor2Tests: XCTestCase {
    
    
    
    //Start a conductor to be used by any of the tests in this class
    let x = TunerConductor2(freqRangeIn:   (100.0,4000.0))
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test500givesC5() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //let x = TunerConductor(freqRangeIn:   (200.0,4000.0))
        
        for i in 1...10
        {
            x.update(440, 500)
            //x.data.pitch = 500
            print ("PK", x.data.pianoKey)
            XCTAssertTrue(x.data.pianoKey == 49)
        }
        
        //XCTAssertTrue(x.data.noteName=="C5")
        
        
    }
    
    func testA4ThresholdsByCalculation () throws {
        
        /// Succeeds if notes below amplitude 1 returns "-" and above returns a note
        
        //let x = TunerConductor()
        
        let ASharp4 : Float  = 466.1638
        let A4Natural : Float = 440.00
        let B4Natural : Float = 415.3047
        let midPointAboveA4 = A4Natural + (ASharp4 - A4Natural) / 2
        let midPointBelowA4 = A4Natural - (A4Natural - B4Natural) / 2
        let allowedError : Float = 0.2
        

        x.update(midPointBelowA4 - allowedError, 1.01)
        XCTAssertTrue(x.data.pianoKey == 48)
        
        x.update(midPointBelowA4 + allowedError, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(440, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(midPointAboveA4 - allowedError, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(midPointAboveA4 + allowedError, 1.01)
        XCTAssertTrue(x.data.pianoKey == 50)
        

         
        
        
    }
    func testA4ThresholdByIncrement () throws {
        
        /// Succeeds if notes below amplitude 1 returns "-" and above returns a note
        
        x.update(523, 0.99)
        XCTAssertTrue(x.data.pianoKey == 0 )
        
        x.update(523, 1)
        XCTAssertTrue(x.data.pianoKey == 0)
        
        x.update(426, 1.01)
        XCTAssertTrue(x.data.pianoKey == 48)
        
        x.update(427, 1.01)
        XCTAssertTrue(x.data.pianoKey == 48)
        
        x.update(428, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(429, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(439, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(440, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(441, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(451, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)
        
        x.update(452, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)

        x.update(452.5, 1.01)
        XCTAssertTrue(x.data.pianoKey == 49)

         x.update(453, 1.01)
         XCTAssertTrue(x.data.pianoKey == 50)
         
         x.update(454, 1.01)
         XCTAssertTrue(x.data.pianoKey == 50)
        
    }
    
    
    func testCFrequencies() throws {
        
        
        
        /// Checks if the frequencies of  C notes give the expected notes - C3 to C7 only.
        
        let noteFrequencies : [Float] = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
        let freqC0 : Double = 16.35
        
        
        for octave in 3...7
        {
            //x.update(500, 500)
            //x.data.pitch = 500
            print ("octave", octave)
            
            //let expected : String = "C" + String (i)
            let expectedPianoKey : Int = -8 + 12 * octave
            
            print ("POW: ", freqC0 * pow(2, Double(octave)))

            let pitch : Float = pow (2, Float(Int(octave))) * noteFrequencies[0]
            
            
            
            x.update(AUValue ( pitch ) , 500)
            
            print ("EXP ACT: ", expectedPianoKey, pitch,  x.pianoKeyPlaying, x.data.pitch)

            
            XCTAssertTrue (x.pianoKeyPlaying == expectedPianoKey)
        }
        
    }

    let noteList =
    [
        "C",
        "D♭",
        "D",
        "E♭",
        "E",
        "F",
        "G♭",
        "G",
        "A♭",
        "A",
        "B♭",
        "B"
    ]
    
}
    
    
    
    
