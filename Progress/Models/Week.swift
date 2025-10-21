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
    
    var goal: Goal?
    var markedDaysCount = 0
    
    // сохраняем день начала недели
    var startDate: Date
    // и конца
    var endDate: Date
    
    init(goal: Goal?, startDate: Date, endDate: Date) {
        self.goal = goal
        self.startDate = startDate
        self.endDate = endDate
    }
    
}
