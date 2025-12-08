//
//  GoalCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-03.
//

import SwiftUI
import SwiftData

struct GoalCardView: View {
    
    @Query private var allWeeks: [Week]
    
    // хранит список всех целей
    var goalStorage: Goal
    @State private var marked: Int = 0
    
    // проверяем либо эта неделя имеет дату пн и вс либо nil
    var thisWeek: Week? {
        // кладем нашу цель
        currentWeek(goal: goalStorage)
    }
    
    // посчитай процент для progress bar
    var progressForThisWeek: Double {
        // guard let — безопасно "распаковываем" опционал
        // let week = thisWeek — если thisWeek не nil, то присваиваем значение константе week и продолжаем выполнять код ниже.
        //else { return 0 } — если thisWeek nil, то выполняем тело else и выходим из функции сразу, в данном случае возвращаем 0.
        guard let week = thisWeek else { return 0 }
        // week - это именно эта неделя, markedDaysCount - сколько отмечено дней
        return Double(week.markedDaysCount) / Double(goalStorage.timePerWeek)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)


            VStack(spacing: 10) {
                HStack {
                    Text(goalStorage.goal)
                        .font(.nameOfGoal)
                    Spacer()
                    
                    Text("\(goalStorage.timePerWeek)/week")
                        .font(.textInCard)
                    
                }.foregroundStyle(Color.black)
                
                HStack {
                    Text("This week")
                        .font(.textInCard)
                        .foregroundStyle(Color.black)
                    Spacer()
                    
                    ProgressBarView(myProgress: progressForThisWeek, width: 80.0)
                    
                }
            }.padding(.horizontal, 20)
                .padding(.vertical, 18)
            
        }
        
    }

    
    // Эта функция ищет ОДНУ текущую неделю для конкретной цели.
    // -> Week? значит может такая неделя есть, а может и нет
    func currentWeek(goal: Goal) -> Week? {
        // создаем помощника по датам
        let calendar = Calendar.current
        // сегодняшняя дата
        let today = Date()

        // allWeeks.first - возьми первую неделю что подходит под условие в скобках
        return allWeeks.first { week in
            // Метод startOfDay(for:) делает время = 00:00, чтобы учитывать только день, игнорируя часы/минуты
            // Было 12:20 стало 00:00
            let start = calendar.startOfDay(for: week.startDate)
            // Метод date(bySettingHour:minute:second:of:) устанавливает время = 23:59:59, чтобы воскресенье считалось полностью.
            // конец недели = конец дня (23:59:59) воскресенья
            let end = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: week.endDate)!

            // мы типа проверяем все недели чтобы они подошли под это условие из 3 компонентов
            // 1. цель должна быть той, что goal
            // 2. сегодня не раньше начала недели
            // 3. сегодня не позже конца недели
            return week.goal?.id == goal.id &&
            // Проверяем: сегодняшняя дата не раньше начала недели
                   today >= start &&
            // Проверяем: сегодняшняя дата не позже конца недели
                   today <= end
        }
    }
}

