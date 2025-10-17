//
//  Activity.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-16.
//

import Foundation
import SwiftData

@Model
class Activity: Identifiable {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    // Например, 1 = первая неделя, 2 = вторая и т.д.
    var week: Int
    // это день недели, когда ты отметила галочку. 
    var dayOfWeek: DayOfWeek
    
    var goal: Goal?
    
    enum DayOfWeek: Int, Codable {
        case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    init(week: Int, dayOfWeek: DayOfWeek, goal: Goal?) {
        self.week = week
        self.dayOfWeek = dayOfWeek
        self.goal = goal
    }
    
}
