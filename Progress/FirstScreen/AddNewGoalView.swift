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
    
    var goal: Goal
    var editMood: Bool
    var service = DataService()
    // выбранный вариант
    @State var selectedGoal: Options?
    
    // все наши emoji and options
    @State private var displayOptions = [Options]()
    
    var body: some View {
        
        ZStack {
            
            Color.white
            
            
            VStack(alignment: .leading, spacing: 20) {
                
                Spacer()
                
                // goal
                TextField("My habit is...", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: text) { oldValue, newValue in
                        text = TextHelper.limitChars(input: text, limit: 18)
                    }
                
                // options
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(displayOptions) { option in
                            // если пользователь нажал 2, тогда selectedOption = 2, если в списке displayOptions, каждый их него это option он в этом списке ищет 2, когда находит станоивтся true и появляется обводка
                            // Когда SwiftUI видит, что пользователь нажал на кружок (onTapGesture), оно выполняет функцию, которая хранится в onTap.
                            OptionView(emoji: option.emoji, habitOption: option.goalOption, isSelected: selectedGoal?.id == option.id, onTap: {
                                // если она уже выбрана, тогда selectedOption сделай nil тогда уберется обводка. 2 слева, справа в списке ищет 2, находит тогда isSelected = true
                                if selectedGoal?.id == option.id {
                                    selectedGoal = nil
                                    text = ""
                                                                    }
                                else {
                                    // если не выбрана то selectedOption = выбранная карточка
                                    selectedGoal = option

                                    text = "\(option.emoji) \(option.goalOption)" // заполняем поле
                                    
                                }
                            })
                                
                        }
                    }
                }
                
                // times per week
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
                        
                        if editMood {
                            withAnimation {
                                goal.goal = text
                                goal.timePerWeek = selectedOption
                                
                                try? context.save()
                            }
                        }
                        else {
                            if allGoals.count == 0 {
                                goal.goal = text
                                goal.timePerWeek = selectedOption
                                context.insert(goal)
                                
                                try? context.save()
                                TelemetryDeck.signal("Add new goal")
                            }
                            else {
                                withAnimation {
                                    goal.goal = text
                                    goal.timePerWeek = selectedOption
                                    context.insert(goal)
                                    
                                    try? context.save()
                                    TelemetryDeck.signal("Add new goal")
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
                .onAppear {
                    displayOptions = service.getOptions()
                    
                    text = goal.goal
                    
                    // eсли то число в скорбах (goal.timePerWeek) есть в списке массиве options тогда ответ будет true и сработает код в скобках
                    if options.contains(goal.timePerWeek) {
                        selectedOption = goal.timePerWeek
                    } else {
                        selectedOption = options.first ?? 1
                    }
                }
                .confirmationDialog("Delete this permanently?", isPresented: $showConfirmation, titleVisibility: .visible) {
                    Button("Delete") {
                        if allGoals.count == 1 {
                            context.delete(goal)
                            try? context.save()
                            
                            TelemetryDeck.signal("Delete goal")
                        }
                        else {
                            withAnimation {
                                context.delete(goal)
                                try? context.save()
                                
                                TelemetryDeck.signal("Delete goal")
                            }
                        }
                        
                        dismiss()
                        
                    }
                }
        }
    }
}


