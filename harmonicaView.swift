//
//  SwiftUIView.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 26.01.22.
//

import UIKit
import SwiftUI
/*
struct newviewcontroller: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let test = ViewController3 ()
        //let test = hvcii ()
        
        return (test)
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    typealias UIViewControllerType = UIViewController
    
   
}*/
/*
class Tunerview3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        create_amp_check()
    }
    func create_amp_check () {
    let conductor2 = TunerConductor()
    let stackV2 =
        HStack {
            Text("Frequency")
            Spacer()
            Text("\(conductor2.data.pitch, specifier: "%0.1f")")
        }.padding()

        
    
    .onAppear {
        conductor2.start()
    }
    .onDisappear {
        conductor2.stop()
    }
    view.addSubview(stackV2)

}

}*/

    
// This is the new code


/*
// This is the test view controller
class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createButton()
    }

    func createButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center = view.center
        if #available(iOS 15.0, *) {
            button.configuration = createConfig()
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(button)
    }
    
    @available(iOS 15.0, *)
    func createConfig() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.title = "Food Stop"
        config.subtitle = "subtitle"
        config.baseBackgroundColor = .systemCyan
        config.titleAlignment = .center
        
        return config
    }
}*/
    
    
    
    
    
    
    
    //private let AUTO_PLIST_NOTES_PATH = Bundle.main.path(forResource: "Notes", ofType: "plist")

    /*private let AUTO_PLIST_NOTES_KEY_PIANOKEY = "pianoKey"   // pianoKey
    private let AUTO_PLIST_NOTES_KEY_NOTENAME = "noteName"   // noteName
    private let AUTO_PLIST_NOTES_KEY_FREQUENCY = "frequency"   // frequency*/


    //private let AUTO_PLIST_BUTTONDEFNS_PATH = Bundle.main.path(forResource: "ButtonDefns", ofType: "plist")

    //private let AUTO_PLIST_BUTTONDEFNS_KEY_BUTTON = "button"   // button
    //private let AUTO_PLIST_BUTTONDEFNS_KEY_OFFSET = "offset"   // offset
    //private let AUTO_PLIST_BUTTONDEFNS_KEY_WINGDINGS = "wingDings"   // wingDings
    //private let AUTO_PLIST_BUTTONDEFNS_KEY_BACKGROUND = "background"   // background
    
