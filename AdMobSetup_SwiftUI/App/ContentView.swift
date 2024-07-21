//
//  ContentView.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var nativeAdViewModel = NativeAdViewModel()
    @State private var adCoordinator = InterAdCoordinator()
    
    // MARK: - Body
    var body: some View {
        VStack {
            BannerView()
                .frame(height: 50)
            
            VStack {
                Spacer()
                
                Button {
                    adCoordinator.presentAd {
                        print("Ad is closed")
                    }
                } label: {
                    Text("Show Ad")
                }
                
                Spacer()
                
                if nativeAdViewModel.isAdLoaded {
                    NativeAdView(nativeAdViewModel: nativeAdViewModel)
                        .background(Color.yellow.opacity(0.05))
                        .frame(height: 190)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            nativeAdViewModel.refreshAd()
            adCoordinator.load()
        }
        .animation(.easeInOut(duration: 0.5), value: nativeAdViewModel.isAdLoaded)
    }
    
    // MARK: - Functions
}

#Preview {
    ContentView()
}
