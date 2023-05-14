//
//  ButtonArray.swift
//  HarmonicaToolkit
//
//  Created by HarmonicaToolkit on 30/12/2022.
//
/*
 Returns a 2D grid of Interface Buttons to be placedin the keyboard view
 */

func buttonArray (notePlaying: String, noteHistory : [noteDetail] , position : Int, harmonicaBase : Int, sharpsFlats : Int, mode : Int, register : Int, translationMap : [Int : Int] ) -> [[interfaceButton]] {
    
    let buttonColumns = [0,1,2,3,4,5,6,7,8,9,10,11]
    let actionRows = [1,2,3,4,5,6,7,8]
    var buttonGrid : [[interfaceButton]] = [[]]
    var buttonRow : [interfaceButton] = []
    var historyButtonRow : [interfaceButton] = []
    let buttonKey = getButtonDefs(note: notePlaying, callType: "dynamic", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
    let staticButtonKey = getButtonDefs(note: notePlaying, callType: "static", harmonicaBase: harmonicaBase, sharpsFlats: sharpsFlats)
    
    
    print ("Note ", notePlaying)
    
    // Creates the Array of buttons
    // 1. Creates a grid
    
    for rowValue in actionRows {
        
        for columnValue in buttonColumns {
            
            let buttonTagNo = (rowValue * 100) + columnValue
            
            let chosenButton = (
                buttonKey.first (where: {$0.buttonId == buttonTagNo})
                                   )
            
            let currentButton = interfaceButton (buttonColor: chosenButton!.backColor!,
                                                 textColor: chosenButton!.textColor!,
                                                 title: (chosenButton?.buttonLabel)!,
                                                 wingdings: chosenButton!.wingdings!,
                                                 rowNo: rowValue,
                                                 colNo: columnValue,
                                                 Tag: rowValue * 100 + columnValue,
                                                 displayed: chosenButton!.displayed!
            )
            buttonRow.append (currentButton)
            
        }
        buttonGrid.append( buttonRow)
        buttonRow = []
    }
    
    // 2. Adds the notes played  buttons at the bottom
    for (index, playedNote) in noteHistory.enumerated() {
        // This is the history of notes played
        guard let chosenButton = (
            staticButtonKey.first (where: {$0.buttonLabel! == playedNote.note && $0.buttonId != 103 && $0.buttonId != 207 }) //there is more than one button for the same note 103, 107
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
        buttonRow.append (currentButton)
        
        // 3. adds the Translate  button  row at the bottom
        if position != 0 {
        
            guard let translationButton = (
                //staticButtonKey.first (where: {$0.button == standardPosMapping[chosenButton.button]![position]})
                staticButtonKey.first (where: {$0.buttonId == translationMap[chosenButton.buttonId] ?? 9999})
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
            
            historyButtonRow.append (currentTranslationButton)
        }
        else {
            historyButtonRow.append (
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
    
    buttonGrid.append(buttonRow)
    buttonGrid.append(historyButtonRow)
    
    return buttonGrid
}


func buttonArray2 (notePlaying: String, noteHistory : [noteDetail] , position : Int, harmonicaBase : Int, sharpsFlats : Int, mode : Int, register : Int, translationMap : [Int : Int] ) -> [[interfaceButton]] {
    
    //let i = getKeyboardDisplayed(note: notePlaying, callType: .dynamicDisplayKey, harmonicaBase: 17, sharpsFlats: 0)
    
    
    return [[]]
}
