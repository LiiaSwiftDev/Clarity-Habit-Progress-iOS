//
//  Options.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-03.
//

import Foundation

struct Options: Identifiable, Decodable {
    
    let id = UUID()
    var emoji: String
    var goalOption: String
    
}
