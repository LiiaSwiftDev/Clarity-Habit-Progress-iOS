//
//  TextHelper.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-29.
//

import Foundation
import UIKit

struct TextHelper {
    
    // Limit text by number of characters
    static func limitChars(input: String, limit: Int) -> String {
        if input.count > limit {
            return String(input.prefix(limit))
        }
        return input
    }
    
    // Limit text width (e.g., so it fits in UI)
    static func limitByWidth(_ input: String, font: UIFont, maxWidth: CGFloat) -> String {
        var newText = input
        while (newText as NSString).size(withAttributes: [.font: font]).width > maxWidth, !newText.isEmpty {
            newText.removeLast()
        }
        return newText
    }
}
