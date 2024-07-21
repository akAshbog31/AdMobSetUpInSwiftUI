//
//  AppDelegate.swift
//  AdMobSetup_SwiftUI
//
//  Created by Kunj Barvalia on 20/07/24.
//

import UIKit
import GoogleMobileAds

final class AppDelegate: NSObject, UIApplicationDelegate {
    // MARK: - Properties
    private var appOpenAd: GADAppOpenAd?
    
    // MARK: - Life Cycles
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
    
    // MARK: - Functions
    private func loadAd() {
        GADAppOpenAd.load(withAdUnitID: "ca-app-pub-3940256099942544/9257395921", request: GADRequest()) { ad, error in
            if let error = error {
                return print(error.localizedDescription)
            }
            
            self.appOpenAd = ad
            self.appOpenAd?.fullScreenContentDelegate = self
        }
    }
    
    func tryToPresentAd() {
        if let fullScreenAd = appOpenAd {
            fullScreenAd.present(fromRootViewController: nil)
        } else {
            loadAd()
        }
    }
}

extension AppDelegate: GADFullScreenContentDelegate { }
