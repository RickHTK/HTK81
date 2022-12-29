//
//  ContentView.swift
//  TestStore
//
//  Created by Richard Hardy on 29/08/2022.
//

import SwiftUI
/*
struct ContentView2: View {
    @StateObject var store: Store = Store()
    var body: some View {
        
        
        //Text("Hello, world!")
        
        if store.advertisementCheck(for: "") == .AdsOn {
            Text ("Ads On")
            
        }
        else {
            Text ("Ads Off")
        }
            
            //.padding()
        MyProductsView (store: store)
        
    }//.environmentObject(store)
    
}*/

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing all the user's purchased cars and subscriptions.
*/

import SwiftUI
import StoreKit




struct MyProductsView: View {
    
    var store : Store

    var body: some View {
        NavigationView {
            
            // If no cars
            if store.purchasedCars.isEmpty && store.purchasedNonRenewableSubscriptions.isEmpty && store.purchasedSubscriptions.isEmpty {
                VStack {
                    Text("Harmonica Toolkit")
                        .bold()
                        .font(.system(size: 50))
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.center)
                    Image("HTK1")
                        .resizable()
                        .frame(minWidth: 50, idealWidth: 100, maxWidth: 150, minHeight: 50, idealHeight: 100, maxHeight: 150)
                        .font(.system(size: 120))
                        .padding(.bottom, 20)
                    Text("Add premium features")
                        .font(.headline)
                        .padding()
                        .multilineTextAlignment(.center)
                    NavigationLink {
                        //ListCellView ()
                        StoreView()
                    } label: {
                        Label("Harmonica Toolkit", systemImage: "cart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                }
                
            // If there are cars
            } else {
                List {
                    Section("Your Products") {
                        if !store.purchasedCars.isEmpty {
                            ForEach(store.purchasedCars) { product in
                                NavigationLink {
                                    ProductDetailView(product: product)
                                } label: {
                                    ListCellView(product: product, purchasingEnabled: false)
                                }
                            }
                        } else {
                            Text("You don't own any car products. \nHead over to the shop to get started!")
                        }
                    }
                    
                    
                    Section("Your Subscriptions") {
                        if !store.purchasedNonRenewableSubscriptions.isEmpty || !store.purchasedSubscriptions.isEmpty {
                            ForEach(store.purchasedNonRenewableSubscriptions) { product in
                                NavigationLink {
                                    ProductDetailView(product: product)
                                } label: {
                                    //ListCellView(product: product, purchasingEnabled: false)
                                    ListCellView(product: product)
                                    
                                }
                            }
                            ForEach(store.purchasedSubscriptions) { product in
                                NavigationLink {
                                    
                                    ProductDetailView(product: product)
                                        
                                } label: {
                                    //ListCellView(product: product, purchasingEnabled: false)
                                    ListCellView(product: product)
                                }
                                }
                            }

                        } else {
                            if let subscriptionGroupStatus = store.subscriptionGroupStatus {
                                if subscriptionGroupStatus == .expired || subscriptionGroupStatus == .revoked {
                                    Text("Welcome Back! \nHead over to the shop to get started!")
                                } else if subscriptionGroupStatus == .inBillingRetryPeriod {
                                    //The best practice for subscriptions in the billing retry state is to provide a deep link
                                    //from your app to https://apps.apple.com/account/billing.
                                    Text("Please verify your billing details.")
                                }
                            } else {
                                Text("Monthly Subscription To Premium Features Available in the Shop")
                            }
                        }
                    }
                     
                    
                    NavigationLink {
                        StoreView()
                    } label: {
                        Label("Buy Features & Subscriptions", systemImage: "cart")
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.blue)
                }
                
                .navigationTitle("The Harmonica Toolkit")
            }
        }.environmentObject(store)

    }
    

}

