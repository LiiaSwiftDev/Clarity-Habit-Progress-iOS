//
//  Percent.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-31.
//

import SwiftUI

struct Percent: View {
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // Completed days / Planned days for the week (e.g., 2/3 = 0.66)
    var myProgress: Double
    
    var body: some View {
        HStack(spacing: 0) {
            // Display percentage with color and shadow
            Text("\(model.getPercentage(input: myProgress))%")
                .font(.timesPerWeek)
                .foregroundStyle(model.colorProgressBar(progress: myProgress))
                .shadow(color: model.colorStroke(progress: myProgress).opacity(0.9) ,radius: 0, x: 0.5, y: 0)
                .shadow(color: model.colorStroke(progress: myProgress).opacity(0.9) ,radius: 0, x: -0.5, y: 0)
                .shadow(color: model.colorStroke(progress: myProgress).opacity(0.9) ,radius: 0, x: 0, y: 0.5)
                .shadow(color: model.colorStroke(progress: myProgress).opacity(0.9) ,radius: 0, x: 0, y: -0.5)
        }
    }
}

#Preview {
    Percent(myProgress: 0.7)
}
