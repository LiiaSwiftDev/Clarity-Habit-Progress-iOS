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
    
    let week: Week
    // Это массив названий дней недели, чтобы знать, что показывать на экране. days[0] = "Mon", days[1] = "Tue" и т.д.
    let days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"] // mon - 0, tue - 1...
    
    @Query private var activities: [Activity]  // автоматически подгружаем из SwiftData
    
    var body: some View {
        
        VStack {
                        ZStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.white)
                            //
                    .frame(maxWidth: .infinity)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(formattedDateRange(from: week.startDate, to: week.endDate))")
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
                                                    day: days[index],
                                                    dayIndex: index,
                                                    week: week,
                                                    goal: progress
                                                )
                                                
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    
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
     
        }//.padding(.horizontal)
        
            
    }
    
    func convertDatetoString(date: Date) -> String {
        
        let formater = DateFormatter()
        formater.dateFormat = "d"
        
        let numberOfDay = formater.string(from: date)
        
        return "\(numberOfDay)"
        
    }
    
    // Функция делает текст дату красивой до 2025-09-28 и 2025-10-04, после September 28 - October 4, 2025
    // Внешнее имя    from, to    видно при вызове функции
    // Внутреннее имя    start, end    видно внутри функции
    func formattedDateRange(from start: Date, to end: Date) -> String {
        // Мы создаём помощника по имени formatter. Этот помощник умеет превращать дату в текст. (Например, из числа делает слово “September 28”.)
        let formatter = DateFormatter()
        // Мы говорим помощнику, на каком языке он должен писать. "en_US" — значит “американский английский”. поэтому месяц будет написан September, а не сентябрь.
        formatter.locale = Locale(identifier: "en_US")
        // Мы говорим, в каком виде писать дату. "MMMM d" — это шаблон: MMMM = название месяца (например, September); d = день числа (например, 4). Вместе получится September 4.
        formatter.dateFormat = "MMMM d"
        
        //  Мы берём первую дату (start) И просим помощника превратить её в текст. Теперь startStr = например "September 28".
        let startStr = formatter.string(from: start)
        // То же самое, но для второй даты (end). Теперь endStr = например "October 4".
        let endStr = formatter.string(from: end)
        
        // Мы снова говорим помощнику: “Теперь напиши только год.” в таком так виде
        formatter.dateFormat = "yyyy"
        // Мы просим написать год из даты end (из конца недели). Теперь yearStr = "2025".
        let yearStr = formatter.string(from: end)
        
        // получаем "September 28 - October 4, 2025"
        return "\(startStr) - \(endStr), \(yearStr)"
    }


}


