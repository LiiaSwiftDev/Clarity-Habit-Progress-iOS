//
//  DetailView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-04.
//

import SwiftUI

struct DetailView: View {
    
    var progress: Goal
    
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
                
            }
            
            VStack {
                HStack {
                    Text("October 6 - October 12, 2025")
                        .font(.system(size: 12))
                    Spacer()
                    ProgressBarView()
                }.padding(.horizontal, 10)
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .opacity(0.6)
                        .shadow(color: .black,radius: 5, x: 0, y: 4)
                    // Thu, Fri, Sat, Sun
                    ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                DayCardView(days: "Mon", numberOfDays: "6")
                                DayCardView(days: "Tue", numberOfDays: "7")
                                DayCardView(days: "Wed", numberOfDays: "8")
                                DayCardView(days: "Thu", numberOfDays: "9")
                                DayCardView(days: "Fri", numberOfDays: "10")
                                DayCardView(days: "Sat", numberOfDays: "11")
                                DayCardView(days: "Sun", numberOfDays: "12")
                                
                                
                            } .padding(.horizontal)
                        }
                    
                }.frame(height: 110)
                
                Spacer()
                
            } .padding()
                .padding(.top, 120)
            
        }
    }
}

#Preview {
    DetailView(progress: Goal())
}
