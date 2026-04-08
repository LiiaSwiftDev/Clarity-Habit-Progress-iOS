//
//  SupportEmail.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-24.
//

import UIKit
import SwiftUI
import DeviceKit

struct SupportEmail {
    let toAddress: String
    let subject: String
    let messageHeader: String
    var data: Data?
    var body: String {"""
        Application Name: \(Bundle.main.displayName)
        iOS: \(UIDevice.current.systemVersion)
        Device Model: \(Device.current.description)
        Appp Version: \(Bundle.main.appVersion)
        App Build: \(Bundle.main.appBuild)
        \(messageHeader)
    --------------------------------------
    """
    }
    
    // Open email client with prefilled data
    func send(urlOpener: OpenURLAction) {
        
        // 1. Create mailto URL
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        // 2. Check if URL not nil
        guard let url = URL(string: urlString) else { return }
        
        // Open email app
        urlOpener(url) { accepted in
            if !accepted {
                print("""
                This device does not support email
                \(body)
                """
                )
            }
        }
    }
}
