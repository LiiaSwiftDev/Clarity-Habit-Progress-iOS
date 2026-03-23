//
//  AppDelegate.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-22.
//

import Firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // override point for customization after application launch
        FirebaseApp.configure()
        return true
    }
}
