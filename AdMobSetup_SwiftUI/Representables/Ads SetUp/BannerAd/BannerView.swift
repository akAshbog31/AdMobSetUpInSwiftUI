//
//  BannerView.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import SwiftUI
import GoogleMobileAds

struct BannerView: UIViewControllerRepresentable {
    // MARK: - Properties
    @State private var viewWidth: CGFloat = .zero
    private var bannerAdView = GADBannerView()
    private var adUnitID: String = "ca-app-pub-3940256099942544/2435281174"
    
    // MARK: - Functions
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> BannerViewController {
        let bannerViewController = BannerViewController()
        bannerAdView.adUnitID = adUnitID
        bannerAdView.rootViewController = bannerViewController
        bannerViewController.delegate = context.coordinator
        bannerViewController.view.addSubview(bannerAdView)
        
        return bannerViewController
    }
    
    func updateUIViewController(_ uiViewController: BannerViewController, context: Context) {
        guard viewWidth != .zero else { return }
        bannerAdView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerAdView.load(GADRequest())
    }
    
    // MARK: - Coordinator
    internal class Coordinator: NSObject, BannerAdViewDelegate, GADBannerViewDelegate {
        // MARK: - Properties
        let parent: BannerView
        
        // MARK: - Life Cycle
        init(parent: BannerView) {
            self.parent = parent
        }
        
        // MARK: - Functions
        func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
            parent.viewWidth = width
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: any Error) {
            print(error.localizedDescription)
        }
    }
}
