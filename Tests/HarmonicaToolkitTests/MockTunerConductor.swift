import SwiftUI
@testable import HarmonicaToolkit


class MockTunerConductor : TunerConductorModel
{
    @Published var data = TunerData()
    @Published var pianoKeyPlaying : Int = 0
    
    func start() {
        print ("Mock Conductor Starting")
        
    }
    func stop() {
        print ("Mock Conductor Stopping")
    }
    func update ()
    {
        for i in (1...10)
        {
            sleep (1)
            data.noteName = "X"+String(i)
            print ("Iterating")
            print (data.amplitude)
        }
        print ("Ending")
    }
    init ()
    {
        start()
        
        DispatchQueue.global(qos: .background).async  //runs on a background thread although the tunerConductor runs on the main thread.
        {
                self.update()
        }
    }
    
}
