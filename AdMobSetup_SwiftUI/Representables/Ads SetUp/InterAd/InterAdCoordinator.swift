//
//  InterAdCoordinator.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import Foundation
import GoogleMobileAds

final class InterAdCoordinator: NSObject {
    // MARK: - Properties
    private var ad: GADInterstitialAd?
    private var handler: (() -> Void)?
    
    // MARK: - Life Cycle
    
    // MARK: - Functions
    func load() {
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/8691691433", request: GADRequest()) { ad, error in
            if let error = error {
                return print(error.localizedDescription)
            }
            
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
        }
    }
    
    func presentAd(onDismiss: @escaping () -> Void) {
        self.handler = onDismiss
        if interAdCounter % 3 == 0 {
            guard let fullScreenAd = ad else {
                return print("Ad wasn't ready")
            }
            fullScreenAd.present(fromRootViewController: nil)
        } else {
            handler?()
        }
        interAdCounter += 1
    }
}

// MARK: - GADFullScreenContentDelegate
extension InterAdCoordinator: GADFullScreenContentDelegate {
    func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    func adDidDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        handler?()
    }
}
