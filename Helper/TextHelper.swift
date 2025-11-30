//
//  TextHelper.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-29.
//

import Foundation

struct TextHelper {
    
    static func limitChars(input: String, limit: Int) -> String {
        if input.count > limit {
            // prefix(_maxLength_)
            return String(input.prefix(limit))
        }
            return input

    }
    
}
