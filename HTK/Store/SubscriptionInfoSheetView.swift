
import SwiftUI
import StoreKit
import Foundation
//import StoreHelper

struct SubscriptionInfoSheet: View {
    @State private var showManageSubscriptionsSheet = false
    
    var body: some View {
        VStack {
        
            Button(action: {
                withAnimation { showManageSubscriptionsSheet.toggle()}
            }) { Label("Manage Subscriptions", systemImage: "creditcard.circle")}.buttonStyle(.borderedProminent)
            
        }.manageSubscriptionsSheet(isPresented: self.$showManageSubscriptionsSheet)
    }
}

/*
func getReceipt () {
    if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
        FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

        do {
            let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)

            let receiptString = receiptData.base64EncodedString(options: [])

            // Read receiptData.
            print ("String: ", receiptString)
            print ("Data: ", receiptData.description)
            
        }
        catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
    
    }
    
}
*/
