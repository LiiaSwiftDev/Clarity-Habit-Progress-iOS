//
//  DayCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-07.
//

import SwiftUI
import SwiftData

struct DayCardView: View {
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // SwiftData context (save/update/delete)
    @Environment(\.modelContext) private var context
    
    // All activities from the database (for all days in the week)
    var activityList: [Activity]
    
    // Day name ("Mon", "Tue", etc.) for display
    var day: String
    
    // Day index 0…6 to identify the day of the week
    var dayIndex: Int
    
    // Which week this day belongs to
    var week: Week
    
    // Goal this day belongs to
    var goal: Goal
    
    // Check if this day is marked (completed)
    var isMarked: Bool {
        activityList.contains { activity in
            activity.dayOfWeek.rawValue == dayIndex &&
            activity.week == week &&
            activity.goal == goal
        }
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            // Button to toggle completion
            Button {
                // If a checkmark already exists for this day & week, remove it
                if let activity = activityList.first(where: { $0.week == week && $0.dayOfWeek.rawValue == dayIndex && $0.goal == goal }) {
                    context.delete(activity)
                    week.markedDaysCount -= 1
                } else {
                    // If there’s no checkmark yet, add one
                    let activity = Activity(week: week,
                                            dayOfWeek: Activity.DayOfWeek(rawValue: dayIndex)!,
                                            goal: goal)
                    context.insert(activity)
                    week.markedDaysCount += 1
                }
                try? context.save()
            } label: {
                // Checkmark image
                Image(systemName: isMarked ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isMarked ? Color("CheckBoxInside") : Color("EmptyCheckBox"))
                    .font(.system(size: 40))
                    .padding(.bottom, 4)
            }
            
            // Day label under the button
            Text(day)
                .font(.daysOfWeek)
                .foregroundStyle(Color.black)
        }
    }
}


