//
//  GoalCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-03.
//

import SwiftUI

struct GoalCardView: View {
    
    var goalStorage: Goal
    @State private var marked: Int = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 4)


            VStack(spacing: 10) {
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
                    
              //      ProgressBarView(myProgress: Double(goalStorage.markedDaysCount) / Double(goalStorage.timePerWeek))
                    
                }
            }.padding()
            
        }
        
    }
}

#Preview {
    GoalCardView(goalStorage: Goal())
}
