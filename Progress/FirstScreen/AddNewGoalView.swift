//
//  AddNewGoalView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-04.
//

import SwiftUI
import SwiftData

struct AddNewGoalView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var text: String = ""
    @State private var times: String = ""
    @State private var showConfirmation: Bool = false
    
    var editMood: Bool
    var goalS: Goal?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("My goal is...", text: $text)
                .textFieldStyle(.roundedBorder)

            // limit
            HStack {
                TextField("", text: $times)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(width: 60)
                // limit 7
                Text("times per week")
                
                Spacer()
                
                if editMood {
                    Button("Delete") {
                        
                        showConfirmation = true
                        
                    }.buttonStyle(.borderedProminent)
                        .foregroundStyle(Color.white)
                    .tint(.red)
                }
               
                
                Button("Save") {
                    // Если editMood == true и выбранная цель есть (goalS != nil), то сохраняет изменения в существующем объекте.
                    // editMood должно быть true, goalS дожно быть не nil. обы услови должны быть true
                    if editMood, let goal = goalS {
                        goal.goal = text
                        goal.timePerWeek = Int(times) ?? 0
                        
                        try? context.save()
                    } else {
                        // Если editMood == false (режим создания новой цели), то создаёт новый объект Goal и вставляет его в базу данных (context.insert).
                        let newGoal = Goal()
                        newGoal.goal = text
                        newGoal.timePerWeek = Int(times) ?? 0
                        context.insert(newGoal)
                        
                        // Force SwiftData save. Потому что .save() это throws поэтому мы должны add try?
                        try? context.save()
                    }

                    dismiss()
                        
                }
                .buttonStyle(.borderedProminent)
                    .foregroundStyle(Color.white)
                    .tint(Color.blue)
            }
        }.padding()
        // Когда AddNewGoalView появляется, если editMood true и goalS не nil, то в TextField подставляются значения выбранной карточки для редактирования.
            .onAppear {
                // editMood должно быть true, goalS дожно быть не nil. обы услови должны быть true
                if editMood, let goal = goalS {
                    text = goal.goal
                    times = String(goal.timePerWeek)
                }
            
            }
            .confirmationDialog("Delete this permanently?", isPresented: $showConfirmation, titleVisibility: .visible) {
                        Button("Delete") {
                           if let goal = goalS {
                                context.delete(goal)
                                try? context.save()
                                
                                dismiss()
                            }
                            
                        }
                    }
    }
}

#Preview {
    AddNewGoalView(editMood: true)
}
