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
                
                Button("Save") {
                    // save to swift data
                    let newGoal = Goal()
                    newGoal.goal = text
                    newGoal.timePerWeek = Int(times) ?? 0
                    context.insert(newGoal)

                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                    .foregroundStyle(Color.white)
                    .tint(Color.blue)
            }
        }.padding()
    }
}

#Preview {
    AddNewGoalView()
}
