//
//  TextHelper.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-29.
//

import Foundation
import UIKit

struct TextHelper {
    
    static func limitChars(input: String, limit: Int) -> String {
        if input.count > limit {
            // prefix(_maxLength_)
            return String(input.prefix(limit))
        }
            return input

    }
    
    static func limitByWidth(_ input: String, font: UIFont, maxWidth: CGFloat) -> String {
        var newText = input
        while (newText as NSString).size(withAttributes: [.font: font]).width > maxWidth, !newText.isEmpty {
            newText.removeLast()
        }
        return newText
    }

    
}
