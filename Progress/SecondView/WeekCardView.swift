//
//  WeekCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-10.
//

import SwiftUI
import SwiftData

struct WeekCardView: View {
    
    // @Bindable = автоматическая связь между экраном и SwiftData. только так можно приаязать к $progress.markedDaysCount
    @Bindable var progress: Goal
    
    let week = 1
    // Это массив названий дней недели, чтобы знать, что показывать на экране. days[0] = "Mon", days[1] = "Tue" и т.д.
    let days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    @Query private var activities: [Activity]  // автоматически подгружаем из SwiftData
    
    var body: some View {
        VStack {
            HStack {
                Text("October 6 - October 12, 2025")
                    .font(.system(size: 12))
                Spacer()
                // отмеченные дни делим на сколько всего отмечено дней в неделю 3/week получаем 2/3 or 1/3 and so on and so forth
                ProgressBarView(myProgress: Double(progress.markedDaysCount) / Double(progress.timePerWeek))
            }.padding(.horizontal, 10)
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .opacity(0.6)
                    .shadow(color: .black,radius: 5, x: 0, y: 4)
                // Thu, Fri, Sat, Sun
                ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            // 0..<7 = числа от 0 до 6 → 7 дней недели.
                            // index — это номер дня в массиве days (0 = понедельник, 1 = вторник…).
                            ForEach(0..<7, id: \.self) { index in
                                // activityList: activities → передаём все активности из базы через @Query
                                // days[index] - название дня ("Mon", "Tue"…).
                                DayCardView(
                                    activityList: activities,
                                    week: week,
                                    day: days[index],
                                    dayIndex: index
                                )
                            }
                            
                        } .padding(.horizontal)
                    }
                
            }.frame(height: 110)
            
           // Spacer()
            
        } .padding()
    }
    
}

#Preview {
    WeekCardView(progress: Goal())
}
