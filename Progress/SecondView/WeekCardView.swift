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
    let days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    @Query private var activities: [Activity]  // автоматически подгружаем из SwiftData
    
    var body: some View {
        VStack {
            HStack {
                // вставляем нашу функуцию с датой 
                Text("\(formattedDateRange(from: week.startDate, to: week.endDate))")
                    .font(.system(size: 12))
                Spacer()
                // отмеченные дни делим на сколько всего отмечено дней в неделю 3/week получаем 2/3 or 1/3 and so on and so forth
                ProgressBarView(myProgress: Double(week.markedDaysCount) / Double(progress.timePerWeek))
                
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
                                    day: days[index],
                                    dayIndex: index,
                                    week: week,
                                    goal: progress
                                )
                            }
                            
                        } .padding(.horizontal)
                        
                    }
                
            }.frame(height: 110)
     
        } .padding(.horizontal)
          .padding(.vertical, 10)
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