/*
class hvci: UIViewController {
        
    //@StateObject var conductor2 = TunerConductor()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        //displayKeyboard()
    }
        
    @objc func buttonAction(sender: UIButton!) {
        //try! AudioKit.stop()
        performSegue(withIdentifier: "gotoSettings", sender: "")
        
    }
     
    var positionChosen : Int = 0 // No Translation Position

    /*private let AUTO_PLIST_NOTES_KEY_PIANOKEY = "pianoKey"   // pianoKey
    private let AUTO_PLIST_NOTES_KEY_NOTENAME = "noteName"   // noteName
    private let AUTO_PLIST_NOTES_KEY_FREQUENCY = "frequency"   // frequency

    private let AUTO_PLIST_NOTES_KEY_PIANOKEY = "pianoKey"   // pianoKey
    private let AUTO_PLIST_NOTES_KEY_NOTENAME = "noteName"   // noteName
    private let AUTO_PLIST_NOTES_KEY_FREQUENCY = "frequency"   // frequency*/

    
    
    
    let AUTO_PLIST_NOTES_PATH = Bundle.main.path(forResource: "Notes", ofType: "plist")
    let AUTO_PLIST_BUTTONDEFNS_PATH = Bundle.main.path(forResource: "ButtonDefns", ofType: "plist")
    let AUTO_PLIST_BUTTONDEFNS_KEY_BUTTON = "button"   // name of button field in dictionary
    let AUTO_PLIST_BUTTONDEFNS_KEY_OFFSET = "offset"   // offset
    let AUTO_PLIST_BUTTONDEFNS_KEY_WINGDINGS = "wingDings"   // wingDings
    let AUTO_PLIST_BUTTONDEFNS_KEY_BACKGROUND = "background"   // background
    let AUTO_PLIST_NOTES_KEY_PIANOKEY = "pianoKey"   // pianoKey
    let AUTO_PLIST_NOTES_KEY_NOTENAME = "noteName"   // noteName
    let AUTO_PLIST_NOTES_KEY_FREQUENCY = "frequency"   // frequency
    
    func getButtonDefs() -> [ButtonDefns]{
        
        var _buttonDefnss = [ButtonDefns]()
        
        if _buttonDefnss.count > 0 {
            return _buttonDefnss
        }
        
        if let allDatas = NSArray(contentsOfFile: AUTO_PLIST_BUTTONDEFNS_PATH!) {
            
            for dict in allDatas {
                guard let dict = dict as? [String: AnyObject] else {continue}
                
                let buttonDefns = ButtonDefns()
                buttonDefns.button = (dict[AUTO_PLIST_BUTTONDEFNS_KEY_BUTTON] as? Int)! // button
                buttonDefns.offset = Int ((dict[AUTO_PLIST_BUTTONDEFNS_KEY_OFFSET] as? String ?? "0")) // offset
                buttonDefns.wingDings = dict[AUTO_PLIST_BUTTONDEFNS_KEY_WINGDINGS] as? String // wingDings
                buttonDefns.background = dict[AUTO_PLIST_BUTTONDEFNS_KEY_BACKGROUND] as? String // background
                switch buttonDefns.background
                {
                case "white":
                    buttonDefns.backColor = white
                case "black":
                    buttonDefns.backColor = black
                case "lblue1":
                    buttonDefns.backColor = lblue1
                case "lblue2":
                    buttonDefns.backColor = lblue2
                case "lblue3":
                    buttonDefns.backColor = lblue3
                case "orange":
                    buttonDefns.backColor = orange
                case "lorange1":
                    buttonDefns.backColor = lorange1
                case "green":
                    buttonDefns.backColor = green
                case "lgreen":
                    buttonDefns.backColor = lgreen
                case "blowColor":
                    buttonDefns.backColor = blowColor
                case "drawColor":
                    buttonDefns.backColor = drawColor
                default:
                    buttonDefns.backColor = white
                }
                
                _buttonDefnss.append(buttonDefns)
            }
        }
        return _buttonDefnss
    }
 

    func actionButton   ( withColor color:UIColor,
                          titleColor:UIColor,
                          title:String,
                          tag:Int,
                          font:String  //,deviceSize:Int
                        ) -> UIButton
    {
        
        
        let newButton = UIButton(type: .system)
        newButton.backgroundColor = color
        newButton.titleLabel!.numberOfLines = 1;
        newButton.titleLabel!.adjustsFontSizeToFitWidth = true;
        newButton.titleLabel!.lineBreakMode = NSLineBreakMode.byClipping
        newButton.setTitle( title, for: UIControl.State.normal)
        newButton.titleLabel!.numberOfLines = 0
        //newButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        newButton.titleLabel?.textAlignment = .center
        newButton.titleLabel?.font = .systemFont(ofSize: labelFontSize)
        
        
        if font != ""
        {
        newButton.titleLabel?.font = UIFont(name: font, size: tabFontSize)
        }
        else
        {
        //newButton.titleLabel?.font = UIFont(name: "System", size: 8)
        }
        newButton.setTitleColor (titleColor, for: UIControl.State.normal)
        newButton.tag = tag
        //newButton.titleLabel?.font =  UIFont(name: "System", size: 8)
        //print ("actionButton:", tag, title, color)
        return newButton
    }

    
    
    func getNotes() -> [Notes]{
        
        var _notes = [Notes]()
        
        if _notes.count > 0 {
            return _notes
        }
        
        if let allData = NSArray(contentsOfFile: AUTO_PLIST_NOTES_PATH!) {
            
            for dict in allData {
                guard let dict = dict as? [String: AnyObject] else {continue}
                
                let notes = Notes()
                notes.pianoKey = dict[AUTO_PLIST_NOTES_KEY_PIANOKEY] as? Int // pianoKey
                notes.noteName = dict[AUTO_PLIST_NOTES_KEY_NOTENAME] as? String // noteName
                notes.frequency = (dict[AUTO_PLIST_NOTES_KEY_FREQUENCY] as? NSString)?.floatValue // frequency
                _notes.append(notes)
            }
        }
        return _notes
    }
 */
