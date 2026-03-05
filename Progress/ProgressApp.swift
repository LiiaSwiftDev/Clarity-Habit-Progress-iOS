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
    
    init() {
            let config = TelemetryDeck.Config(appID: "15E29687-5792-4F26-BD26-BB0B285173CA")
            TelemetryDeck.initialize(config: config)
        
        TelemetryDeck.signal("App Opened")
        }
    
    // @AppStorage - сохраняет состояние
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [Goal.self, Activity.self])
            // Binding.constant(true) - значит всегда показывай onboarding view
                .fullScreenCover(isPresented: $needsOnboarding) {
                    // on dismiss
                    needsOnboarding = false
                } content: {
                    // что покажем
                    OnboardingView()
                }
                .onAppear {
                    // info about device
                    print(UIDevice.current.systemVersion)
                    // говорит какая модель телефона, например iPhone 14 plus
                    let device = Device.current
                    print(device.description)
                    // название приложения
                    print(Bundle.main.displayName)
                    // Buld number
                    print(Bundle.main.appBuild)
                    // App Version
                    print(Bundle.main.appVersion)
                }

        }
    }
}
