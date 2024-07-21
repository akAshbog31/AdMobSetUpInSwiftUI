//
//  NativeAdViewModel.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import SwiftUI
import GoogleMobileAds

final class NativeAdViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    @Published var nativeAd: GADNativeAd?
    @Published var isAdLoaded: Bool = false
    private var adLoader: GADAdLoader!
    
    // MARK: - Life Cycle
    
    // MARK: - Functions
    func refreshAd() {
        adLoader = GADAdLoader(
            adUnitID: "ca-app-pub-3940256099942544/2247696110",
            rootViewController: nil,
            adTypes: [.native],
            options: nil
        )
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
}

// MARK: - GADNativeAdLoaderDelegate
extension NativeAdViewModel: GADNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        self.nativeAd = nativeAd
        nativeAd.delegate = self
        isAdLoaded = nativeAdCounter % 3 == 0
        nativeAdCounter += 1
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: any Error) {
        print(error.localizedDescription)
        isAdLoaded = false
    }
}

// MARK: - GADNativeAdDelegate
extension NativeAdViewModel: GADNativeAdDelegate {}

