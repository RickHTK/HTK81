//
//  ButtonArray.swift
//  HarmonicaToolkit
//
//  Created by HarmonicaToolkit on 30/12/2022.
//

struct buttonArrayStruct
{
    
    let keyboard : [[interfaceButton]] = buttonArray(note: "", noteHistory: [noteDetail ( note: "£", sustainLength : 1, pianoKey: 0)], position: 0, harmonicaBase: 13, sharpsFlats: 0, mode: 0, register: 0, translationMap: [0:0])
}


// Uses the Button definitions list and turns it into a 2d grid


func buttonArray (note: String, noteHistory : [noteDetail] , position : Int, harmonicaBase : Int, sharpsFlats : Int, mode : Int, register : Int, translationMap : [Int : Int] ) -> [[interfaceButton]] {
    
    let buttonColumns = [0,1,2,3,4,5,6,7,8,9,10,11]
    let actionRows = [1,2,3,4,5,6,7,8]
    
    var buttonRow : [interfaceButton] = []
    var historyButtonRow : [interfaceButton] = []
    var translationButtonRow : [interfaceButton] = []
    
    var buttonArray : [[interfaceButton]] = [[]]
    
    let buttonKey = getButtonDefs(note: note, callType: "dynamic", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
    let staticButtonKey = getButtonDefs(note: note, callType: "static", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
    
    
    print ("Note ", note)
    
    // Creates the Array of buttons
    // 1. Creates a grid
    
    for rowValue in actionRows {
        for columnValue in buttonColumns {
            
            let buttonTagNo = (rowValue * 100) + columnValue
            
            let chosenButton = (
                buttonKey.first (where: {$0.button == buttonTagNo})
                                   )
            
            let currentButton = interfaceButton (buttonColor: chosenButton?.backColor ?? .black,
                                                 textColor: chosenButton?.textColor ?? .white,
                                                 title: (chosenButton?.buttonLabel) ?? "x",
                                                 wingdings: chosenButton?.wingdings ?? "x",
                                                 rowNo: rowValue,
                                                 colNo: columnValue,
                                                 Tag: rowValue * 100 + columnValue,
                                                 displayed: chosenButton?.displayed ?? ""
            )
            buttonRow.append (currentButton)
            
        }
        buttonArray.append( buttonRow)
        buttonRow = []
    }
    
    
    
    
    // 2. Adds the history and translation  buttons at the bottom
    for (index, playedNote) in noteHistory.enumerated() {
        // 2.a This is the history of notes played
        guard let chosenButton = (
            staticButtonKey.first (where: {$0.buttonLabel! == playedNote.note && $0.button != 103 && $0.button != 207 }) //there is more than one button for the same note 103, 107
        ) else {
            print ("NOT FOUND!", playedNote)
            continue
        }
        
        let currentButton = interfaceButton (buttonColor: chosenButton.backColor!,
                                             textColor: chosenButton.textColor!,
                                             title: (chosenButton.wingdings)!,
                                             wingdings: chosenButton.wingdings!,
                                             rowNo: 9,
                                             colNo: 99,
                                             Tag: 900 + index,
                                             displayed: "H"
        )
        historyButtonRow.append (currentButton)
        
        
        
        // 2.b adds the Translate  button  row at the bottom
        if position != 0 {
        
            guard let translationButton = (
                //staticButtonKey.first (where: {$0.button == standardPosMapping[chosenButton.button]![position]})
                staticButtonKey.first (where: {$0.button == translationMap[chosenButton.button] ?? 9999})
            ) else {print ("NOT FOUND!"); continue}
            
            
            
            let currentTranslationButton = interfaceButton (buttonColor: translationButton.backColor!,
                                                 textColor: translationButton.textColor!,
                                                 title: (translationButton.wingdings)!,
                                                 wingdings: translationButton.wingdings!,
                                                 rowNo: 10,
                                                 colNo: 99,
                                                 Tag: 1000 + index,
                                                 displayed: "H"
            )
            
            translationButtonRow.append (currentTranslationButton)
        }
        else {
            translationButtonRow.append (
                interfaceButton (buttonColor: .white,
                                 textColor: .white,
                                 title: "",
                                 wingdings: "",
                                 rowNo: 10,
                                 colNo: 99,
                                 Tag: 1000 + index,
                                 displayed: "N"
                                 )
            
            )
            }
        
    } // END OF LOOP
    
    buttonArray.append(historyButtonRow)
    buttonArray.append(translationButtonRow)
    
    return buttonArray
}
