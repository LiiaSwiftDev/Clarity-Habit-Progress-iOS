//
//  ContentView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-01.
//

import SwiftUI
import SwiftData

struct MainView: View {
    // для того чтобы положить. Через него можно сохранять, изменять и удалять объекты в вашей модели данных.
    @Environment(\.modelContext) private var context
    // для того чтобы взять. достаёт объекты из базы данных
    @Query private var goals: [Goal]
    
    var body: some View {
        ZStack {
            Color(red: 243/255, green: 203/255, blue: 228/255)
            
            VStack(spacing: 40) {
                Text("My goals")
                    .font(.custom("SFProRounded-Bold", size: 34))
                    .padding(.top, 80)
                
                GoalCardView()
                GoalCardView()
                GoalCardView()
                GoalCardView()

                Spacer()
                
                Button {
                    // Add new goal
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 1)
                            .fill(
                                LinearGradient(colors: [Color(red: 230/255, green: 113/255, blue: 142/255), Color(red: 209/255, green: 64/255, blue: 100/255)], startPoint: .top, endPoint: .bottom)
                            )

                        Text("+ New goal")
                            .foregroundStyle(Color.white)
                        
                    }.frame(width: 366, height: 50)
                        .padding(.bottom, 44)
                    
                }//.ignoresSafeArea(.keyboard, edges: .bottom)

                    
            }
            
        }.ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
