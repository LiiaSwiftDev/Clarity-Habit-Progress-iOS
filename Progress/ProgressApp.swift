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
import FirebaseCore
import FirebaseMessaging

// AppDelegate handles Firebase setup and push notifications
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Initialize Firebase
        FirebaseApp.configure()
        
        // Set the delegate to receive FCM token
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    // New FCM token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM token: \(fcmToken ?? "")")
    }
    
    // Connect device token to Firebase
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("APNs token mapped to FCM")
    }
    
}

@main
struct ProgressApp: App {
    // Register AppDelegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var model = HabitModel()
    
    init() {
        let TELEMETRY_APP_ID = Bundle.main.infoDictionary?["TELEMETRY_APP_ID"] as? String ?? "No appID found"
        let config = TelemetryDeck.Config(appID: TELEMETRY_APP_ID)
        TelemetryDeck.initialize(config: config)
        
        TelemetryDeck.signal("App Opened")
    }
    
    // Onboarding flag stored in AppStorage
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
                .onChange(of: needsOnboarding) {
                    if needsOnboarding == false {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            requestNotificationPermission()
                        }
                    }
                }
        }
    }
    
    // Request user permission for push notifications
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                if granted {
                    // Register device for remote notifications
                    UIApplication.shared.registerForRemoteNotifications()
                    // Enable Firebase push notifications
                    Messaging.messaging().isAutoInitEnabled = true
                }
            }
        }
    }
}
