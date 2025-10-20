//
//  DayCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-07.
//

import SwiftUI
import SwiftData

struct DayCardView: View {
    
    // через context мы можешь сохранять и удалять
    @Environment(\.modelContext) private var context
    
    //activityList — массив всех активностей из базы (для всех дней недели).
    var activityList: [Activity]
    
    // day — название дня ("Mon", "Tue" и т.д.), чтобы показывать текст на кнопке.
    var day: String
    // dayIndex — число 0…6, чтобы понимать, какой это день недели.
    var dayIndex: Int
    // week — какая неделя (1, 2, 3…).
    var week: Week
    var goal: Goal

    
    // Проверяем, есть ли галочка
    var isMarked: Bool {
        // activityList — это массив всех активностей (галочек) на неделю. .contains { ... } спрашивает: «Есть ли в массиве хотя бы одна активность, которая удовлетворяет условию?»
        // activity — это каждый объект Activity из массива. «Есть ли в корзине галочка для понедельника первой недели?» activity.week - 1 неделя, activity.dayOfWeek. rawValue - понедельник, rawValue — это число или значение, которое скрыто внутри enum.
        activityList.contains { activity in
            activity.dayOfWeek.rawValue == dayIndex &&
            activity.week == week &&
            activity.goal == goal
            
        }
        
    }
    var body: some View {
        
        ZStack {
          
            Rectangle()
                .frame(width: 70, height: 80)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 7))
            VStack(alignment: .center, spacing: 0) {
                Text(day)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.bottom, 6)
                
                Button {
                    // Мы смотрим в списке всех активностей (activityList), есть ли уже галочка для этого дня и недели. first(where:) значит: найти первый объект, который подходит под условие. если есть галочка для понедельника первой недели значит условие получает true и мы выполняем удаление
                    // другими словами если я нажимаю как галочку, програма проверяет да там есть значит убирает таким образом мы можем убрать галочку
                    if let activity = activityList.first(where: { $0.week == week && $0.dayOfWeek.rawValue == dayIndex && $0.goal == goal }) {
                        // удалить активность
                        context.delete(activity)
                        week.markedDaysCount -= 1
                    } else {
                        // Это значит: если галочки ещё нет, то мы её создаём.
                        // создать активность
                        //Activity.DayOfWeek - Это наш список дней недели: monday, tuesday, wednesday…
                        // rawValue — это число, которое соответствует дню. dayIndex = индекс дня в массиве (["Mon","Tue","Wed",…]).
                        let activity = Activity(week: week,
                                                dayOfWeek: Activity.DayOfWeek(rawValue: dayIndex)!,
                                                goal: goal)
                        // сохранить
                        context.insert(activity)
                        week.markedDaysCount += 1
                    }
                    // сохранить результат
                    try? context.save()
                } label: {
                    Image(systemName: isMarked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(.green)
                        .font(.title)
                }

            } .padding(.vertical, 5)
            
        }
    }
}


