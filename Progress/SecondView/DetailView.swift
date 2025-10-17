//
//  DetailView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-04.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @Query private var allActivities: [Activity]

    var weeks: [Activity] {
        allActivities.filter { $0.goal?.id == progress.id }
    }

    
    @State var numberOfWeeks: Int = 0
    
    var progress: Goal
    // новая переменная состояния, которая хранит, сколько дней уже отмечено пользователем.
    //@State private var markedDays: Int = 0
    
    var body: some View {
        
        ZStack {
            Color(red: 243/255, green: 203/255, blue: 228/255)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 10) {
                    HStack {
                        Text(progress.goal)
                            .font(.custom("SFProRounded-Medium", size: 30))
                        Spacer()
                        
                        Text("\(progress.timePerWeek)/week")
                            .font(.system(size: 14))
                        
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Progress of this week:")
                            .font(.system(size: 14))
                        Spacer()
                        
                        ProgressBarView(myProgress: Double(progress.markedDaysCount) / Double(progress.timePerWeek))
                        
                    }.padding(.horizontal, 30)
                    
                }.padding()
                // background (_content_)
                    .background {
                        Color.white
                            .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                            .ignoresSafeArea()
                    }
                Spacer()
                
                VStack {
                    ScrollView {
                        // Рисуй недели только если их реально больше нуля.
                        if numberOfWeeks > 0 {
                            ForEach(1...numberOfWeeks, id: \.self) { week in
                                WeekCardView(progress: progress, week: week)
                            }
                        }
                    }.padding(.bottom, 80)
                }
            }
            
            VStack(alignment: .leading) {
                
                Spacer()
                
                HStack {
                    Button {
                        // add week button
                        numberOfWeeks += 1
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                                .fill(
                                    LinearGradient(colors: [Color(red: 230/255, green: 113/255, blue: 142/255), Color(red: 209/255, green: 64/255, blue: 100/255)], startPoint: .top, endPoint: .bottom)
                                )
                            
                            Text("Add week")
                                .foregroundStyle(Color.white)
                            
                        }.frame(width: 170, height: 50)
                            .padding(.bottom, 34)
                            .padding(.leading, 20)
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        // back button
                        dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black)
                            
                            Text("Back")
                                .foregroundStyle(Color.white)
                            
                        }.frame(width: 172, height: 52)
                            .padding(.bottom, 34)
                            .padding(.trailing, 20)
                    }
                    
                    
                }
                
                
                
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let showWeeks = weeks.map(\.week).max() {
                numberOfWeeks = showWeeks
            }
            else {
                numberOfWeeks = 0
            }
        }
    }
}

#Preview {
    DetailView(progress: Goal())
}
