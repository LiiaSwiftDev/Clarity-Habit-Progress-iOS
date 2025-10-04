//
//  GoalCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-03.
//

import SwiftUI

struct GoalCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 366, height: 103)
                .foregroundStyle(.white)
                .shadow(radius: 10)
            
            VStack {
                HStack {
                    Text("Workout")
                        .font(.custom("SFProRounded-Medium", size: 30))
                    Spacer()
                    
                    Text("3/week")
                        .font(.system(size: 14))
                    
                }.padding(.horizontal, 40)
                
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
                    
                }.padding(.horizontal, 40)
            }
            
            
        }
    }
}

#Preview {
    GoalCardView()
}
