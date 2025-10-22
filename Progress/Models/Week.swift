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
    var tuesday: Date
    var wednesday: Date
    var thursday: Date
    var friday: Date
    var saturday: Date
    // и конца
    var endDate: Date
    
    init(goal: Goal?, startDate: Date, tuesday: Date, wednesday: Date, thursday: Date, friday: Date, saturday: Date, endDate: Date) {
        self.goal = goal
        self.startDate = startDate
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.endDate = endDate
    }
    
}
