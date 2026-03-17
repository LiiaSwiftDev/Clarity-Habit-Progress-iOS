//
//  WeekCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-10.
//

import SwiftUI
import SwiftData

struct WeekCardView: View {
    
    @Environment(HabitModel.self) var model
    // @Bindable = автоматическая связь между экраном и SwiftData. только так можно приаязать к $progress.markedDaysCount
    @Bindable var progress: Goal
    
    let week: Week
    
    @Query private var activities: [Activity]  // автоматически подгружаем из SwiftData
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.white)
                .frame(maxWidth: 400)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
            // Это родитель у GeometryReader
            VStack(alignment: .leading, spacing: 0) {
                Text("\(model.formattedDateRange(from: week.startDate, to: week.endDate))")
                    .foregroundStyle(Color.black)
                    .font(.date)
                    .padding(.top, 21)
                    .padding(.bottom, 17)
                
                HStack(spacing: 0) {
                    // Thu, Fri, Sat, Sun
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            // 0..<7 = числа от 0 до 6 → 7 дней недели.
                            // index — это номер дня в массиве days (0 = понедельник, 1 = вторник…).
                            ForEach(0..<7, id: \.self) { index in
                                // activityList: activities → передаём все активности из базы через @Query
                                // days[index] - название дня ("Mon", "Tue"…).
                                DayCardView(
                                    activityList: activities,
                                    day: model.days[index],
                                    dayIndex: index,
                                    week: week,
                                    goal: progress
                                )
                                
                            }
                        }
                    } // «Я готов занять всю доступную ширину, если мне её дадут»
                    .frame(maxWidth: .infinity)
                    
                    Percent(myProgress: Double(week.markedDaysCount) / Double(progress.timePerWeek))
                        .padding(.bottom, 20)
                        .frame(width: 70, alignment: .trailing)
                }
                // GeometryReader считает ВСЮ доступную ширину и высоту, которую родитель ему разрешил. Родитель это VStack
                GeometryReader { geo in
                    // geo.size.width - вся доступная ширина
                    ProgressBarView(
                        myProgress: Double(week.markedDaysCount) / Double(progress.timePerWeek),
                        width: geo.size.width
                    )
                } // фиксированная высота
                .frame(height: 8)
                .padding(.top, 17)
                .padding(.bottom, 21)
                
            }
            .frame(maxWidth: 350)
            .padding(.horizontal, 16)
            
        }
    }
    
}


