/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A detailed view of a product and any related products.
*/

import Foundation
import SwiftUI
import StoreKit

struct ProductDetailView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var store: Store

    @State var isPurchased: Bool = false
    
    @State private var isFuelStoreShowing = false
    
    @State private var carOffsetX: CGFloat = 0
    @State private var isCarHidden = false
    @State private var showSpeed = false
    @State private var showManageSubscriptionsSheet = false

    let product: Product
    
    var emoji: String {
        return store.productDescription(for: product.id)
    }
    
    var fullDescription: String {
        return store.productDescription(for: product.id)
    }
    
    
    
    var body: some View {
        ZStack {
            Group {
                
                VStack {
                    Image ("HTK-icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(9)

                    Text(product.description)
                        .padding()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text (fullDescription)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)

                    if store.subscriptionGroupStatus != nil {
                        
                        VStack {
                                Button(action: {
                                    withAnimation { showManageSubscriptionsSheet.toggle()}
                                }) { Label("Manage Subscriptions", systemImage: "creditcard.circle")}.buttonStyle(.borderedProminent)
                        }.manageSubscriptionsSheet(isPresented: self.$showManageSubscriptionsSheet)
                    }
                    else{
                        BuyButtonView(product: product)
                            .buttonStyle(BuyButtonStyle(isPurchased: isPurchased))
                            .disabled(isPurchased)
                    }
                }
            }
            .blur(radius: isFuelStoreShowing ? 10 : 0)
            .contentShape(Rectangle())
            .onAppear{print (store.subscriptionGroupStatus)}
                       

        }
        .navigationTitle(product.displayName)
    }
    
    

}


extension Date {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
}
