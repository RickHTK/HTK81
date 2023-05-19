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
import CSoundpipeAudioKit

class TunerConductor2: TunerConductorModel {
   
    @Published var data = TunerData()
    @Published var pianoKeyPlaying : Int
    
    var freqRange : (lowestNote: Float, highestNote : Float)  = (85.00, 4000.00) //F2 to F7 could be dynamic
    //var sharpsFlats : Int = 0
    //var ampSensitivity : Float = 0.6
    //var freqLowerLimit : Float = 75.0
    let engine = AudioEngine()
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader
    
    var tracker: PitchTap!
    var currentNote : noteDetail
    var previousNote : noteDetail
    var noteFound2 : noteDetail
    
    //var sustainSensitivity : Int = 2
    var lastSustainedNote: String
    //
    
    var sustainedLength: Int
    
    var pianoKey: Int
    
    var playHistory : [noteDetail] = []

    let dummyNote = noteDetail ( note: "£", sustainLength : 1, pianoKey: 0)

    var notesDetectedQueue = RingBufferQueue(bufferSize: 20, bufferSensitivity: 3)
    
    init(freqRangeIn: (lowestNote: Float, highestNote : Float))
    {
        
        pianoKeyPlaying = 0
        //let sustainSensitivity = sustainSensitivity
        
        //noteNames = noteNamesWithFlats
        pianoKey = 0
        sustainedLength = 1
        lastSustainedNote = "P"
        noteFound2 = dummyNote
        currentNote = dummyNote
        previousNote = dummyNote
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
    
    func start() {
        do {
            try  engine.start()
            tracker.start()
        } catch let err {
            Log(err)
        }
    }
    
    func stop() {
        engine.stop()
    }

    
    /// Sets up an array of dummy notes
    func initiateNoteDetail () -> [noteDetail] {
        var initialPlayHistory : [noteDetail] = []
        
        for _ in (1...20) {
            initialPlayHistory.append(dummyNote)
        }
        return initialPlayHistory
    }
    func initiateNoteDetail (numberOfElements : Int) -> [noteDetail] {
        var initialPlayHistory = Array (repeating: dummyNote, count: numberOfElements)
        return initialPlayHistory
    }
    
    /// The main update script
    func update(_ pitch: AUValue, _ amp: AUValue) {
        
        playHistory = initiateNoteDetail(numberOfElements: 20)
        
        var range = (playHistory.count - 12) ... (playHistory.count - 1)
        var playHistoryPublished = Array (self.playHistory[range])
        
        data.lastNotes = playHistoryPublished
        
        guard amp > 1.0 else {
            notesDetectedQueue.enqueue(0)
            data.pianoKey = 0
            return
            
        } // can change base amplitude in settings
        guard pitch > freqRange.lowestNote && pitch < freqRange.highestNote
        else {
            notesDetectedQueue.enqueue(0)
            data.pianoKey = 0
            return
        }       /// pitch range depends on the harmonica key
        
        /// Observable Data
        data.pitch = pitch
        data.amplitude = amp
        
        
        let pianoNoteNumber = Int (round (12 * (log2 (pitch/440)) + 49))
        pianoKeyPlaying = pianoNoteNumber
        notesDetectedQueue.enqueue(pianoNoteNumber)
        

        
    } /// End of Func Update
} /// End of class Tuner Conductor


