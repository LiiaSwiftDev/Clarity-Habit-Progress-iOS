//
//  ProgressApp.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-01.
//

import SwiftUI
import SwiftData
import TelemetryDeck
import DeviceKit

@main
struct ProgressApp: App {
    
    @State var model = HabitModel()
    
    init() {
        let config = TelemetryDeck.Config(appID: "15E29687-5792-4F26-BD26-BB0B285173CA")
        TelemetryDeck.initialize(config: config)
        
        TelemetryDeck.signal("App Opened")
    }
    
    // @AppStorage — stores the onboarding state
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(model)
                .modelContainer(for: [Goal.self, Activity.self])
                .fullScreenCover(isPresented: $needsOnboarding) {
                    // on dismiss
                    needsOnboarding = false
                } content: {
                    // display when the app loads for the first time
                    OnboardingView()
                }
                .onAppear {
                    // Info about device
                    print(UIDevice.current.systemVersion)
                    // Indicates the phone model, e.g., iPhone 14 Plus
                    let device = Device.current
                    print(device.description)
                    // App name
                    print(Bundle.main.displayName)
                    // Buld number
                    print(Bundle.main.appBuild)
                    // App Version
                    print(Bundle.main.appVersion)
                }
        }
    }
}
