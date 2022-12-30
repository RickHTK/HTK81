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

//Tuner Conductor (class) is an observable object that constantly returns information from the microphone and publishes it for use by views

protocol TunerConductorModel : ObservableObject {
    var data : TunerData { get }
    func start()
    func stop()
}
    
class TunerConductor: TunerConductorModel {
   
    @Published var data = TunerData()
    
    var freqRange : (lowestNote: Float, highestNote : Float)  = (85.00, 2800.00) //F2 to F7 could be dynamic
    var sharpsFlats : Int = 0
    var ampSensetivity : Float = 0.6

    var freqLowerLimit : Float = 75.0
    
    var octave = 0
    let engine = AudioEngine()
    //let initialDevice: Device
    
    //let mic: AudioEngine.InputNode
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader
    
    //var tracker1:  PitchTap!
    var tracker: HTKPitchTapProtocol! // PitchTap!
    
    var currentNote : noteDetail // =  noteDetail (note: "REST",sustainLength: 0,pianoKey: 0)
    
    var previousNote : noteDetail  // (note: "REST",sustainLength: 0,pianoKey: 0)
    var noteFound2 : noteDetail  // (note: "REST",sustainLength: 0,pianoKey: 0)
    
    var sustainSensitivity : Int = 2
    var lastSustainedNote: String
    var sustainedLength: Int
    
    var pianoKey: Int
    
    //var notesPlayed = noteHistory (arrayLength: 30)
    //let dummyNote = noteDetail ( note: "", sustainLength : 1, pianoKey: 0)
    var playHistory : [noteDetail] = []
    
    let noteFrequencies  = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    
    let noteFreqRange : [(lowerRange: Float, higherRange: Float)] = [(15.89, 16.83), (16.84,17.84), (17.85,18.89), (18.90,20.01), (20.02,21.20), (21.21,22.47), (22.48,23.80), (23.81,25.22), (25.23,26.72), (26.73,28.31), (28.32,29.99), (30.00,31.78)]
    
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlats =  ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    var noteNames : [String]
    let dummyNote = noteDetail ( note: "£", sustainLength : 1, pianoKey: 0)
    
    init()
    {
        let sustainSensitivity = sustainSensitivity
    
        noteNames = noteNamesWithFlats
        pianoKey = 0
        sustainedLength = 1
        lastSustainedNote = "P"
        noteFound2 = dummyNote
        currentNote = dummyNote
        previousNote = dummyNote

        guard let input = engine.input else { fatalError() }
        
        tappableNodeA = Fader(input)
        tappableNodeB = Fader(tappableNodeA)
        tappableNodeC = Fader(tappableNodeB)
        silence = Fader(tappableNodeC, gain: 0)
        engine.output = silence
        
                tracker = HTKPitchTap (input, handler: {pitch, amp in
                    DispatchQueue.main.async
                    {
                            self.update(pitch[0], amp[0], sustainSensitivity: self.sustainSensitivity)
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
    
    /// The main update script
    func update(_ pitch: AUValue, _ amp: AUValue, sustainSensitivity : Int) {
        
        playHistory = initiateNoteDetail()
        
        var range = (playHistory.count - 12) ... (playHistory.count - 1)
        var playHistoryPublished = Array (self.playHistory[range])
        
        data.lastNotes = playHistoryPublished
        
        guard amp > 1.0 else { return } // can change base amplitude in settings
        guard pitch > freqRange.lowestNote && pitch < freqRange.highestNote
        else {
            return
        }       /// pitch range depends on the harmonica key
        
        /// Observable Data
        data.pitch = pitch
        data.amplitude = amp
        
        var noteDetected : String = ""
        var frequency = pitch
        var index = 0
        
        /// BLOCK 1 -- Factors the frequency to the current octave by repeatedly dividing
        if pitch > freqLowerLimit {
            while frequency > Float(noteFrequencies[noteFrequencies.count - 1]) {
                frequency /= 2.0
            }
        }
        else {
            frequency = 0
        }
        
        /// BLOCK 2 -- Find the Octave and Note being played
        if frequency > 0 {
            octave = Int(log2f(pitch / frequency))
            //print ("Octave ", octave)
            // Find the note
            for checkRange in 0 ..< noteFreqRange.count {
                
                if noteFreqRange[checkRange].lowerRange < frequency && frequency < noteFreqRange[checkRange].higherRange {
                    
                    pianoKey =  (12 + octave * 12 + checkRange)
                    index = checkRange
                    noteDetected = "\(noteNamesWithSharps[checkRange])\(octave)"
                    
                    noteFound2 = noteDetail (note: noteDetected, sustainLength: 1, pianoKey: pianoKey)
                }
            }
        }
        else {
            octave = 0  //This can lead to failures
            noteFound2 =  noteDetail (note: "REST", sustainLength: 1, pianoKey: 0)
            //pianoKey = 0
            
        }
        
        /// BLOCK 3 --
        
        /// 3a. -- Has the note changed?
        if noteFound2.note == currentNote.note {
            // Increment the playing length
            currentNote.sustainLength += 1
        }
        
        /// 3b. -- if the note has changed
        else { //Note has changed now current note is the previous note played, previous note is the head of played history (11)
            
            if currentNote.sustainLength > sustainSensitivity {
                playHistory[playHistory.count - 1] = currentNote
            }
            else
            {
                //playHistory.remove(at: playHistory.count - 1)
            }
            currentNote = noteFound2
            if currentNote.note == playHistory[playHistory.count - 1].note {
                playHistory[playHistory.count - 1].sustainLength += 1
                //print ("Top of stack: ", playHistory[playHistory.count - 1])
            }
            else {
                if  playHistory[playHistory.count - 1].sustainLength < 3 && currentNote.note != playHistory[playHistory.count - 1].note {
                    if currentNote.note == playHistory[playHistory.count - 2].note {
                    }
                    playHistory.remove(at: playHistory.count - 1)
                    if currentNote.note == playHistory[playHistory.count - 1].note {
                        currentNote.sustainLength += playHistory[playHistory.count - 1].sustainLength
                        playHistory.remove(at: playHistory.count - 1) // removes a second one
                    }
                }
                else {
                    if playHistory.count > 20 {
                        playHistory.remove(at: 0)
                    }
                }
                playHistory.append(currentNote)
            }
        } /// End of else
        
        data.noteName = "\(noteNames[index])\(octave)"
        data.pianoKey = pianoKey
        
        range = (playHistory.count - 12) ... (playHistory.count - 1)
        playHistoryPublished = Array (playHistory[range])
        
        data.lastNotes = playHistoryPublished
        
    } /// End of Func Update
} /// End of class Tuner Conductor


