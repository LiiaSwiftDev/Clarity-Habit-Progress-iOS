//
//  ProgressBarView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-07.
//

import SwiftUI

struct ProgressBarView: View {
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // Completed days / Planned days for the week (e.g., 2/3 = 0.66)
    var myProgress: Double
    var width: Double
    
    var body: some View {
        HStack(spacing: 0) {
            
            ZStack(alignment: .leading) {
                Capsule()
                // Background capsule
                    .fill(Color("EmptyCheckBox"))
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.4)
                    .frame(height: 5)
                
                // Filled progress capsule
                Capsule()
                    .fill(model.colorProgressBar(progress: myProgress))
                    .stroke(model.colorStroke(progress: myProgress), lineWidth: 0.4)
                    .frame(width: CGFloat(maxWid(progress: myProgress)), height: 5)
                
            } .frame(width: CGFloat(width))
        }
    }
    
    // Calculate width of the filled part of the bar
    func maxWid(progress: Double) -> Int {
        if myProgress <= 1 {
            return Int(myProgress * width)
        }
        else {
            return Int(1 * width)
        }
    }
}

#Preview {
    ProgressBarView(myProgress: 0.6, width: 100.0)
}
