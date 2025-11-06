//
//  Percent.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-31.
//

import SwiftUI

struct Percent: View {
    
    // // передает значение из detailView отмеченные дни : на всего дней. например: 2/3 = 0.66
    var myProgress: Double
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(getPercentage(input: myProgress))%")
                .font(.timesPerWeek)
                .foregroundStyle(colorNumbers(progress: myProgress))
                .shadow(color: strokeColor(progress: myProgress).opacity(0.9) ,radius: 0, x: 0.5, y: 0)
                .shadow(color: strokeColor(progress: myProgress).opacity(0.9) ,radius: 0, x: -0.5, y: 0)
                .shadow(color: strokeColor(progress: myProgress).opacity(0.9) ,radius: 0, x: 0, y: 0.5)
                .shadow(color: strokeColor(progress: myProgress).opacity(0.9) ,radius: 0, x: 0, y: -0.5)
        }
    }
    
    func colorNumbers(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedInside")
        case 0.31..<0.7 : return Color("OrangeInside")
        case 0.7..<100 : return Color("GreenInside")
        default:
            return .gray
        
        }
    }
    
    func strokeColor(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedOutside")
        case 0.31..<0.7 : return Color("OrangeOutside")
        case 0.7..<100 : return Color("GreenOutside")
        default:
            return .gray
        
        }
    }
    
    func getPercentage(input: Double) -> String {
        // 0.66 * 100 = 66.0, Int(66.0) = 66
        return String(Int(input * 100))
    }
    
}

#Preview {
    Percent(myProgress: 0.7)
}
