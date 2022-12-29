// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AVFoundation
import AudioKit
import CSoundpipeAudioKit






/// Tap to do pitch tracking on any node.
/// start() will add the tap, and stop() will remove it.
public class MockPitchTap: BaseTap {
    private var pitch: [Float] = [0, 0]
    private var amp: [Float] = [0, 0]
    private var trackers: [PitchTrackerRef] = []
    private let noteFrequencies : [Float]  = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    private var noteCounter : Int = 0
    private var octaveCounter : Int = 3
    private var sustainCounter : Int = 0

    
    

    /// Detected amplitude (average of left and right channels)
    public var amplitude: Float {
        return amp.reduce(0, +) / 2
    }

    /// Detected frequency of left channel
    public var leftPitch: Float {
        return pitch[0]
    }

    /// Detected frequency of right channel
    public var rightPitch: Float {
        return pitch[1]
    }

    /// Callback type
    public typealias Handler = ([Float], [Float]) -> Void

    private var handler: Handler = { _, _ in }

    /// Initialize the pitch tap
    ///
    /// - Parameters:
    ///   - input: Node to analyze
    ///   - bufferSize: Size of buffer to analyze
    ///   - handler: Callback to call on each analysis pass
    public init(_ input: Node, bufferSize: UInt32 = 4_096, handler: @escaping Handler) {
        self.handler = handler
        super.init(input, bufferSize: bufferSize)
        print ("Mock PitchTap initiated")
    }

    deinit {
        for tracker in trackers {
            akPitchTrackerDestroy(tracker)
        }
    }

    /// Stop detecting pitch
    override open func stop() {
        super.stop()
        for i in 0 ..< pitch.count {
            pitch[i] = 0.0
        }
    }

    /// Overide this method to handle Tap in derived class
    /// - Parameters:
    ///   - buffer: Buffer to analyze
    ///   - time: Unused in this case
    override public func doHandleTapBlock(buffer: AVAudioPCMBuffer, at time: AVAudioTime) {
        
        
        
        guard let floatData = buffer.floatChannelData else { return }
        let channelCount = Int(buffer.format.channelCount)
        let length = UInt(buffer.frameLength)
        while self.trackers.count < channelCount {
            self.trackers.append(akPitchTrackerCreate(UInt32(Settings.audioFormat.sampleRate), 4_096, 20))
        }

        while self.amp.count < channelCount {
            self.amp.append(0)
            self.pitch.append(0)
            //self.amp.append(5.0)
            //self.pitch.append(199)
        }

        // n is the channel
        for n in 0 ..< channelCount {
            let data = floatData[n]

            akPitchTrackerAnalyze(self.trackers[n], data, UInt32(length))

            var a: Float = 0
            var f: Float = 0
            akPitchTrackerGetResults(self.trackers[n], &a, &f)
            self.amp[n] = a
            self.pitch[n] = f
            self.amp[n] = 2.0
            self.pitch[n] = getNextNote(channel : n)
        }
        self.handler(self.pitch, self.amp)
    }
    
    func getNextNote (channel: Int) -> Float {
        
        
        
        if channel == 0 {
            if sustainCounter < 10 {
                sustainCounter += 1
            }
            else {
                
                noteCounter = (noteCounter + 1) % 12
                if noteCounter == 0 {
                    octaveCounter += 1
                }
                if octaveCounter > 7 {
                    octaveCounter = 3
                }
                sustainCounter = 0
            }
        }
      

        else {

            }
                
        
        return noteFrequencies [noteCounter] * pow( 2, Float (octaveCounter))
        
    }
    

}


