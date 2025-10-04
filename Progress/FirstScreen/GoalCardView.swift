//
//  GoalCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-03.
//

import SwiftUI

struct GoalCardView: View {
    
    var goalStorage: Goal
    
    var body: some View {
        ZStack {
             Rectangle()
                .foregroundStyle(.white)
                .shadow(radius: 40, x: 0, y: 4)

            VStack {
                HStack {
                    Text(goalStorage.goal)
                        .font(.custom("SFProRounded-Medium", size: 30))
                    Spacer()
                    
                    Text("\(goalStorage.timePerWeek)/week")
                        .font(.system(size: 14))
                    
                }
                
                HStack {
                    Text("Progress of this week:")
                        .font(.system(size: 14))
                    Spacer()
                    
                    Text("25%")
                        .font(.headline)
                        .foregroundStyle(.red)
                    
                    ZStack(alignment: .leading) {
                        Capsule()
                        // сначала цвет потом frame
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 8)
                        Capsule()
                            .fill(Color.red)
                            .frame(width: 100 * 0.25, height: 8)
                            
                    } .frame(width: 100)
                    
                }
            }.padding()
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    GoalCardView(goalStorage: Goal())
}
