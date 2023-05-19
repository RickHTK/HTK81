import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import SwiftUI
import AVFoundation
import CSoundpipeAudioKit

// Tuner View is the main view of the harmonica screen
// it links the state object conductor and the visual harmonica keyboard

struct TunerView<TunerObservable> : View where TunerObservable: TunerConductor2Model {
    
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
        
        /// Has to be in the body of the view so as to react to changes in the conductor at each point of creation
        
        let buttonGridX = buttonArray (notePlaying: conductor.pianoKeyPlaying, // "\(conductor.data.noteName)",
                                  noteHistory : [], //conductor.data.lastNotes,
                                  position: position,
                                  harmonicaBase: harmonicaBase,
                                  sharpsFlats: sharpsFlats,
                                  mode: mode, register: register,
                                  translationMap: translationMap
                                 )
        
        //let buttonGrid2 = setupKeyboard(note: "\(conductor.data.noteName)", callType: .dynamicDisplayKey, harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats).getKeyboardDisplayed()
        
        let buttonGrid = setupKeyboard(pianoKeyPlaying: /*conductor.data.pianoKey*/ conductor.pianoKeyPlaying , callType: .dynamicDisplayKey, harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats).getKeyboardDisplayed()
        
        ZStack(alignment: .leading) {

            keyboardView (
                keyboardButtonArray: buttonGrid
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



