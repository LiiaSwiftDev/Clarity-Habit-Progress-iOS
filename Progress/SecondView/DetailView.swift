//
//  DetailView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-04.
//

import SwiftUI

struct DetailView: View {
    
    // @Bindable = автоматическая связь между экраном и SwiftData. только так можно приаязать к $progress.markedDaysCount
    @Bindable var progress: Goal
    // новая переменная состояния, которая хранит, сколько дней уже отмечено пользователем.
    //@State private var markedDays: Int = 0
    
    var body: some View {
        
        ZStack {
            Color(red: 243/255, green: 203/255, blue: 228/255)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 10) {
                    HStack {
                        Text(progress.goal)
                            .font(.custom("SFProRounded-Medium", size: 30))
                        Spacer()
                        
                        Text("\(progress.timePerWeek)/week")
                            .font(.system(size: 14))
                        
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Progress of this week:")
                            .font(.system(size: 14))
                        Spacer()
                        
                        ProgressBarView(myProgress: Double(progress.markedDaysCount) / Double(progress.timePerWeek))
                        
                    }.padding(.horizontal, 30)
                    
                }.padding()
                
                // background (_content_)
                    .background {
                        Color.white
                            .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                            .ignoresSafeArea()
                    }
                Spacer()
                
            }
            
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
                
                Spacer()
                
            } .padding()
                .padding(.top, 120)
            
        }
    }
}

#Preview {
    DetailView(progress: Goal())
}
