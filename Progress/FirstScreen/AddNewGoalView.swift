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
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // SwiftData context (save/update/delete)
    @Environment(\.modelContext) private var context
    
    // Dismiss current screen
    @Environment(\.dismiss) private var dismiss
    
    // Fetch all goals
    @Query private var allGoals: [Goal]
    
    // Current goal (new or editing)
    var goal: Goal
    var editMood: Bool
    
    var body: some View {
        
        @Bindable var model = model
        
        ZStack {
            
            // Background
            Color.white
            
            VStack(alignment: .leading, spacing: 20) {
                
                Spacer()
                
                // Goal input
                TextField("My habit is...", text: $model.text)
                    .textFieldStyle(.roundedBorder)
                // Limit input length
                    .onChange(of: model.text) { oldValue, newValue in
                        model.text = TextHelper.limitChars(input: model.text, limit: 18)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                
                // Suggested habit options
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(model.displayOptions) { option in
                            
                            OptionView(emoji: option.emoji, habitOption: option.goalOption, isSelected: model.selectedGoal?.id == option.id, onTap: {
                                
                                // Toggle selection
                                if model.selectedGoal?.id == option.id {
                                    model.selectedGoal = nil
                                    model.text = ""
                                }
                                else {
                                    model.selectedGoal = option
                                    
                                    model.text = "\(option.emoji) \(option.goalOption)"
                                }
                            })
                        }
                    }.padding(.horizontal)
                }
                
                // Times per week picker
                HStack(spacing: 0) {
                    Picker("", selection: $model.selectedOption) {
                        ForEach(model.options, id: \.self) { option in
                            Text("\(option)")
                        }
                    }.pickerStyle(.menu)
                    
                    Text("times per week")
                    
                    Spacer()
                    
                    // Delete button (only in edit mode)
                    if editMood {
                        Button("Delete") {
                            
                            model.showConfirmation = true
                            
                        }.buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.white)
                            .tint(.red)
                            .padding(.trailing, 10)
                    }
                    
                    // Save button
                    Button("Save") {
                        // Update existing goal
                        if editMood {
                            withAnimation {
                                goal.goal = model.text
                                goal.timePerWeek = model.selectedOption
                                
                                try? context.save()
                            }
                        }
                        else {
                            // Create new goal
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
                    // Disable if input is empty
                    .disabled(model.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .padding(.trailing, 10)
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                
            }
            .onAppear {
                // Load options
                model.displayOptions = model.service.getOptions()
                
                // Fill existing data (edit mode)
                model.text = goal.goal
                
                // Number of times per week
                if model.options.contains(goal.timePerWeek) {
                    model.selectedOption = goal.timePerWeek
                } else {
                    model.selectedOption = model.options.first ?? 1
                }
            }
            // Delete confirmation
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


