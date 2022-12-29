//
//  adsOverlay.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 01/08/2022.
//

//import Foundation
import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

struct MyView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        Text("Ciao")
            .padding(safeAreaInsets)
    }
}
