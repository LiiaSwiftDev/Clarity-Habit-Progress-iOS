//
//  GoalCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-03.
//

import SwiftUI
import SwiftData

struct GoalCardView: View {
    
    @Query private var allWeeks: [Week]
    
    var goalStorage: Goal
    @State private var marked: Int = 0
    
    // это все фильтр чтобы получить progress bar последней недели. это как коробочка, в которую мы что-то кладём. В данном случае в неё мы положим последнюю неделю.
    var lastWeek: Week {
        // goalWeeks — имя этой новой коробочки. В ней будут только недели для нашей цели.
        let goalWeek = allWeeks
            .filter {
                // тут мы фильтруем все недели и берем все недели к одной цели
                $0.goal?.id == goalStorage.id
            }
        //недели сортируются от самой большой к самой маленькой, т.е. последняя неделя будет первой в списке.
            .sorted { $0.startDate > $1.startDate }
        return goalWeek.first ?? Week(goal: goalStorage, startDate: Date(), endDate: Date())
    }
    
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
                    
                    ProgressBarView(myProgress: Double(lastWeek.markedDaysCount) / Double(goalStorage.timePerWeek))
                    
                }
            }.padding()
            
        }
        
    }
}

