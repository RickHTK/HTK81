
import AVFoundation
import AudioKit
import CSoundpipeAudioKit
@testable import HarmonicaToolkit

// Mock calls the basetap init

class MockPitchTap0001: BaseTap, HTKPitchTapProtocol {

    


    /// Detected amplitude (average of left and right channels)
    public var amplitude: Float {
        return 2
    }

    /// Detected frequency of left channel
    public var leftPitch: Float {
        return 0
    }

    /// Detected frequency of right channel
    public var rightPitch: Float {
        return 0
    }

    /// Callback type
    ///
    /// required for initialiser
    ///
    //public
    typealias Handler = ([Float], [Float]) -> Void

    private var handler: Handler = { _, _ in }

    /// Initialize the pitch tap
    ///
    /// - Parameters:
    ///   - input: Node to analyze
    ///   - bufferSize: Size of buffer to analyze
    ///   - handler: Callback to call on each analysis pass
    required public init(_ input: Node, bufferSize: UInt32 = 4_096, handler: @escaping Handler) {
        super.init(input, bufferSize: bufferSize)
    }

    deinit {
        
        }

}

// Mock Without calling the basetap init

class MockPitchTap0002:  HTKPitchTapProtocol {
    
    func start() {
        
    }
    
    func stop() {
        
    }
    
    func doHandleTapBlock(buffer: AVAudioPCMBuffer, at time: AVAudioTime) {
        
    }
    
    /// Detected amplitude (average of left and right channels)
    public var amplitude: Float {
        return 2
    }

    /// Detected frequency of left channel
    public var leftPitch: Float {
        return 0
    }

    /// Detected frequency of right channel
    public var rightPitch: Float {
        return 0
    }

    /// Callback type
    ///
    /// required for initialiser
    ///
    //public
    typealias Handler = ([Float], [Float]) -> Void

    private var handler: Handler = { _, _ in }

    /// Initialize the pitch tap
    ///
    /// - Parameters:
    ///   - input: Node to analyze
    ///   - bufferSize: Size of buffer to analyze
    ///   - handler: Callback to call on each analysis pass
    required public init(_ input: Node, bufferSize: UInt32 = 4_096, handler: @escaping Handler) {
        
    }

    deinit {
        
        }

}
