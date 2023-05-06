
import AVFoundation
import AudioKit
import CSoundpipeAudioKit
import SoundpipeAudioKit

public typealias Handler = ([Float], [Float]) -> Void



/// an exact copy of SoundpipeAudioKit for subclassing
///
/// /// Tap to do pitch tracking on any node.
/// start() will add the tap, and stop() will remove it.

class SoundpipeAKPitchTap: BaseTap {
    private var pitch: [Float] = [0, 0]
    private var amp: [Float] = [0, 0]
    private var trackers: [PitchTrackerRef] = []

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
    required public init(_ input: Node, bufferSize: UInt32 = 4_096, handler: @escaping Handler) {
        self.handler = handler
        super.init(input, bufferSize: bufferSize)
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
        }
        self.handler(self.pitch, self.amp)
    }
}

/// Class Inherits everything from pitchtap and adds the protocol for Mocking
//class HTKPitchTap : SoundpipeAKPitchTap, HTKPitchTapProtocol {}

/*
class SoundpipeAKPitchTapMock: BaseTap {
    private var pitch: [Float] = [9.0, 8.0]
    private var amp: [Float] = [12, 15]
    private var trackers: [PitchTrackerRef] = []

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
    required public init(_ input: Node, bufferSize: UInt32 = 4_096, handler: @escaping Handler) {
        self.handler = handler
        super.init(input, bufferSize: bufferSize)
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
        }

        // n is the channel
        for n in 0 ..< channelCount {
            let data = floatData[n]

            akPitchTrackerAnalyze(self.trackers[n], data, UInt32(length))

            var a: Float = 0
            var f: Float = 0
            akPitchTrackerGetResults(self.trackers[n], &a, &f)
            //self.amp[n] = a
            //self.pitch[n] = f
            self.amp[n] = 12
            self.pitch[n] = 15
            
            print ("updating Mock")
        }
        self.handler(self.pitch, self.amp)
    }
}

/// Class Inherits everything from pitchtap and adds the protocol for Mocking
class HTKPitchTapMock : SoundpipeAKPitchTapMock, HTKPitchTapProtocol {
    
}
*/

/*
class HTKMockPitchTap : HTKPitchTapProtocol {
    var amplitude: Float
    var leftPitch: Float
    var rightPitch: Float
    //typealias Handler = ([Float], [Float]) -> Void
    required init (_ input: Node, bufferSize: UInt32, handler: @escaping Handler) {
        amplitude = 0
        leftPitch = 0
        rightPitch = 0
    }
    //deinit {}
    func start() {}
    func stop() {}
    func doHandleTapBlock(buffer: AVAudioPCMBuffer, at time: AVAudioTime) {}
}
*/
