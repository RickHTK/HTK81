//********* Archive this code Good but no longer used
//
//  setBannerAds.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 01/08/2022.
//

//import Foundation

import GoogleMobileAds
import UIKit
// import AudioKitUI

import SwiftUI


// These create the banner Ads

// This is required to convert to SwiftUI
extension UIApplication {
    func getRootViewController ()->UIViewController {
        guard let screen = self.connectedScenes.first as? UIWindowScene else {return .init()}
        guard let root = screen.windows.first?.rootViewController else {return .init()}
    return root
    }
}

// Create the Ad so that it can be presented by SwiftUI
struct BannerAD : UIViewRepresentable {
    
    var unitID : String
    
    func makeCoordinator () -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView (context: Context) -> GADBannerView {
        
        let adView = GADBannerView(adSize: GADAdSizeBanner)
        
        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.getRootViewController()
        
        adView.load (GADRequest())
        return adView
    }
    
    func updateUIView (_ uiView: GADBannerView, context: Context ) {
    
        class Coordinator: NSObject, GADBannerViewDelegate {
        }
    }
}



// These four structs compress the banner Ads into one corner of the screen
// This might be simpler with a 2x5 stack with empty cells

//Display a view on 20% of the screen vertically
struct RatioContainer<Content: View>: View {
    let heightRatio:CGFloat
    let content: Content

    init(heightRatio:CGFloat = 0.20,@ViewBuilder content: () -> Content) {
            self.heightRatio = heightRatio
            self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                content.frame(width: geo.size.width, height: geo.size.height*heightRatio, alignment: .bottomLeading)
            }
        }
    }
}

//Display a view on 50% of the screen Horizontally
struct RatioWidthContainer<Content: View>: View {
    let widthRatio:CGFloat
    let content: Content

    init(widthRatio:CGFloat = 0.50, @ViewBuilder content: () -> Content) {
            self.widthRatio = widthRatio
            self.content = content()
    }
    var body: some View {
        GeometryReader { geo in
            HStack {
                content.frame(width: geo.size.width*widthRatio, height: geo.size.width, alignment: .leading)
                Spacer()
            }
        }
    }
}

// Display the banner ad with horizontal compression
struct horizRatioView: View {
    var body: some View {
        RatioWidthContainer {
                HStack {
                    BannerAD(unitID: "ca-app-pub-3940256099942544/2934735716")
                }
        }
    }
}

// Create an instance of the ad in a horizontally compressed view
let horizontallyCompressedView = horizRatioView ()

// compress the horizontally compressed view instance vertically
struct adMobView: View {
    var body: some View {
        RatioContainer {
            HStack {
                horizontallyCompressedView
            }
        }
    }
}






// Not working combination of 2 structs above

struct adMobView2: View {
    var body: some View {
        twoDimRatioContainer {
            VStack {
            BannerAD(unitID: "ca-app-pub-3940256099942544/2934735716")
            }
        }
    }
}




struct twoDimRatioContainer<Content: View>: View {
    let heightRatio:CGFloat
    let widthRatio:CGFloat
    let content: Content

    init(heightRatio:CGFloat = 0.20, widthRatio:CGFloat = 0.50, @ViewBuilder content: () -> Content) {
            self.heightRatio = heightRatio
            self.widthRatio = widthRatio
            self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            HStack {
                
                // For this to work this Vstack needs to be content
                
                VStack{
                    Spacer()
                    content.frame(width: geo.size.width, height: geo.size.height*heightRatio, alignment: .bottomLeading)
                }
                
                
                .frame(width: geo.size.width*widthRatio, height: geo.size.height, alignment: .leading)
                
            }
        }
    }
}

