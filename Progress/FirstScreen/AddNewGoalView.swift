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
    
    @Environment(HabitModel.self) var model
    
    // context - сохраняем, редактируем и удаляем (кладем)
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // вынимаем. Сам следит за изменениями. Сам перерисовывает экран, если данные изменились
    @Query private var allGoals: [Goal]
    
    var goal: Goal
    var editMood: Bool
    
    var body: some View {
        
        @Bindable var model = model
        
        ZStack {
            
            Color.white
            
            VStack(alignment: .leading, spacing: 20) {
                
                Spacer()
                
                // goal
                TextField("My habit is...", text: $model.text)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: model.text) { oldValue, newValue in
                        model.text = TextHelper.limitChars(input: model.text, limit: 18)
                    }.padding(.horizontal)
                    .padding(.top)
                
                // options
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(model.displayOptions) { option in
                            // если пользователь нажал 2, тогда selectedOption = 2, если в списке displayOptions, каждый их него это option он в этом списке ищет 2, когда находит станоивтся true и появляется обводка
                            // Когда SwiftUI видит, что пользователь нажал на кружок (onTapGesture), оно выполняет функцию, которая хранится в onTap.
                            OptionView(emoji: option.emoji, habitOption: option.goalOption, isSelected: model.selectedGoal?.id == option.id, onTap: {
                                // если она уже выбрана, тогда selectedOption сделай nil тогда уберется обводка. 2 слева, справа в списке ищет 2, находит тогда isSelected = true
                                if model.selectedGoal?.id == option.id {
                                    model.selectedGoal = nil
                                    model.text = ""
                                }
                                else {
                                    // если не выбрана то selectedOption = выбранная карточка
                                    model.selectedGoal = option
                                    
                                    model.text = "\(option.emoji) \(option.goalOption)" // заполняем поле
                                    
                                }
                            })
                            
                        }
                    }.padding(.horizontal)
                }
                
                
                // times per week
                HStack(spacing: 0) {
                    Picker("", selection: $model.selectedOption) {
                        ForEach(model.options, id: \.self) { option in
                            Text("\(option)")
                        }
                    }.pickerStyle(.menu)
                    
                    Text("times per week")
                    
                    Spacer()
                    
                    if editMood {
                        Button("Delete") {
                            
                            model.showConfirmation = true
                            
                        }.buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.white)
                            .tint(.red)
                            .padding(.trailing, 10)
                    }
                    
                    
                    Button("Save") {
                        
                        if editMood {
                            withAnimation {
                                goal.goal = model.text
                                goal.timePerWeek = model.selectedOption
                                
                                try? context.save()
                            }
                        }
                        else {
                            if allGoals.count == 0 {
                                goal.goal = model.text
                                goal.timePerWeek = model.selectedOption
                                context.insert(goal)
                                
                                try? context.save()
                                
                                TelemetryDeck.signal("Add new goal")
                            }
                            else {
                                withAnimation {
                                    goal.goal = model.text
                                    goal.timePerWeek = model.selectedOption
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
                    .disabled(model.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .padding(.trailing, 10)
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                
            }
                .onAppear {
                    model.displayOptions = model.service.getOptions()
                    
                    model.text = goal.goal
                    
                    // eсли то число в скорбах (goal.timePerWeek) есть в списке массиве options тогда ответ будет true и сработает код в скобках
                    if model.options.contains(goal.timePerWeek) {
                        model.selectedOption = goal.timePerWeek
                    } else {
                        model.selectedOption = model.options.first ?? 1
                    }
                }
                .confirmationDialog("Delete this permanently?", isPresented: $model.showConfirmation, titleVisibility: .visible) {
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


