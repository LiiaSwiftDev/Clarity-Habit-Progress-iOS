//
//  WeekCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-10.
//

import SwiftUI

struct WeekCardView: View {
    
    // @Bindable = автоматическая связь между экраном и SwiftData. только так можно приаязать к $progress.markedDaysCount
    @Bindable var progress: Goal
    
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
                            DayCardView(days: "Mon", numberOfDays: "6", isMarked: $progress.markedDaysCount, totaldays: progress.timePerWeek)
                            DayCardView(days: "Tue", numberOfDays: "7", isMarked: $progress.markedDaysCount, totaldays: progress.timePerWeek)
                            DayCardView(days: "Wed", numberOfDays: "8", isMarked: $progress.markedDaysCount, totaldays: progress.timePerWeek)
                            DayCardView(days: "Thu", numberOfDays: "9", isMarked: $progress.markedDaysCount, totaldays: progress.timePerWeek)
                            DayCardView(days: "Fri", numberOfDays: "10", isMarked: $progress.markedDaysCount, totaldays: progress.timePerWeek)
                            DayCardView(days: "Sat", numberOfDays: "11", isMarked: $progress.markedDaysCount, totaldays: progress.timePerWeek)
                            DayCardView(days: "Sun", numberOfDays: "12", isMarked: $progress.markedDaysCount, totaldays: progress.timePerWeek)
                            
                            
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
