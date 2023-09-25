/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view for an individual car or subscription product that shows a Buy button when it displays within the store.
 */

import SwiftUI
import StoreKit

struct ListCellView: View {
    
    @EnvironmentObject var store: Store
    @State var isPurchased: Bool = false
    //@State var previouslyPurchased: Bool = false
    
    @State var errorTitle = ""
    @State var isShowingError: Bool = false
    
    let product: Product
    let purchasingEnabled: Bool
    
    init(product: Product, purchasingEnabled: Bool = true )  {
        self.product = product
        self.purchasingEnabled = purchasingEnabled
        
    }
    
    var body: some View {
        /*
         task {
         await checkPurchasedAlready()
         }
         */
        
        VStack {
            
            productDetail
            HStack {
                
                Image("HTK-icon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .padding(.trailing, 20)
                
                if purchasingEnabled {
                    
                    Spacer()
                    //Spacer()
                    BuyButtonView(product: product)
                        .buttonStyle(BuyButtonStyle(isPurchased: isPurchased))
                        .disabled(isPurchased)
                    Text ("Subscribe")
                    
                } else {
                    HStack
                    {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.blue)
                        
                        Text ("Subscribed")
                    }
                }
            }
        }
        .alert(isPresented: $isShowingError, content: {
            Alert(title: Text(errorTitle), message: nil, dismissButton: .default(Text("Okay")))
        })
    }
    
    @ViewBuilder
    var productDetail: some View {
        if product.type == .autoRenewable {
            VStack(alignment: .leading) {
                Text(product.displayName)
                    .bold()
                Text(product.description)
            }
        } else {
            Text(product.description)
                .frame(alignment: .leading)
        }
    }
    
}

