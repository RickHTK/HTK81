//
//  MasterView.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 29/12/2022.
//

import SwiftUI
import AudioKit

class DummyObject: ObservableObject { //Forces a change to an object so that it updates
    @Published var pickerId:Int = 0
    init() {
        incrementId()
    }
    func incrementId() {
        self.pickerId += 1
    }
}

extension UINavigationBar {
    static func changeAppearance(clear: Bool) {
        let appearance = UINavigationBarAppearance()
        
        if clear {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

// This struct called by splashscreen presents the settings screen

struct MasterView: View {
    
    
    
    @ObservedObject var store : Store = Store()
    
    @State private var selectedHarmonica : String = "C-Maj"
    @State private var selectedPosition : String = "1st"
    @State private var selectedMode : String  = "Major Key"
    @State private var selectedSustainSensitivity: String  = "2"
    @State private var harmonicaIndex : Int = 99
    @State private var modeIndex : Int = 1
    //@State private var registerIndex : Int = 1
    @State private var sharpsFlats : Int = 1
    @State private var positionIndex : String = "1st"
    @State private var selectedRegister : String = "Low"
    @State private var modeKeyList : [String] = defaultMode
    @State private var translationMap : [Int:Int]  = [0:0]
    @State private var harmonicaScreenText : String = "Default"
    
    @State var text: String = ""
    @State var showSheet = false
    
    @ObservedObject var modeRefresh = DummyObject()
    @ObservedObject var registerRefresh = DummyObject()
    
    @State var advertisement : ads = .AdsOn

    
    
    
    init() {
        UINavigationBar.changeAppearance(clear: true)
        

    }
    
    var body: some View {
        
        
        // These are the positions sent to tunerview
        let positionIndex = positionDict[selectedPosition] ?? 1
        let harmonicaIndex = (harmonicaBaseDict[selectedHarmonica] ?? 99)
        let modeIndex = modeDict[selectedMode] ?? 99
        let registerIndex = registerDict[selectedRegister] ?? 99
        let sustainSensetivityIndex = sustainSensitivityDict [selectedSustainSensitivity]  ?? 99
        
        // These are set values for the harmonica.
        let sharpsFlats = keyTypeDict[selectedHarmonica] ?? 1
        let freqRange = freqRangeDict [selectedHarmonica] ?? (80.00,2800.00)
        
        
        //NavigationView {
        List {
            //navigationTitle("FORM")
            
            
            // NAVIGATION TO TUNER VIEW -- THE SCREEN THAT MIMICS THE HARMONICA
            
            NavigationLink(destination: TunerView <TunerConductor> ( position : positionIndex, harmonicaBase: harmonicaIndex, sharpsFlats: sharpsFlats, freqRange: freqRange, mode: modeIndex, register: registerIndex, translationMap: translationMap, sustainSensitivity: sustainSensetivityIndex, adsOnOff: store.getAdsOnOff(), conductor: TunerConductor()))
            {
                Label("", systemImage: "mic").font(.system(size: 40))
                
                if positionIndex == 0 {Text (" Play \(selectedHarmonica) In First Position - No Translation").foregroundColor(.yellow).bold().font(.system(size: 20))
                        .padding(16)
                        .background(.blue)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                }
                else {
                    Text  ("Translate to \(selectedPosition) Position >")
                        .foregroundColor(.yellow).bold()
                        .font(.system(size: 20))
                        .padding(16)
                        .background(.blue)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                    
                }
                //else {UILabel ()}
                
            }
            
            //.navigationBarTitle("Harmonica Toolkit", displayMode: .inline )
            //.onAppear().supportedOrientations(.landscape)
            
            Label ( "Settings", systemImage: "gearshape").font(.system(size: 25))
            
            HStack {
                
                VStack {
                    
                    generalPickerView (selectedKeyValue: $selectedHarmonica, gIndex: harmonicaIndex, pickerArray: harmonicaBaseKeys, pickerLabel: "Harmonica") //, defaultValue: "B-Maj") // Default value has no effect
                    
                    
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                }
                VStack {
                    generalPickerView (selectedKeyValue: $selectedPosition.onChange(posValueChanged), gIndex: positionIndex, pickerArray: positionKeys, pickerLabel: "Position") //, defaultValue: "2nd")
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                    //Text(selectedPosition)
                }
                if positionIndex != 0 {
                    VStack {
                        generalPickerView (selectedKeyValue: $selectedMode, gIndex: modeIndex, pickerArray: modeKeyList, pickerLabel: "Mode") .id(modeRefresh.pickerId)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(8)
                        //Text(selectedMode)
                    }
                    /*
                     VStack {
                     generalPickerView (selectedKeyValue: $selectedRegister.onChange(otherValueChanged), gIndex: registerIndex, pickerArray: registers, pickerLabel: "Register") .id(registerRefresh.pickerId)
                     Text(selectedRegister)
                     }*/
                    
                    VStack {
                        generalPickerView (selectedKeyValue: $selectedRegister.onChange(otherValueChanged), gIndex: registerIndex, pickerArray: registers, pickerLabel: "Register")
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(8)
                        //Text(selectedRegister)
                    }
                    
                }
                Spacer(minLength: 18)
            }.padding(0)
            
            //if store.purchasedSubscriptions == [] {
            if store.getAdsOnOff() == .AdsOn {
                
                //if store.subscriptionGroupStatus?.rawValue == nil {
                
                HStack {
                    
                    //Text ("No Subscriptions")
                    BannerAD(unitID: "ca-app-pub-3940256099942544/2934735716") // FAKE ID
                    // Real ID // BannerAD(unitID: "ca-app-pub-7004820842080858/9944560513")
                    
                    Spacer(minLength: 35)
                }
         
                    NavigationLink(destination: SubscriptionsView().environmentObject(store) ) { Text("Remove Ads - Purchase Features")
                        
                            .padding(16)
                            .foregroundColor(.white)
                            .background(.blue)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(8)
                    }
                    
                
                
            }
            else {
                NavigationLink(destination: SubscriptionsView().environmentObject(store) ) { Text("Manage Subscriptions ")
                    
                        .padding(16)
                        .foregroundColor(.white)
                        .background(.blue)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                }
            }
            
            
            
            VStack {
                HStack {
                    Label ( "Sensitivity", systemImage: "clock.circle").font(.system(size: 25))
                    //Text ("Sensitivity")
                    generalPickerView (selectedKeyValue: $selectedSustainSensitivity, gIndex: registerIndex, pickerArray: sustainLengths, pickerLabel: "Sustain")
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                    //Text("Selected:\(selectedRegister)")
                    
                    Button("?") {
                        showSheet = true
                    }
                    .popover(isPresented: $showSheet) {
                        Pop (showSheet: self.$showSheet)
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .frame(minWidth: 25)
                    .cornerRadius(8)
                    Spacer(minLength: 20)
                }
            }
            
        }
        ._safeAreaInsets(EdgeInsets(top: -18, leading: 0, bottom: 0, trailing: 0))
        .background(Color.clear)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            
        }
        .onDisappear {
            UITableView.appearance().backgroundColor = .systemGroupedBackground
        }
        .frame(
            minWidth: 0,
            //maxWidth: .infinity,
            minHeight: 0,
            //maxHeight: .infinity
            alignment: .topLeading
        )
        .clipped()
        .compositingGroup()
        .padding(0)
        .navigationBarHidden(true)
        
    } // BODY END
    
    
    func posValueChanged(to value: String) {
        
        if selectedPosition == "1st"
        {selectedMode = "Major Key"
            modeKeyList = defaultMode
        }
        else {
            print ("POSITION : ??", selectedPosition, (positionDict [selectedPosition]! * 7) % 12 , "Register:",  selectedRegister, registerDict [selectedRegister]!, "Harmonica:", harmonicaBaseDict [selectedHarmonica]!)
            modeKeyList = modeKeys
            selectedMode = modeKeysMap [positionDict[value] ?? 0]
            selectedRegister = registers [registerDict[value] ?? 0]
            translationMap = getMapping(sharpsFlats: sharpsFlats, mode: modeIndex, register: registerDict [selectedRegister]!)
        }
        // This is a fix to make the mode pickers update when the position changes
        modeRefresh.incrementId()
        registerRefresh.incrementId()
    }
    
    func otherValueChanged(to value: String) {
        
        if selectedPosition == "1st"
        {selectedMode = "Major Key"
            modeKeyList = defaultMode
        }
        else {
            //print ("POSITION : ??", selectedPosition, (positionDict [selectedPosition]! * 7) % 12 , "Register:",  selectedRegister, registerDict [selectedRegister]!, "Harmonica:", harmonicaBaseDict [selectedHarmonica]!)
            //modeKeyList = modeKeys
            //selectedMode = modeKeysMap [positionDict[value] ?? 0]
            //selectedRegister = registers [registerDict[value] ?? 0]
            translationMap = getMapping(sharpsFlats: sharpsFlats, mode: modeIndex, register: registerDict [selectedRegister]!)
        }
        // This is a fix to make the mode pickers update when the position changes
        //modeRefresh.incrementId()
        //registerRefresh.incrementId()
    }
    
    
    func getMapping (sharpsFlats : Int , mode : Int, register : Int)  -> [Int:Int]
    {
        //print ("Getting Mapping for: ", position, harmonicaBase, mode, registerIndex)
        
        let pianoNotes = getNotes(flatsSharps: sharpsFlats)
        //var harmonicaActions : [(Int,Int)] = []
        var harmonicaActionsDict = [Int: Int]()
        let position : Int = positionDict [selectedPosition]!
        let positionOffset : Int  = (position * 7) % 12
        let posOffsetReg : Int = positionOffset + (register * 12)
        var translationMap : [Int:Int] = [9999:9999]
        
        print ("Pos INFO: ", "position: ", position, "positionoffset", positionOffset, "posoffreg: ", posOffsetReg)
        
        
        // No Translation if mode is 0
        if mode != 0 {
            
            for i in pianoNotes {
                if i.defaultAction != 0 {
                    //harmonicaActions.append ((i.pianoKey ?? 0 , i.defaultAction))
                    harmonicaActionsDict.updateValue (i.defaultAction, forKey: i.pianoKey!)
                }
            }
            // This does the calculation to calculate the translation defined in the settings screen
            for i in pianoNotes {
                if i.defaultAction != 0 {
                    
                    let modeCorrection = (i.pianoKey! - 40) % 12 // the mote played
                    let modeOffsetValue = modeOffset [modeCorrection]![mode - 1]
                    let translationKey = i.pianoKey! + posOffsetReg + modeOffsetValue
                    let translationAction = harmonicaActionsDict [translationKey] ?? 999
                    
                    translationMap.updateValue(translationAction, forKey: i.defaultAction)
                }
            }
        }
        return translationMap
    }
} //STRUCT END


// This defines what the pickers should look like
struct generalPickerView : View   {
    //@State var selectedNumber: Int = 0
    @Binding var selectedKeyValue : String
    @State var  gIndex : Int
    
    let pickerArray : [String]
    //let initialValue : Int
    let pickerLabel : String
    
    var customLabel: some View {
        Text(selectedKeyValue)
            .foregroundColor(.white)
            .font(.callout)
            .padding(8)
        //.frame(height: 32)
            .background(Color.blue)
            .cornerRadius(8)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 50,
                maxHeight: .infinity,
                //alignment: .topLeading,
                alignment: .center
            )
    }
    
    var body: some View {
        
        let binding = Binding<Int>(
            get: { self.gIndex},
            set: { self.gIndex = $0
                self.selectedKeyValue = pickerArray[self.gIndex]
            })
        
        Menu {
            Picker(selection: binding, label: EmptyView()) {
                ForEach(pickerArray.indices) {
                    Text(pickerArray[$0] )
                }
            }
        } label: {
            //Text (pickerArray[1])
            customLabel
        }
    }
}

