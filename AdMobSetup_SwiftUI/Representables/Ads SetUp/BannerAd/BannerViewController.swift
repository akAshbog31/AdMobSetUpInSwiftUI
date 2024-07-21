//
//  BannerViewController.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import UIKit

protocol BannerAdViewDelegate: AnyObject {
    func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat)
}

final class BannerViewController: UIViewController { 
    // MARK: - @IBOutlets
    
    // MARK: - Properties
    weak var delegate: BannerAdViewDelegate?
    
    // MARK: - Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delegate?.bannerViewController(self, didUpdate: view.frame.inset(by: view.safeAreaInsets).size.width)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in } completion: { _ in
            self.delegate?.bannerViewController(self, didUpdate: self.view.frame.inset(by: self.view.safeAreaInsets).size.width)
        }
    }
    
    // MARK: - @IBActions
    
    // MARK: - Functions
}

