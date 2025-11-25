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
    
    func send(urlOpener: OpenURLAction) {
        // 1. Формируем адрес
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        // 2. Проверяем, что URL не nil
        guard let url = URL(string: urlString) else { return }
        // 3. urlOpener(url) — это сам инструмент iOS, который открывает ссылку. { accepted in … } — это замыкание, которое говорит: удалось ли открыть ссылку
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
