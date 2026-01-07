//
//  AddNewGoalView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-04.
//

import SwiftUI
import SwiftData
import TelemetryDeck

struct AddNewGoalView: View {
    
    // context - сохраняем, редактируем и удаляем (кладем)
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // вынимаем. Сам следит за изменениями. Сам перерисовывает экран, если данные изменились
    @Query private var allGoals: [Goal]
    
    @State private var text: String = ""
    @State private var showConfirmation: Bool = false
    
    @State private var selectedOption = 1
    let options = [1, 2, 3, 4, 5, 6, 7]
    
    var editMood: Bool
    var goalS: Goal?
    
    var body: some View {
        
        ZStack {
            
            Color.white
            
            VStack(alignment: .leading, spacing: 20) {
                TextField("My habit is...", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: text) { oldValue, newValue in
                        text = TextHelper.limitChars(input: text, limit: 17)
                    }

                // limit
                HStack(spacing: 0) {
                    Picker("", selection: $selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text("\(option)")
                        }
                    }.pickerStyle(.menu)
                    
                    Text("times per week")
                    
                    Spacer()
                    
                    if editMood {
                        Button("Delete") {
                            
                            showConfirmation = true
                            
                        }.buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.white)
                        .tint(.red)
                        .padding(.trailing, 10)
                    }
                   
                    
                    Button("Save") {
                        // Если editMood == true и выбранная цель есть (goalS != nil), то сохраняет изменения в существующем объекте.
                        // editMood должно быть true, goalS дожно быть не nil. обы услови должны быть true
                        if editMood, let goal = goalS {
                            withAnimation {
                                goal.goal = text
                                goal.timePerWeek = selectedOption
                                
                                try? context.save()
                            }
                        } else {
                            if allGoals.count == 0 {
                                let newGoal = Goal()
                                newGoal.goal = text
                                newGoal.timePerWeek = selectedOption
                                context.insert(newGoal)
                                
                                // Force SwiftData save. Потому что .save() это throws поэтому мы должны add try?
                                try? context.save()
                            }
                            else {
                                withAnimation {
                                    // Если editMood == false (режим создания новой цели), то создаёт новый объект Goal и вставляет его в базу данных (context.insert).
                                    let newGoal = Goal()
                                    newGoal.goal = text
                                    newGoal.timePerWeek = selectedOption
                                    context.insert(newGoal)
                                    
                                    // Force SwiftData save. Потому что .save() это throws поэтому мы должны add try?
                                    try? context.save()
                                    
                                  //  TelemetryManager.send("Add new goal",with: ["Name":text])
                                    
                                    TelemetryDeck.signal("Add new goal", parameters: ["Goal":text])
                                }
                            }
                            
                        }

                        dismiss()
                            
                    }
                    .buttonStyle(.borderedProminent)
                        .foregroundStyle(Color.white)
                        .tint(Color.blue)
                        .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        
                }
            }.padding()
            // Когда AddNewGoalView появляется, если editMood true и goalS не nil, то в TextField подставляются значения выбранной карточки для редактирования.
                .onAppear {
                    // editMood должно быть true, goalS дожно быть не nil. обы услови должны быть true
                    if editMood, let goal = goalS {
                        text = goal.goal
                        selectedOption = goal.timePerWeek
                    }
                
                }
                .confirmationDialog("Delete this permanently?", isPresented: $showConfirmation, titleVisibility: .visible) {
                            Button("Delete") {
                                if allGoals.count == 1 {
                                    if let goal = goalS {
                                        context.delete(goal)
                                        try? context.save()
                                        
                                        dismiss()
                                        
                                        TelemetryDeck.signal("Delete goal")
                                    }
                                }
                                    else {
                                        withAnimation {
                                            if let goal = goalS {
                                                 context.delete(goal)
                                                 try? context.save()
                                                 
                                                 dismiss()
                                                
                                                TelemetryDeck.signal("Delete goal")
                                             }
                                        }
                                    }
                                
                                
                            }
                        }
            
        }
        
        
    }
}

#Preview {
    AddNewGoalView(editMood: true)
}
