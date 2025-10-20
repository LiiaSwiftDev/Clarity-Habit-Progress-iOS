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
    
    @Relationship(deleteRule: .cascade, inverse: \Activity.goal) var activities: [Activity] = []
    @Relationship(deleteRule: .cascade, inverse: \Week.goal) var weeks: [Week] = []
    
    init() {
        id = UUID().uuidString
    }
    
}
