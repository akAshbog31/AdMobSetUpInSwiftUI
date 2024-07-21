//
//  AppOpenAdCoordinator.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import Foundation
import GoogleMobileAds

final class AppOpenAdCoordinator: NSObject {
    // MARK: - Properties
    private var ad: GADAppOpenAd?
    private var handler: (() -> Void)?
    
    // MARK: - Life Cycle
    
    // MARK: - Functions
    func load() {
        GADAppOpenAd.load(withAdUnitID: "ca-app-pub-3940256099942544/9257395921", request: GADRequest()) { ad, error in
            if let error = error {
                return print(error.localizedDescription)
            }
            
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
        }
    }
    
    func presentAd(onDismiss: @escaping () -> Void) {
        self.handler = onDismiss
        guard let fullScreenAd = ad else {
            return print("Ad wasn't ready")
        }
        fullScreenAd.present(fromRootViewController: nil)
    }
}

// MARK: - GADFullScreenContentDelegate
extension AppOpenAdCoordinator: GADFullScreenContentDelegate {
    func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    func adDidDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        handler?()
    }
}
