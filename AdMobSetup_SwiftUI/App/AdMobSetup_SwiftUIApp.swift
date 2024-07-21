//
//  AdMobSetup_SwiftUIApp.swift
//  AdMobSetup_SwiftUI
//
//  Created by KPEWORLD on 19/07/24.
//

import SwiftUI

@main
struct AdMobSetup_SwiftUIApp: App {
    // MARK: - Properties
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                appDelegate.tryToPresentAd()
            }
        }
    }
    
    // MARK: - Functions
}
