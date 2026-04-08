//
//  Bundle.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-22.
//

import Foundation

// Extension to access app info from Info.plist
extension Bundle {
    
    // App display name
    var displayName: String {
        object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Could not determine the application name"
    }
    
    // App build number
    var appBuild: String {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Could not determine the application build number"
    }
    
    // App version (e.g. 1.0.0)
    var appVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Could not determine the application version"
    }
}
