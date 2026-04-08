//
//  GoalCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-03.
//

import SwiftUI
import SwiftData

struct GoalCardView: View {
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // Fetch all weeks from database
    @Query private var allWeeks: [Week]
    
    // Returns current week for this goal or nil
    var thisWeek: Week? {
        currentWeek(goal: goalStorage)
    }
    
    // Goal data
    var goalStorage: Goal
    
    // Progress bar for current week (0...1)
    var progressForThisWeek: Double {
        guard let week = thisWeek else { return 0 }
        
        // completed days / required days
        return Double(week.markedDaysCount) / Double(goalStorage.timePerWeek)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
            
            VStack(spacing: 10) {
                // Goal title + target per week
                HStack {
                    Text(goalStorage.goal)
                        .font(.nameOfGoal)
                    Spacer()
                    
                    Text("\(goalStorage.timePerWeek)/week")
                        .font(.textInCard)
                    
                }.foregroundStyle(Color.black)
                
                // Weekly progress
                HStack {
                    Text("This week")
                        .font(.textInCard)
                        .foregroundStyle(Color.black)
                    Spacer()
                    
                    ProgressBarView(myProgress: progressForThisWeek, width: 80.0)
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
        }
    }
    
    // Find current week for a specific goal
    func currentWeek(goal: Goal) -> Week? {
        let calendar = Calendar.current
        let today = Date()
        
        // Return the first week that matches conditions
        return allWeeks.first { week in
            
            // Set time to 00:00 (ignore hours/minutes)
            let start = calendar.startOfDay(for: week.startDate)
            
            // End of day (23:59:59)
            let end = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: week.endDate)!
            
            // Check:
            // 1. Same goal
            // 2. Today is after or equal to start date
            // 3. Today is before or equal to end date
            return week.goal?.id == goal.id &&
            today >= start &&
            today <= end
        }
    }
}

