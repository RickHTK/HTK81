//
//  storeCallView.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 07/09/2022.
//

import Foundation
import SwiftUI

struct storeCallView some view {
    
    @EnvironmentObject store : Store
    
    NavigationLink(destination: StoreView() ) { Text("Remove Ads & Purchase Features ")
            .padding(16)
            .foregroundColor(.white)
            .background(.blue)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(8)
    }.environmentObject(store)

}
