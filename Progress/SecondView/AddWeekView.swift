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
    
    // Dismiss current screen
    @Environment(\.dismiss) var dismiss
    
    // SwiftData context (save/update/delete)
    @Environment(\.modelContext) private var context
    
    // Goal this week will be attached to
    var goal: Goal
    
    // Selected date from calendar (default today)
    @State private var selectedDate = Date()
    
    // Show alert if week already exists
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Instruction for user
            Text("Select a day from the week you’d like to track.")
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding(.top, 10)
            
            // Calendar picker for selecting a date
            DatePicker("Pick a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding()
            
            // Button to add week
            Button {
                // Create week for selected date
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
    
    // Create a new week for the selected date
    func addWeek() {
        var calendar = Calendar.current
        // 1 = Sunday, 2 = Monday
        calendar.firstWeekday = 2
        
        // Calculate start of week (Monday)
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: selectedDate))!
        
        // Calculate end of week (Sunday)
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        
        // Check if week already exists for this goal
        let existingWeeks = goal.weeks
        
        // ищем неделю, у которой такие же даты начала и конца
        if existingWeeks.contains(where: { $0.startDate == weekStart && $0.endDate == weekEnd }) {
            showAlert = true
            return
        }
        
        // Create new week object
        let newWeek = Week(
            goal: goal,
            startDate: weekStart,
            endDate: weekEnd
        )
        
        if goal.weeks.isEmpty {
            withAnimation(.none) {
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
