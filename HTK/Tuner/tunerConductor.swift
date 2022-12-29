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



// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/



class TunerConductor_Not_working: ObservableObject {
    //@Published var data = TunerData()
    
    private var tracker : HTKPitchTapProtocol
    
    var engine = AudioEngine()
    
    init(tracker_in : HTKPitchTapProtocol = createTracker())
    {
        print ("INITIATE TRACKER ")
        //guard let input = engine.input else { fatalError() }
        //engine = engine_out
        
        tracker = tracker_in
        
        //self.data.pitch = tracker.rightPitch

    }
    
    func start() {
        print ("Starting the engine")
        do {
            try  engine.start()
            tracker.start()
        } catch let err {
            Log(err)
        }
    }
    
    func stop() {
        tracker.stop()
    }
    
}


func update_tracker_Mock (_ pitch: AUValue, _ amp: AUValue ) -> TunerData

{

    var data = TunerData()
    
    data.pitch = 1000
    data.amplitude = 2000
    data.noteName = "C5"
    data.pianoKey = 107
  
    return data
}


class trackerClass  : HTKPitchTapProtocol
{
    
    @Published var amplitude: Float =  0
    
    @Published var leftPitch: Float =  0
    
    @Published var rightPitch: Float =  0
    
    let mic: AudioEngine.InputNode
    
    let engine = AudioEngine()
    //let initialDevice: Device
    
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader
    @Published var tracker: HTKPitchTapProtocol!
    var sustainSensitivity : Int = 0
    
    required init(_ input: AudioKit.Node, bufferSize: UInt32, handler: @escaping Handler) {
        
        guard let input = engine.input else { fatalError() }

        mic = input
        tappableNodeA = Fader(mic)
        tappableNodeB = Fader(tappableNodeA)
        tappableNodeC = Fader(tappableNodeB)
        silence = Fader(tappableNodeC, gain: 0)
        engine.output = silence
        
        tracker = HTKPitchTap(mic) { pitch, amp in
            DispatchQueue.main.async {
                update_tracker_Mock (pitch[0], amp[0]) //, sustainSensitivity: sustainSensitivity)
                
        }
            self.amplitude = amp[0]
            self.leftPitch = pitch[0]
            self.rightPitch = pitch[1]
        }
    }
    

    
    func start() {
        do {
            try  engine.start()
            //tracker.start()
        } catch let err {
            Log(err)
        }
    }
    
    func stop() {
        engine.stop()
    }
    
    func doHandleTapBlock(buffer: AVAudioPCMBuffer, at time: AVAudioTime) {
        
    }
    
    
    
    

    
    
     //guard let device = engine.inputDevice else { fatalError() }

    //initialDevice = device




    
    
    // Start the engine and tracker and return them
    



}


func createTracker  () -> HTKPitchTapProtocol
{
    print ("CREATE TRACKER")

    let engine = AudioEngine()
    //let initialDevice: Device
    //let engine = engine_in
    let mic: AudioEngine.InputNode
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader
    var tracker: HTKPitchTapProtocol!
    var sustainSensitivity : Int = 2
    
    
    guard let input = engine.input else { fatalError() }

    //guard let device = engine.inputDevice else { fatalError() }

    //initialDevice = device

    mic = input
    tappableNodeA = Fader(mic)
    tappableNodeB = Fader(tappableNodeA)
    tappableNodeC = Fader(tappableNodeB)
    silence = Fader(tappableNodeC, gain: 0)
    engine.output = silence


    do {
        try  engine.start()
        //tracker.start()
    } catch let err {
        Log(err)
    }


    tracker = (HTKPitchTap(mic) { pitch, amp in
        //DispatchQueue.main.async {
            //update_tracker_Mock(pitch[0], amp[0], sustainSensitivity: sustainSensitivity)
        //}
        if 1==1 {
            DispatchQueue.main.async { update_tracker (pitch[0], amp[0]) //, sustainSensitivity: sustainSensitivity)
            }
            
        }
    }
    )
    
    
    // Start the engine and tracker and return them
    
    do {
        //try  engine.start()
        tracker.start()
    } catch let err {
        Log(err)
    }
    
    print ("Returning Tracker" , tracker)
    
    return tracker
}



func update_tracker_Mock(_ pitch: AUValue, _ amp: AUValue, sustainSensitivity : Int) -> TunerData

