//
//  AddWeekView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-20.
//

import SwiftUI
import SwiftData

struct AddWeekView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

    var goal: Goal

    @State private var selectedDate = Date()

    var body: some View {
        VStack(spacing: 20) {
            Text("Select any day of the week")
                .font(.title3)
                .padding(.top, 10)

            DatePicker("Pick a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding()

            Button {
                addWeek()
                dismiss()
            } label: {
                Text("Add Week")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .padding()
    }

    func addWeek() {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // 1 = Sunday, 2 = Monday ✅

        // находим понедельник этой недели
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: selectedDate))!
        
        // воскресенье = +6 дней от понедельника
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        
        let newWeek = Week(
            goal: goal,
            startDate: weekStart,
            endDate: weekEnd
        )

        context.insert(newWeek)
        try? context.save()
    }

}

#Preview {
    AddWeekView(goal: Goal())
}
