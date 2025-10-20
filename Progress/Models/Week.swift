//
//  Week.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-18.
//

import Foundation
import SwiftData

@Model
// Identifiable означает, что у каждой недели будет уникальный идентификатор (id)
class Week: Identifiable {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    // Это номер недели — 1, 2, 3 и т.д.
    var number: Int
    var goal: Goal?
    var markedDaysCount = 0
    
    init(number: Int, goal: Goal?) {
        self.number = number
        self.goal = goal
    }
    
}
