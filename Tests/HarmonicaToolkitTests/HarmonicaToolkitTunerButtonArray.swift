import XCTest
import AVFoundation
//import AudioKit
//import SoundpipeAudioKit
//import AudioKitEX
//import CAudioKitEX
@testable import HarmonicaToolkit

final class HarmonicaToolkitTunerButtonArray: XCTestCase {
        
        let noteList =
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
        
        
        //Start a conductor to be used by any of the tests in this class
        let conductor = TunerConductor(freqRangeIn:   (200.0,4000.0))
        let position : Int = 0
        let harmonicaBase : Int = 17
        let sharpsFlats : Int = 0
        let mode : Int = 0
        let register : Int = 0
        let translationMap : Int = 0
        
        
        
        
        
        
        
        
        override func setUpWithError() throws {
            // Put setup code here. This method is called before the invocation of each test method in the class.
            
        }
        
        override func tearDownWithError() throws {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }
        
        
        
        func testButtonArray() throws {
            
            print ("STARTING::")
            let buttonArray = (       note: "E4", //note: "\(conductor.data.noteName)",
                                      noteHistory : ["C5","C5"] , // conductor.data.lastNotes,
                                      position: position,
                                      harmonicaBase: harmonicaBase,
                                      sharpsFlats: sharpsFlats,
                                      mode: mode, register: register,
                                      translationMap: translationMap
            )
            print ("BUTTONS" , type (of: buttonArray) , buttonArray)
            
            
            let buttonDefs = getButtonDefs(note: "C5", callType: "dynamic", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
            
            for i in buttonDefs {
                print (i.buttonLabel, i.displayed)
            }
        }
        
        func testNotePlaying () throws {
            
            for octave in (1...8) {
                for noteName in noteList {
                    let pianoNote = noteName + String(octave)
                    print (pianoNote)
                    
                    let buttonDefs = getButtonDefs(note: pianoNote, callType: "dynamic", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
                    
                    for buttonArrayElement in buttonDefs {
                        if buttonArrayElement.displayed == "P" {
                            print ("Note Playing: ", buttonArrayElement.buttonId, buttonArrayElement.buttonLabel)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        func testKeyboardView () throws {
            
            // The Mock Tuner Conductor produces a stream of changing TunerData.noteName
            
            let mockTunerConductor = MockTunerConductor()
            
            let buttonDefs = getButtonDefs(note: "C4", callType: "dynamic", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
            
            let testTunerView = TunerView(position: 0, harmonicaBase: 20, sharpsFlats: 0, mode: 0, register: 0, translationMap: [0: 0], adsOnOff: HarmonicaToolkit.ads.AdsOn, conductor: mockTunerConductor)
            
            
            print ("testTunerView", testTunerView.conductor.data.pitch)
            print ("testTunerView", testTunerView.conductor.data.amplitude)
            
            print ("testTunerView", testTunerView)
            sleep (1)
            print ("testTunerView", testTunerView.conductor.data.noteName)
            
            print ("testTunerView", testTunerView.conductor.data.noteName)
            print ("testTunerView", testTunerView.conductor.data.pianoKey)
            
            print (testTunerView.translationMap)
            
            
            print ("testtunerview", testTunerView.body)
            
        }
        
        
        /*
         
         func testpqr () throws {
         
         var tracker: HTKPitchTapProtocol!
         
         let engine = AudioEngine()
         
         guard let input = engine.input else { fatalError() }
         
         //tracker = HTKPitchTapMock (input, handler: {pitch, amp in
         
         DispatchQueue.main.async
         {
         self.update()
         }
         }
         )
         
         print( tracker.rightPitch, tracker.leftPitch, tracker.amplitude)
         
         }
         
         func update() {}
         
         }*/
    }

