//
//  HelpView.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 06/09/2022.
//

import Foundation
import SwiftUI



struct Pop: View {
    @Binding var showSheet: Bool
    
    
    //@Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Image ("HTK-icon")
            .resizable()
            .scaledToFit()
            .padding()
        
            .frame(
                  minWidth: 0,
                  maxWidth: 150,
                  minHeight: 0,
                  maxHeight: 150,
                  alignment: .topLeading
                )
            
        Text("**HELP : Sensitivity** \nSensitivity sets the length of time that a note must be held for in order that it is recorded. The optimum value varies depends on the phone, the harmonica and the player. ")
            //.font(.headline)
            .foregroundColor(.black)
        Button("Close")
        {
            #if os(OSX)
            NSApp.sendAction(#selector(NSPopover.performClose(_:)), to: nil, from: nil)
            #else
            //self.presentationMode.wrappedValue.dismiss() // << behaves the same as below
            #endif
            
            showSheet = false
            
            
            
        }

        
        .padding()
        .background(.blue)
        .foregroundColor(.white)
        .frame(minWidth: 25)
        .cornerRadius(8)
        
    }
}