/*
    
    func displayKeyboard() -> [[UIButton]]  {

        
        // MARK: Set values for settings
        if baseAmplitude == 0
        { baseAmplitude = defaultBaseAmplitude}
        
        if frequencyAccuracy == 0
        { frequencyAccuracy = defaultFrequencyAccuracy}

        // MARK: generate arrays of buttons
        var overblowRow = [UIButton]()
        var blowBendRow = [UIButton]()
        var blowRow = [UIButton]()
        var holeRow = [UIButton]()
        var drawRow = [UIButton]()
        var drawBend1Row = [UIButton]()
        var drawBend2Row = [UIButton]()
        var overDrawRow = [UIButton]()
        var buttonArray2 = [UIView]()
        var lastActions = [UIButton]()
        var actionsTranslated = [UIButton]()
        
        var allButtons = [[UIButton]]()
        
        
        //allButtons += [overblowRow]
        //allButtons += [blowBendRow]
        
        
        let harmonicaActionRows = [
            1: overblowRow,
            2: blowBendRow,
            3: blowRow,
            4: holeRow,
            5: drawRow,
            6: drawBend1Row,
            7: drawBend2Row,
            8: overDrawRow,
            9: lastActions,
            10: actionsTranslated
        ]
        
        var buttonTag : Int = 0
        
        // MARK: Variables for last actions

        var buttonHistory : [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        //var altButton : [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        let noteFrequencies = getNotes()
        
        let buttonDefns = getButtonDefs()
        
        var noteRegistered : Bool = false
        var pauseLength : Int = 0
        
        //let positionMap = getPositionMaps()
        
        // MARK: button Frequencies is a configured subset of the noteFrequencies
        // assigned at button set up used by the playgroundLoop
        // Associates a frequency to a button
        var buttonFrequencies = [Int : Float]()
        
        // MARK: holeNames
        let holeNames = [
            1    :    "1",
            2    :    "2",
            3    :    "3",
            4    :    "4",
            5    :    "5",
            6    :    "6",
            7    :    "7",
            8    :    "8",
            9    :    "9",
            10   :   "10"
        ]
       

        // MARK: Set Up Buttons
        // ***************************************************************************************************
        // This sets up the initial screen
        // There is no need for this loop unless it can be made to work.. all the cases are set up separetly without reference to harmonicaActionRows
    for i in harmonicaActionRows
    {
        //print (i.key, i.value)
            switch i.key
            {
                
            case  (1) : // overBlowRow
                buttonTag = i.key*100
                let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                //overblowRow += [actionButton(withColor: buttonBackColors [i.key*100]!, titleColor: lorange1, title: "Over Blow", tag:
                overblowRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: lorange1, title: "Over Blow", tag: buttonTag, font:"")]
                for _ in 1...10
                {
                    buttonTag += 1
                    let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    if (chosenButton?.offset) == 99
                    {
                    overblowRow +=  [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title:  "", tag: buttonTag, font : "")]
                    }
                    else
                    {
                    overblowRow +=  [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title:  noteFrequencies [harmonicaBase + (chosenButton?.offset)!].noteName ?? "", tag: buttonTag, font : "")]
                    buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + (chosenButton?.offset)!].frequency
                    }
                }
                buttonTag += 1
                overblowRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: lblue2, title: "Blow Bend", tag: buttonTag, font:"")]
                
            case  (2) : // blowBendRow
                buttonTag = i.key*100
                let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                blowBendRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: lorange1, title: "", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                    buttonTag += 1
                    let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    if chosenButton?.offset == 99
                    {
                    blowBendRow +=  [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title: "", tag: buttonTag, font : "")]
                    }
                    else
                    {
                    blowBendRow +=  [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title:  noteFrequencies [harmonicaBase + (chosenButton?.offset)!].noteName ?? "", tag: buttonTag, font : "")]
                    buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + (chosenButton?.offset)!].frequency
                    }
                }
                buttonTag += 1
                blowBendRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: lblue2, title: "", tag: buttonTag, font : "")]
                
            case  (3) : // blowRow
                buttonTag = i.key*100
                let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                blowRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                    buttonTag += 1
                    let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    blowRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title:  noteFrequencies [harmonicaBase + (chosenButton?.offset)!].noteName ?? "", tag: buttonTag, font : "")]
                    if (chosenButton?.offset) != 99 // Not required here because all buttons are enabled
                        {
                            buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + (chosenButton?.offset)!].frequency
                        }
                }
                buttonTag += 1
                blowRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
            
            case  (4) : // holeRow
                buttonTag = i.key*100
                let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                holeRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: harmonicaNames[harmonicaBase-23].harmonicaName , tag: buttonTag, font: "")]
                if let button400 = self.view.viewWithTag(400) as? UIButton
                {
                    //print ("set up button 400")
                    button400.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                }
                for j in 1...11
                {
                    buttonTag += 1
                    let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    holeRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title: holeNames[j] ?? "", tag: buttonTag, font: "")]
                }
                
            case  (5) : // drawRow
                buttonTag = i.key*100
                var chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                drawRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                    buttonTag += 1
                    chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    drawRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title:  noteFrequencies [harmonicaBase + (chosenButton?.offset)!].noteName ?? "", tag: buttonTag, font : "")]
                    buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + (chosenButton?.offset)!].frequency
                }
                buttonTag += 1
                chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                drawRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                
            case  (6) : // drawBend1Row
                buttonTag = i.key*100
                var chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                drawBend1Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                    buttonTag += 1
                    chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    if (chosenButton?.offset) == 99
                    {
                    drawBend1Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title:  "", tag: buttonTag, font : "")]
                    }
                    else
                    {
                    drawBend1Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title:  noteFrequencies [harmonicaBase + (chosenButton?.offset)!].noteName ?? "", tag: buttonTag, font : "")]
                    buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + (chosenButton?.offset)!].frequency
                    }
                }
                buttonTag += 1
                chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                drawBend1Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                
            case  (7) : // drawBend2Row
                buttonTag = i.key*100
                var chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                drawBend2Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                    buttonTag += 1
                    chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    if (chosenButton?.offset) == 99
                    {
                    drawBend2Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title:  "", tag: buttonTag, font : "")]
                    }
                    else
                    {
                    //print ((chosenButton?.offset)!)
                    drawBend2Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title:  noteFrequencies [harmonicaBase + (chosenButton?.offset)!].noteName ?? "", tag: buttonTag, font : "")]
                    buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + (chosenButton?.offset)!].frequency
                    }
                }
                buttonTag += 1
                chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                drawBend2Row += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                
            case  (8) : // overDrawRow
                buttonTag = i.key*100
                var chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                overDrawRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: lblue2, title: "Draw Bend", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                buttonTag += 1
                chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                if (chosenButton?.offset) == 99
                {
                overDrawRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title: "", tag: buttonTag, font : "")]
                }
                else
                {
                overDrawRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title:  noteFrequencies [harmonicaBase + (chosenButton?.offset)!].noteName ?? "", tag: buttonTag, font : "")]
                    
                            buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + (chosenButton?.offset)!].frequency
                }
                }
                buttonTag += 1
                chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                overDrawRow += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: green, title: "Over Draw", tag: buttonTag, font : "")]

            case  (9) : // buttonHistory  -- lastActions
                buttonTag = i.key*100
                var chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                lastActions += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: lblue2, title: "", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                    buttonTag += 1
                    chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    lastActions += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "Wingdings2")]
                    //buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + buttonOffsets[buttonTag]!]
                }
                buttonTag += 1
                chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                lastActions += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: white, title: "", tag: buttonTag, font : "Wingdings2")]
            
            case  (10) : // buttonHistory translated
                buttonTag = i.key*100
                var chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                actionsTranslated += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "")]
                for _ in 1...10
                {
                    buttonTag += 1
                    let chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                    actionsTranslated += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: "", tag: buttonTag, font : "Wingdings2")]
                    //buttonFrequencies[buttonTag] = noteFrequencies[harmonicaBase + buttonOffsets[buttonTag]!]
                }
                buttonTag += 1
                chosenButton =  buttonDefns.first (where: {$0.button == buttonTag})
                actionsTranslated += [actionButton(withColor: (chosenButton?.backColor)!, titleColor: black, title: ";", tag: buttonTag, font : "webdings")]

                
                
                
            default : break //print ("Error 12: ", i.key)
            } // End of Case
    } //End of loop
        
        if let buttonPressed = self.view.viewWithTag(400) as? UIButton
        {
        buttonPressed.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        }
        if let buttonPressed = self.view.viewWithTag(1000) as? UIButton
        {
        buttonPressed.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        }
        
        // MARK: Settings screen button

 
        let settingsButton = actionButton(withColor: lgrey, titleColor: white, title: "Settings", tag: 2000, font:"")
         
        

        
        settingsButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        buttonArray2 += [actionButton(withColor: UIColor.white, titleColor: black, title: "", tag: 9001, font:"")]
        buttonArray2 += [settingsButton]
        buttonArray2 += [actionButton(withColor: UIColor.white, titleColor: white, title: "", tag: 9000, font:"")]
        
        
        
        allButtons.append (overblowRow)
        allButtons.append (blowBendRow)
        
        
        
        
        let subStackView2 = UIStackView(arrangedSubviews: buttonArray2)
        subStackView2.axis = .horizontal
        subStackView2.distribution = .fillEqually
        subStackView2.alignment = .fill
        subStackView2.spacing = 2
        
        //subStackView2.addArrangedSubview(NoteInfo)  //Test
        
        // MARK: Set Up all the SubStacks
        let OBsubStackView = UIStackView(arrangedSubviews: overblowRow)
        OBsubStackView.axis = .horizontal
        OBsubStackView.distribution = .fillEqually
        OBsubStackView.alignment = .fill
        OBsubStackView.spacing = 2

        let BBsubStackView = UIStackView(arrangedSubviews: blowBendRow)
        BBsubStackView.axis = .horizontal
        BBsubStackView.distribution = .fillEqually
        BBsubStackView.alignment = .fill
        BBsubStackView.spacing = 2
        
        let BLsubStackView = UIStackView(arrangedSubviews: blowRow)
        BLsubStackView.axis = .horizontal
        BLsubStackView.distribution = .fillEqually
        BLsubStackView.alignment = .fill
        BLsubStackView.spacing = 2
        
        let HOsubStackView = UIStackView(arrangedSubviews: holeRow)
        HOsubStackView.axis = .horizontal
        HOsubStackView.distribution = .fillEqually
        HOsubStackView.alignment = .fill
        HOsubStackView.spacing = 2
        
        let DRsubStackView = UIStackView(arrangedSubviews: drawRow)
        DRsubStackView.axis = .horizontal
        DRsubStackView.distribution = .fillEqually
        DRsubStackView.alignment = .fill
        DRsubStackView.spacing = 2
        
        let DB1subStackView = UIStackView(arrangedSubviews: drawBend1Row)
        DB1subStackView.axis = .horizontal
        DB1subStackView.distribution = .fillEqually
        DB1subStackView.alignment = .fill
        DB1subStackView.spacing = 2
        
        let DB2subStackView = UIStackView(arrangedSubviews: drawBend2Row)
        DB2subStackView.axis = .horizontal
        DB2subStackView.distribution = .fillEqually
        DB2subStackView.alignment = .fill
        DB2subStackView.spacing = 2
        
        let ODsubStackView = UIStackView(arrangedSubviews: overDrawRow)
        ODsubStackView.axis = .horizontal
        ODsubStackView.distribution = .fillEqually
        ODsubStackView.alignment = .fill
        ODsubStackView.spacing = 2
    
        // MARK: Button that manages top spacing.
        _ = actionButton(withColor: lgrey, titleColor: black, title: "HELLO WORLD", tag: 9000, font:"")
        
        //MARK: Advertising Banner set up
        //harmonicaWindowBanner = GADBannerView(adSize: kGADAdSizeBanner)
        //addBannerViewToView(harmonicaWindowBanner)
        
        //harmonicaWindowBanner.adUnitID = "ca-app-pub-9689585946687619/1813724486"
        
        
        //harmonicaWindowBanner.adUnitID = adBannerId //"ca-app-pub-3940256099942544/2934735716"
        
        //harmonicaWindowBanner.rootViewController = self
        //harmonicaWindowBanner.load(GADRequest())
        
        let subStackView3 = UIStackView(arrangedSubviews: lastActions)
        subStackView3.axis = .horizontal
        subStackView3.distribution = .fillEqually
        subStackView3.alignment = .fill
        subStackView3.spacing = 2
        
        let subStackView4 = UIStackView(arrangedSubviews: actionsTranslated)
        subStackView4.axis = .horizontal
        subStackView4.distribution = .fillEqually
        subStackView4.alignment = .fill
        subStackView4.spacing = 2
        
        
        
        // MARK: Set up outer stackview
        let stackView = UIStackView (arrangedSubviews:
            [
                //blackButton,
                //bannerView2,
                //harmonicaWindowBanner,
                //blackButton,
                OBsubStackView,
                BBsubStackView,
                BLsubStackView,
                HOsubStackView,
                DRsubStackView,
                DB1subStackView,
                DB2subStackView,
                ODsubStackView,
                subStackView3,
                subStackView2
                
                
            ]
        )
        if positionChosen != 0
        {
            stackView .addArrangedSubview(subStackView4)
        }
        //stackView .addArrangedSubview(harmonicaWindowBanner)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        
        
        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["stackView":stackView]
        //let topGuide = view.safeAreaLayoutGuide.topAnchor
        
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-30-[stackView]-30-|",  //horizontal constraint 20 points from left and right side
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(stackView_H)
        
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-30-[stackView]-30-|", //vertical constraint 30 points from top and bottom
            options: NSLayoutConstraint.FormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(stackView_V)
        
        
        for rows in allButtons {
            for columns in rows{
                
            }
                    
        }
                
        
        
        return allButtons
        
        
        
} // end of funcDisplayKeyboard
  
//var buttonArray = displayKeyboard(<#T##self: hvci##hvci#>)

        

 
}
*/
