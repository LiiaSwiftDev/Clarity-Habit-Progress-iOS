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
    
    
    // это день недели, когда ты отметила галочку.
    var dayOfWeek: DayOfWeek
    
    // относится к какой-то недели
    var week: Week?
    // // относится к какой-то цели
    var goal: Goal?
    
    enum DayOfWeek: Int, Codable {
        case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    init(week: Week, dayOfWeek: DayOfWeek, goal: Goal?) {
        self.week = week
        self.dayOfWeek = dayOfWeek
        self.goal = goal
    }
    
}
