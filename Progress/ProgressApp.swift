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

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // FCM токен = это адрес, куда слать письмо, “Окей, вот уникальный адрес для этого устройства”, “Firebase, когда узнаешь адрес — скажи его мне”
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    // ✅ Ловим обновления FCM токена
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM token: \(fcmToken ?? "")")
    }
    
    // ✅ Привязываем APNs токен к FCM
        func application(_ application: UIApplication,
                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
            print("APNs token mapped to FCM")
        }
    
    
}

@main
struct ProgressApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var model = HabitModel()
    
    init() {
        let TELEMETRY_APP_ID = Bundle.main.infoDictionary?["TELEMETRY_APP_ID"] as? String ?? "No appID found"
        let config = TelemetryDeck.Config(appID: TELEMETRY_APP_ID)
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
                .onChange(of: needsOnboarding) { newValue in
                    if newValue == false {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            requestNotificationPermission()
                        }
                    }
                }
        }
    }
    
    // Запрошены права у пользователя на уведомления
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                    Messaging.messaging().isAutoInitEnabled = true
                }
            }
        }
    }
}
