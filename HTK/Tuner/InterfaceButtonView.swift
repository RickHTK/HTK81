//
//  InterfaceButtonView.swift
//  HarmonicaToolkit
//
//  Created by HarmonicaToolkit on 30/12/2022.
//

// HARMONICA BUTTON
// These are the buttons in the keyboard below

import SwiftUI

struct interfaceButton  : View, Identifiable, Hashable {
    
    
    // Function to conform to equatable
    static func == (lhs: interfaceButton, rhs: interfaceButton) -> Bool {
        return
        
            lhs.Tag == rhs.Tag
        && lhs.displayed == rhs.displayed
        && lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.wingdings == rhs.wingdings
    }
    
    
    var id = UUID() // Variable to satisfy Identifiable
    
    //var nonDisplayedColor : UIColor = .white
    
    // variable parameters  passed from Array
    var buttonColor: UIColor // = .blue
    var textColor: UIColor // = .black
    var title: String
    var wingdings: String
    var rowNo: Int
    var colNo: Int
    var Tag: Int
    var displayed: String
    
    
    //var fontType: Bool = true
    
    // Function to conform to hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(Tag)
    }
    
    

    var body: some View {
        
        let historyButtonStyle = keyboardButtonLabelStyle (fontSize: 24, fontName: "Wingdings2", textColor: textColor)
        let playingButtonStyle = keyboardButtonLabelStyle (fontSize: 20, fontName: "AppleSymbols", textColor: textColor)
        let BoilerplateButtonStyle = keyboardButtonLabelStyle (fontSize: 11, fontName: "", textColor: textColor)
        let NotDisplayed = keyboardButtonLabelStyle (fontSize: 14, fontName: "", textColor: textColor)
        let NotePlayingButtonStyle = keyboardButtonLabelStyle (fontSize: 20, fontName: "AppleSymbols", textColor: .white)
        
        if #available(iOS 15.0, *) {
        Button {}
            
        // This is the label text shown on the button
        label: { Text (title)}
            .frame ( minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .center )
            .buttonStyle (displayed == "H" ? historyButtonStyle : ( displayed == "1" ? playingButtonStyle : (displayed == "B" ? BoilerplateButtonStyle : (displayed == "P" ? NotePlayingButtonStyle : NotDisplayed))))
            .tag (rowNo * 100 + colNo)
            .background(displayed == "P" ? .black  : Color(buttonColor))
            .clipped()
            
        }
        else {
            // Fallback on earlier versions
        }
    }
}