//
//  GridView.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 02/08/2022.
//

import Foundation
import SwiftUI



struct dummyContentView: View {
    var body: some View {
        Image ("NOTANIMAGEFILE")
            .resizable()
            .scaledToFit()
            .padding()
    }
}

struct gridContentView: View {
    var body: some View {
        HStack {
            VStack {
                dummyContentView()
                dummyContentView()
                dummyContentView()
                dummyContentView()
                BannerAD(unitID: "ca-app-pub-3940256099942544/2934735716")
            }
            dummyContentView()
            
        }
    }
}
