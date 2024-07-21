//
//  NativeAdView.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import SwiftUI
import GoogleMobileAds

struct NativeAdView: UIViewRepresentable {
    typealias UIViewType = GADNativeAdView
    
    // MARK: - Properties
    @ObservedObject var nativeAdViewModel: NativeAdViewModel
    
    // MARK: - Functions
    func makeUIView(context: Context) -> GADNativeAdView {
        return Bundle.main.loadNibNamed("NativAdView", owner: nil, options: nil)?.first as! GADNativeAdView
    }
    
    func updateUIView(_ uiView: GADNativeAdView, context: Context) {
        guard let nativeAd = nativeAdViewModel.nativeAd else { return }
        
        setAdView(nativeAd, uiView: uiView)
    }
    
    private func setAdView(_ nativeAd: GADNativeAd, uiView: GADNativeAdView) {
        uiView.mediaView?.mediaContent = nativeAd.mediaContent
        
        (uiView.headlineView as? UILabel)?.text = nativeAd.headline
        
        (uiView.bodyView as? UILabel)?.text = nativeAd.body
        uiView.bodyView?.isHidden = nativeAd.body == nil
        
        if let callToActionView = uiView.callToActionView as? UIButton {
            callToActionView.setTitle(nativeAd.callToAction?.capitalized, for: .normal)
            callToActionView.isHidden = nativeAd.callToAction == nil
        }
        
        (uiView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        uiView.iconView?.isHidden = nativeAd.icon == nil
        
        (uiView.starRatingView as? UIImageView)?.image = imageOfStars(from: nativeAd.starRating)
        
        uiView.callToActionView?.isUserInteractionEnabled = false
        
        uiView.nativeAd = nativeAd
    }
    
    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage {
        guard let rating = starRating?.doubleValue else {
            return UIImage(resource: .stars35)
        }
        if rating >= 5 {
            return UIImage(resource: .stars5)
        } else if rating >= 4.5 {
            return UIImage(resource: .stars45)
        } else if rating >= 4 {
            return UIImage(resource: .stars4)
        } else if rating >= 3.5 {
            return UIImage(resource: .stars35)
        } else {
            return UIImage(resource: .stars35)
        }
    }
}
