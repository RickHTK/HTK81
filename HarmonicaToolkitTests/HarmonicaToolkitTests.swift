

//
//  HarmonicaToolkitTests.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 30/12/2022.
//

@testable import HarmonicaToolkit
import XCTest
import AVFoundation
import AudioKit
import AudioKitEX
import SoundpipeAudioKit



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

final class HarmonicaToolkitTunerConductorTests: XCTestCase {
    
    
    //Start a conductor to be used by any of the tests in this class
    let x = TunerConductor()

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
        
        let x = TunerConductor()
        
        for i in 1...10
        {
            x.update(500, 500, sustainSensitivity: 0)
            //x.data.pitch = 500
            print (x.data.noteName)
            XCTAssertTrue(x.data.noteName=="C5")
        }

        XCTAssertTrue(x.data.noteName=="C5")
        
        
    }
    
    func testAmplitudeThreshold () throws {
        
        /// Succeeds if notes below amplitude 1 returns "-" and above returns a note
        
        //let x = TunerConductor()
        
        
        x.update(500, 0.99, sustainSensitivity: 0)
        print (x.data.noteName, x.data.amplitude)
        XCTAssertTrue(x.data.noteName=="-")
        
        x.update(500, 1, sustainSensitivity: 0)
        print (x.data.noteName, x.data.amplitude)
        XCTAssertTrue(x.data.noteName=="-")
        
        x.update(500, 1.01, sustainSensitivity: 0)
        print (x.data.noteName, x.data.amplitude)
        XCTAssertTrue(x.data.noteName=="C5")
    
        
        
    }
    
    func testCFrequencies() throws {

        /// Checks if the frequencies of pure C notes give the expected notes - C3 to C7 only.
        
        //let x = TunerConductor()
        
        for i in 3...7
        {
            //x.update(500, 500, sustainSensitivity: 0)
            //x.data.pitch = 500
            print ("octave", i)
            
            let expected : String = "C" + String (i)
            let pitch : Float = pow (2, Float(Int(i))) * x.noteFrequencies[0]
            
            x.update(AUValue ( pitch ) , 500, sustainSensitivity: 0)
            
            //octave = Int(log2f(pitch / frequency))
            
            print (pow (2, Float(Int(i))) * x.noteFrequencies[0])
            print (x.data.pitch , x.data.noteName)
            
            XCTAssertTrue (x.data.noteName == expected)
        }


        
        
    }

    
    func testFrequencies() throws {

        /// Checks if the frequencies of pure C notes give the expected notes - C3 to C7 only.
        
        

        
        for i in 3...7
        {
            //x.update(500, 500, sustainSensitivity: 0)
            //x.data.pitch = 500
            print ("octave", i)
            
            let expected : String = "C" + String (i)
            let pitch : Float = pow (2, Float(Int(i))) * x.noteFrequencies[0]
            
            x.update(AUValue ( pitch ) , 500, sustainSensitivity: 0)
            
            
            //octave = Int(log2f(pitch / frequency))
            
            print (pow (2, Float(Int(i))) * x.noteFrequencies[0])
            print (x.data.pitch , x.data.noteName)
            
            
            XCTAssertTrue (x.data.noteName == expected)
        }

        //XCTAssertTrue(x.data.noteName=="C5")
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
