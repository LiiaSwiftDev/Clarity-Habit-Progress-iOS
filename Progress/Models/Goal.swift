//
//  Goal.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-03.
//

import Foundation
import SwiftData

@Model
class Goal: Identifiable {
    
    @Attribute(.unique) var id: String
    // надо или нет??
    var createDate = Date()
    var goal = ""
    var timePerWeek  = 0
    var markedDaysCount = 0
    
    @Relationship(deleteRule: .cascade, inverse: \Activity.goal) var activities: [Activity] = []
    
    init() {
        id = UUID().uuidString
    }
    
}
