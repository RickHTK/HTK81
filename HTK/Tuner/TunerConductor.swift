//
//  tunerConductor.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 10/09/2022.
//

import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import SwiftUI
import AVFoundation

protocol TunerConductor2Model : ObservableObject {
    //var data : TunerData { get }
    var pianoKeyPlaying : Int { get }
    func start()
    func stop()
    //func update(_ pitch: AUValue, _ amp: AUValue, sustainSensitivity : Int)
    //var noteFrequencies : [Float] { get }
}

class TunerConductor2: TunerConductor2Model {

    @Published var pianoKeyPlaying : Int
    
    var freqRange : (lowestNote: Float, highestNote : Float)  = (85.00, 4000.00) //F2 to F7 could be dynamic
    let engine = AudioEngine()
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader
    var tracker: PitchTap!
    var playHistory : [noteDetail] = []
    var notesDetectedQueue = RingBufferQueue(bufferSize: 20, bufferSensitivity: 3)
    init(freqRangeIn: (lowestNote: Float, highestNote : Float))
    {
        pianoKeyPlaying = 0
        //pianoKey = 0
        //sustainedLength = 1
        //lastSustainedNote = "P"
        freqRange = freqRangeIn

        guard let input : Mixer = engine.input else { fatalError() }
        
        tappableNodeA = Fader(input)
        tappableNodeB = Fader(tappableNodeA)
        tappableNodeC = Fader(tappableNodeB)
        silence = Fader(tappableNodeC, gain: 0)
        engine.output = silence
        
            //tracker = HTKPitchTap (input, handler: {pitch, amp in
            tracker = PitchTap (input, handler: {pitch, amp in
                DispatchQueue.main.async
                    {
                            self.update(pitch[0], amp[0])
                    }
                }
            )
    }
    /// The main update script
    func update(_ pitch: AUValue, _ amp: AUValue) {
        
        guard amp > 1.0 else {
            notesDetectedQueue.enqueue(0)
            return
            
        } // can change base amplitude in settings
        guard pitch > freqRange.lowestNote && pitch < freqRange.highestNote
        else {
            notesDetectedQueue.enqueue(0)
            return
        }       /// pitch range depends on the harmonica key
        
        let pianoNoteNumber = Int (round (12 * (log2 (pitch/440)) + 49))
        pianoKeyPlaying = pianoNoteNumber
        notesDetectedQueue.enqueue(pianoNoteNumber)

    } /// End of Func Update
    
    func start() {
        do {
            try  engine.start()
            tracker.start()
        } catch let err { Log(err) }
    }
    
    func stop() {
        engine.stop()
    }
    
    
} /// End of class Tuner Conductor


