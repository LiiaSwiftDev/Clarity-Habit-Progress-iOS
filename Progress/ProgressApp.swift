//
//  ProgressApp.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-01.
//

import SwiftUI
import SwiftData

@main
struct ProgressApp: App {
    // @AppStorage - сохраняет состояние
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: Goal.self)
            // Binding.constant(true) - значит всегда показывай onboarding view
                .fullScreenCover(isPresented: $needsOnboarding) {
                    // on dismiss
                    needsOnboarding = false
                } content: {
                    // что покажем
                    OnboardingView()
                }

        }
    }
}
