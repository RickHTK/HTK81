//
//  MockTuner.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 10/09/2022.
//

/*
struct TunerData : Tuner {
    var pitch: Float = 0.0
    var amplitude: Float = 0.0
    var noteName = "-"
    var pianoKey : Int = 0
    var lastNotes : [noteDetail] = []
 */

import Foundation
@testable import HarmonicaToolkit

/*
protocol TunerConductorProtocol {
    var data : TunerData {get}
    func update(_ pitch: AUValue, _ amp: AUValue, sustainSensitivity : Int)
    func start()
    func stop()
}*/

class MockTunerConductor: TunerConductorModel {
    
    
    @Published var data = TunerData()
    
    var freqRange :(lowestNote: Float, highestNote : Float) = (85.00, 2800.00) //F2 to F7 could be dynamic
    
    var sharpsFlats : Int = 0
    
    var ampSensetivity : Float = 0.6
    var sustainSensitivity : Int = 2
    
    let noteFrequencies  = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    var amplitude : Float = 1.0
    var noteName = "-"
    var pianoKey = 0
    var lastNotes : [noteDetail] = []
    
    let sustain = 5
    
  

    func start() {
        
        print ("STARTING TEST")
        
        for octave in (0...8) {
            for frequency in noteFrequencies {
                for duration in (0...sustain) {
                    print ("Pitch: ", frequency)
                    print ("Pitch for octave:", frequency * Double (octave))
                    
                    
                    data.pitch =  Float (frequency * Double (octave))
                    data.amplitude = amplitude
                    data.noteName = noteName
                    data.pianoKey = pianoKey
                    data.lastNotes = lastNotes
                }
                
            }
        }
        print ("ENDING TEST")
        
    }
    
    func stop() {
        
    }
}