{

    var data = TunerData()
    
    data.pitch = 1000
    data.amplitude = 2000
    data.noteName = "C5"
    data.pianoKey = 107
  
    return data
}




func update_tracker(_ pitch: AUValue, _ amp: AUValue /*, sustainSensitivity : Int*/) -> TunerData

{
    print ("UPDATE TRACKER")
    // Reduces sensitivity to background noise to prevent random / fluctuating data.
    
    
    let  sustainSensitivity :Int  = 0
    var playHistory : [noteDetail] = []
    var range = (playHistory.count - 12) ... (playHistory.count - 1)
    var playHistoryPublished = Array (playHistory[range])
    var data = TunerData()
    

    let dummyNote = noteDetail ( note: "£", sustainLength : 1, pianoKey: 0)
    var currentNote : noteDetail = dummyNote // =  noteDetail (note: "REST",sustainLength: 0,pianoKey: 0)
    var noteFound2 : noteDetail = dummyNote  // (note: "REST",sustainLength: 0,pianoKey: 0)
    
    var freqLowerLimit : Float = 75.0
    var octave = 0
    var freqRange : (lowestNote: Float, highestNote : Float)  = (85.00, 2800.00) //F2 to F7 could be dynamic
    
    let noteFrequencies  = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    
    let noteFreqRange : [(lowerRange: Float, higherRange: Float)] = [(15.89, 16.83), (16.84,17.84), (17.85,18.89), (18.90,20.01), (20.02,21.20), (21.21,22.47), (22.48,23.80), (23.81,25.22), (25.23,26.72), (26.73,28.31), (28.32,29.99), (30.00,31.78)]
  
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    //let noteNamesWithFlats =  ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    var noteNames : [String] = []
    var pianoKey: Int = 0
    
    data.lastNotes = playHistoryPublished
    
    guard amp > 1.0 else { return TunerData()} // can change base amplitude in settings
    guard pitch > freqRange.lowestNote && pitch < freqRange.highestNote
    else {
        //print ("rejected pitch:", pitch);
        return TunerData()
    }       // pitch range depends on the harmonica key
    
    // Observable Data
    data.pitch = pitch
    data.amplitude = amp
    
    //Uses factor to find the equivalent note in octave 0
    var noteDetected : String = ""
    var frequency = pitch
    var index = 0
    
    
    // BLOCK 1 -- Factors the frequency to the current octave by repeatedly dividing
    if pitch > freqLowerLimit {
        while frequency > Float(noteFrequencies[noteFrequencies.count - 1]) {
            frequency /= 2.0
        }
    }
    else {
        frequency = 0
    }
    
    //BLOCK 2 -- Find the Octave and Note being played
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
    
    // BLOCK 3 --
    
    // 3a. -- Has the note changed?
    if noteFound2.note == currentNote.note {
        // Increment the playing length
        currentNote.sustainLength += 1
    }
    
    // 3b. -- if the note has changed
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
    } // End of else
    
    data.noteName = "\(noteNames[index])\(octave)"
    data.pianoKey = pianoKey
    
    range = (playHistory.count - 12) ... (playHistory.count - 1)
    playHistoryPublished = Array (playHistory[range])
    
    data.lastNotes = playHistoryPublished
    print  ("RETURNING: ", data.noteName)
    return data
}




    
    


// Old Trial Code
func createEngine () -> AudioEngine
{
    let engine = AudioEngine()

    return engine
    
}

func createMic (engine: AudioEngine) -> AudioEngine.InputNode
{
    let mic: AudioEngine.InputNode
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader
    
    guard let input = engine.input else { fatalError() }
    
    mic = input
    tappableNodeA = Fader(mic)
    tappableNodeB = Fader(tappableNodeA)
    tappableNodeC = Fader(tappableNodeB)
    silence = Fader(tappableNodeC, gain: 0)
    
    return mic
}

/*

func createTracker2 (mic: AudioEngine.InputNode) -> HTKPitchTapProtocol
{
  
    var tracker: HTKPitchTapProtocol!
    var sustainSensitivity : Int = 2

    tracker = (HTKPitchTap(mic) { pitch, amp in
        DispatchQueue.main.async
        {
            update_tracker(pitch[0], amp[0], sustainSensitivity: sustainSensitivity)
        }
    }
    )
    
    return tracker
}
*/

// T
