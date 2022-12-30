import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import SwiftUI
import AVFoundation
import CSoundpipeAudioKit





// Tuner View is the main view of the harmonica screen
// it links the state object conductor and the visual harmonica keyboard

struct TunerView<TunerObservable> : View where TunerObservable: TunerConductorModel {
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    var position : Int = 16
    var harmonicaBase : Int = 0
    var sharpsFlats: Int = 0
    let mode : Int
    let register : Int //= 0
    let translationMap : [Int : Int]

    let adsOnOff : ads = .AdsOn
    
    
    
    @ObservedObject var conductor : TunerObservable
    
    init ( position : Int = 15, harmonicaBase: Int = 0, sharpsFlats: Int = 0, freqRange: (Float, Float) =  (2800.00, 80.00), mode: Int = 0 , register: Int = 0, translationMap: [Int:Int] = [0:0], sustainSensitivity :Int = 1, adsOnOff: ads = .AdsOn, conductor: TunerObservable)
    {
        self.position  = position
        self.harmonicaBase = harmonicaBase
        self.sharpsFlats = sharpsFlats
        self.mode = mode
        self.register = register
        self.translationMap = translationMap
        self.conductor = conductor
        

    }
    
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            keyboard2 (
          
                buttonArray: buttonArray (note: "\(conductor.data.noteName)",
                                          noteHistory : conductor.data.lastNotes,
                                          position: position,
                                          harmonicaBase: harmonicaBase,
                                          sharpsFlats: sharpsFlats,
                                          mode: mode, register: register,
                                          translationMap: translationMap
                                         )
            )
            .onAppear () {
                
                conductor.start()
                print ("starting conductor")

                let value = UIInterfaceOrientation.landscapeRight.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")

            }
            .onDisappear {
                conductor.stop()
                print ("stopping conductor")
            }
            
            if adsOnOff == .AdsOn {
                gridContentView()
            }
            
        }

    }// END BODY
} // END VIEW



