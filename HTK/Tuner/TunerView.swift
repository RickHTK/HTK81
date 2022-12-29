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
    
    //var flatsSharps : Int
    var position : Int = 16
    var harmonicaBase : Int = 0
    
    // These are passed in from lookups in the settings screen - ContentView
    var sharpsFlats: Int = 0
    let freqRange : (Float, Float) // = (2800.00, 80.00)
    let mode : Int
    let register : Int //= 0
    let translationMap : [Int : Int] //= [0:0]
    let sustainSensitivity : Int // = 0
    let adsOnOff : ads = .AdsOn
    
    
    @ObservedObject var conductor : TunerObservable // = TunerConductor () //(sharpsFlats: 1, freqRange : (2800.00, 80.00))
    //@ObservedObject var conductor = MockTunerConductor () //(sharpsFlats: 1, freqRange : (2800.00, 80.00))
    
    
    
    init ( position : Int = 15, harmonicaBase: Int = 0, sharpsFlats: Int = 0, freqRange: (Float, Float) =  (2800.00, 80.00), mode: Int = 0 , register: Int = 0, translationMap: [Int:Int] = [0:0], sustainSensitivity :Int = 1, adsOnOff: ads = .AdsOn, conductor: TunerObservable)
    {
        self.position  = position
        self.harmonicaBase = harmonicaBase
        self.sharpsFlats = sharpsFlats
        self.freqRange = freqRange
        self.mode = mode
        self.register = register
        self.translationMap = translationMap
        self.sustainSensitivity = sustainSensitivity
        //self.adsOnOff
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
                    //conductor.freqRange = freqRange
                    //conductor.sharpsFlats = sharpsFlats
                    //conductor.sustainSensitivity = sustainSensitivity
                    let value = UIInterfaceOrientation.landscapeRight.rawValue
                    UIDevice.current.setValue(value, forKey: "orientation")
                    //getMapping()
                    //conductor.test_id = 9000
                    // print ("TRANS in TunerView", translationMap)
                }
                .onDisappear {
                    conductor.stop()
                }
            if adsOnOff == .AdsOn {
                gridContentView()
            }
        }
        /*
         .onRotate {
         newOrientation in
         orientation = newOrientation
         //print ("Orientation", orientation.rawValue)
         if orientation.rawValue == 1 {
         let value = UIInterfaceOrientation.landscapeRight.rawValue
         UIDevice.current.setValue(value, forKey: "orientation")
         }
         }*/
    }// END BODY
} // END VIEW



