//
//  AddWeekView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-20.
//

import SwiftUI
import SwiftData
import TelemetryDeck

struct AddWeekView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

    // цель будет передаваться сверху неделя должна прикрепляться к цели
    var goal: Goal

    // в эту переменную мы положим выбраннйю дату. Date() – сегодняшнее число
    @State private var selectedDate = Date()
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 0) {
            // подпись для пользователя
            Text("Select a day from the week you’d like to track.")
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding(.top, 10)

            // DatePicker – календарь, где можно выбрать дату.
            //selection: $selectedDate – выбранная дата сохранится в нашей переменной selectedDate.
            //displayedComponents: .date – показываем только день/месяц/год, без времени.
            DatePicker("Pick a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
            // .labelsHidden() – убираем подпись «Pick a date».
                .labelsHidden()
                .padding()

            Button {
                addWeek()
                
            } label: {
                Text("Add Week")
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: 370)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .padding()
        .alert("This week already exists.", isPresented: $showAlert) {
                   Button("ОК", role: .cancel) {}
               }
    }

    // функция чтобы взять понедельник и воскресенье
    func addWeek() {
        // calendar – это наш персональный календарный помощник
        // Calendar.current – это календарь, который берётся из настроек устройства, где запущено приложение.
        var calendar = Calendar.current
        // говорим, бери понедельники
        calendar.firstWeekday = 2 // 1 = Sunday, 2 = Monday ✅

        // weekStart - куда положим понедельник
        // calendar.date(from: говорим помощнику: «Сделай дату».
        // calendar.dateComponents(...) – спрашиваем у календаря: yearForWeekOfYear → какой год недели и weekOfYear → какой номер недели в этом году
        // 22 октября 2025 → год недели = 2025, номер недели = 43 (это пример)
        // Неделя начинается с понедельника, потому что мы сделали calendar.firstWeekday = 2» Календарь автоматически берёт первый день этой недели, то есть понедельник 20 октября 2025.
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: selectedDate))!
        
        
        // воскресенье = +6 дней от понедельника
        // calendar.date - говорим помощнику: «сделай дату».
        // byAdding: – «добавь…» , .day – «…дни», to: weekStart – «к понедельнику» ! – говорим: «Я уверен, что это получится, не бойся».
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        
        //  Проверяем, есть ли такая неделя уже в базе ---
                // достаём все недели этой цели
        let existingWeeks = goal.weeks

                // ищем неделю, у которой такие же даты начала и конца
                if existingWeeks.contains(where: { $0.startDate == weekStart && $0.endDate == weekEnd }) {
                    // если нашли — показываем окошко
                    showAlert = true
                    return
                }
        
        // создай новый обьет - новую неделю
        let newWeek = Week(
            // «Для какой цели?»: отвечает: «Для той цели, которая уже передана сюда сверху»
            goal: goal,
            // понедельник это? : справа результат нашего высчета
            startDate: weekStart,
            
            // воскресенье это? : справа результат нашего высчета
            endDate: weekEnd
        )
        
        
        if goal.weeks.isEmpty {
            withAnimation(.none) {
                    // вставляем первую неделю без анимации
                    context.insert(newWeek)
                    try? context.save()
                
                TelemetryDeck.signal("Add week")
            }
        } else {
                withAnimation {
                    context.insert(newWeek)
                    try? context.save()
                    
                    TelemetryDeck.signal("Add week")
                }
            
        }
        
        dismiss()

    }

}

#Preview {
    AddWeekView(goal: Goal())
}
