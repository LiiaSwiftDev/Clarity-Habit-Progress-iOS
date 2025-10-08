//
//  ProgressBarView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-07.
//

import SwiftUI

struct ProgressBarView: View {
    
    // передает значение из detailView отмеченные дни : на всего дней. например: 2/3 = 0.66
    var myProgress: Double
    
    var body: some View {
        
        HStack(spacing: 0) {
            // 0.66 * 100 = 66.0, Int(66.0) = 66
            Text("\(Int(myProgress * 100))")
                .font(.system(size: 14))
                .bold()
                .foregroundStyle(colorNumbers(progress: myProgress))
            
            Text("%")
                .font(.system(size: 12))
                .foregroundStyle(colorNumbers(progress: myProgress))
                .padding(.trailing, 10)
            
            ZStack(alignment: .leading) {
                Capsule()
                // сначала цвет потом frame
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 5)
                Capsule()
                    .fill(colorProgressBar(progress: myProgress))
                    .frame(width: CGFloat(maxWid(progress: myProgress)), height: 5)
                
            } .frame(width: 80)
        }
    }
    
    func maxWid(progress: Double) -> Int {
        if myProgress <= 1 {
            return Int(myProgress * 80)
        }
        else {
        return 1 * 80
        }
    }
    
    func colorProgressBar(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return .red
        case 0.31..<0.7 : return .orange
        case 0.7..<100 : return .green
        default:
            return .gray
        }
    }
    
    func colorNumbers(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return .red
        case 0.31..<0.7 : return .orange
        case 0.7..<100 : return .green
        default:
            return .gray
        
        }
    }
    
}

#Preview {
    ProgressBarView(myProgress: 0.6)
}
