//
//  WeekCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-10.
//

import SwiftUI
import SwiftData

struct WeekCardView: View {
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // Bind to goal progress so UI updates automatically
    @Bindable var progress: Goal
    
    // Current week for this card
    let week: Week
    
    // Load all activities from database
    @Query private var activities: [Activity]
    
    var body: some View {
        
        ZStack {
            
            // Card background
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .frame(maxWidth: 400)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
            
            VStack(alignment: .leading, spacing: 0) {
                // Show week date range
                Text("\(model.formattedDateRange(from: week.startDate, to: week.endDate))")
                    .foregroundStyle(Color.black)
                    .font(.date)
                    .padding(.top, 21)
                    .padding(.bottom, 17)
                
                HStack(spacing: 0) {
                    // 7 day cards (Mon - Sun)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<7, id: \.self) { index in
                                DayCardView(
                                    activityList: activities,
                                    day: model.days[index],
                                    dayIndex: index,
                                    week: week,
                                    goal: progress
                                )
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Week completion percent
                    Percent(myProgress: Double(week.markedDaysCount) / Double(progress.timePerWeek))
                        .padding(.bottom, 20)
                        .frame(width: 70, alignment: .trailing)
                }
                
                GeometryReader { geo in
                    ProgressBarView(
                        myProgress: Double(week.markedDaysCount) / Double(progress.timePerWeek),
                        width: geo.size.width
                    )
                }
                .frame(height: 8)
                .padding(.top, 17)
                .padding(.bottom, 21)
                
            }
            .frame(maxWidth: 350)
            .padding(.horizontal, 16)
            
        }
    }
    
}


