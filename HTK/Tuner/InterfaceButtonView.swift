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
           lhs.buttonLabelTag       == rhs.buttonLabelTag
        && lhs.buttonLabelDisplayed == rhs.buttonLabelDisplayed
        && lhs.id                   == rhs.id
        && lhs.buttonLabelTitle     == rhs.buttonLabelTitle
        && lhs.buttonLabelWingdings == rhs.buttonLabelWingdings
        //&& lhs.buttonColor == rhs.buttonColor
    }
    
    let id = UUID() // Variable to satisfy Identifiable
    let buttonLabelbuttonColor: UIColor
    let buttonLabelTextColor: UIColor
    let buttonLabelTitle: String
    let buttonLabelWingdings: String
    let buttonLabelTag: Int
    let buttonLabelDisplayed: harmonicaKeyboardDisplayType
    let buttonLabelButtonStyle: keyboardButtonLabelStyle
    
    
    
    init (buttonColor: UIColor, textColor: UIColor, title: String, wingdings: String, Tag: Int, displayed: harmonicaKeyboardDisplayType
    ) {
        switch displayed
        {
        case .playing :  buttonLabelButtonStyle = keyboardButtonLabelStyle (fontSize: 20, fontName: "AppleSymbols", textColor: textColor)
        case .playable : buttonLabelButtonStyle = keyboardButtonLabelStyle (fontSize: 20, fontName: "AppleSymbols", textColor: textColor)
        case .history : buttonLabelButtonStyle = keyboardButtonLabelStyle (fontSize: 24, fontName: "Wingdings2", textColor: textColor)
        case .boilerplate : buttonLabelButtonStyle = keyboardButtonLabelStyle (fontSize: 11, fontName: "", textColor: textColor)
        default : buttonLabelButtonStyle = keyboardButtonLabelStyle (fontSize: 14, fontName: "", textColor: textColor)
        }
        buttonLabelbuttonColor = buttonColor
        buttonLabelTextColor = textColor
        buttonLabelTitle = title
        buttonLabelWingdings = wingdings
        buttonLabelTag = Tag
        buttonLabelDisplayed = displayed
    }
    
    // Function to conform to hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(buttonLabelTag)
    }
    
    

    
    var body: some View {
     
        let accessibilityIdentifierString : String = String(buttonLabelTag)
        
        //if #available(iOS 15.0, *) {
            /*
             Button {}
             
             // This is the label text shown on the button
             label: { Text (buttonLabelTitle)} // can be replaced with accessibility id for testing
             .frame ( minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .center )
             .buttonStyle(buttonLabelButtonStyle)
             .tag (buttonLabelTag)
             .background(buttonLabelDisplayed == .playing ? .black  : Color(context_buttonColor))
             .clipped()
             .accessibilityIdentifier(accessibilityIdentifierString)
             
             }*/
            
            Text (buttonLabelTitle) // can be replaced with accessibility id for testing
                //.withActionButtonStyles()
        
                .frame ( minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .center )
                .buttonStyle(buttonLabelButtonStyle)
                .tag (buttonLabelTag)
                .background(buttonLabelDisplayed == .playing ? .black  : Color(buttonLabelbuttonColor))
                .clipped()
                .accessibilityIdentifier(accessibilityIdentifierString)
                
                
        //}
    
    }
}



let buttonLabelButtonStyle = keyboardButtonLabelStyle (fontSize: 20, fontName: "AppleSymbols", textColor: .black)

extension Text {

    func withActionButtonStyles() -> some View {
        
            self
            .buttonStyle(buttonLabelButtonStyle)
            .padding(10)
            .padding(.horizontal, 20)
            //.background(Color.yellow)
            //.foregroundColor(.black)
            .cornerRadius(2)

        
    }
    
}
