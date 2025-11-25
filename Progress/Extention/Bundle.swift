//
//  Bundle.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-22.
//

import Foundation
// extension — расширение. Оно позволяет добавлять новые свойства или функции к уже существующему типу. Bundle — это тип (класс) в Swift, который представляет весь пакет приложения, включая его файлы и настройки.
extension Bundle {
    var displayName: String {
        // object — функция, которая вытаскивает значение из файла Info.plist
        //forInfoDictionaryKey: это внешнее имя параметра, говорит: «ищи значение по такому ключу»
        //  "CFBundleName" это ключ в Info.plist, означает имя приложения
        // object(forInfoDictionaryKey: - это замок, CFBundleName - это ключь, Bundle Name (in info.plist) - это дверь
        object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Could not determine the application name"
    }
    var appBuild: String {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Could not determine the application build number"
    }
    var appVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Could not determine the application version"
    }
}
