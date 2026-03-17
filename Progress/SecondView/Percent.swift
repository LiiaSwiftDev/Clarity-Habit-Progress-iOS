//
//  Percent.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-31.
//

import SwiftUI

struct Percent: View {
    
    @Environment(HabitModel.self) var model
    // передает значение из detailView отмеченные дни : на всего дней. например: 2/3 = 0.66
    var myProgress: Double
    
    var body: some View {
        HStack(spacing: 0) {
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
