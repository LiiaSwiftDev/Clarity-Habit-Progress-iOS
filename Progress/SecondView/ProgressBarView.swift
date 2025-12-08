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
    var width: Double
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            
            ZStack(alignment: .leading) {
                Capsule()
                // сначала цвет потом frame
                    .fill(Color("EmptyCheckBox"))
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.4)
                    .frame(height: 5)
                Capsule()
                    .fill(colorProgressBar(progress: myProgress))
                    .stroke(colorStroke(progress: myProgress), lineWidth: 0.4)
                    .frame(width: CGFloat(maxWid(progress: myProgress)), height: 5)
                
            } .frame(width: CGFloat(width))
        }
    }
    
    func maxWid(progress: Double) -> Int {
        if myProgress <= 1 {
            return Int(myProgress * width)
        }
        else {
        return Int(1 * width)
        }
    }
    
    func colorProgressBar(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedInside")
        case 0.31..<0.7 : return Color("OrangeInside")
        case 0.7..<100 : return Color("GreenInside")
        default:
            return .gray
        }
    }
    
    func colorStroke(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedOutside")
        case 0.31..<0.7 : return Color("OrangeOutside")
        case 0.7..<100 : return Color("GreenOutside")
        default:
            return .gray
        }
        }
    }

#Preview {
    ProgressBarView(myProgress: 0.6, width: 100.0)
}
