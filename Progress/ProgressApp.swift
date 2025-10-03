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
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: Goal.self)
        }
    }
}
