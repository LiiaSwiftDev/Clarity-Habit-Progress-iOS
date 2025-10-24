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
    
    // "Я храню их в массиве allWeeks — это список всех недель." allWeeks — это полный массив всех недель, которые есть в базе, для всех целей. Например, если у тебя три цели, и у каждой есть по 2 недели, то allWeeks будет содержать все 6 объектов.
    @Query private var allWeeks: [Week]
    
    @State private var showSheet = false
    @State private var weekToDelete: Week? = nil
    @State private var showAlert: Bool = false
    // "На этом экране мы показываем одну конкретную цель и её прогресс."
    var progress: Goal
    
    // отфильтрованые недели "Возьми из всего массива только те недели, которые принадлежат текущей цели progress."
    var goalWeeks: [Week] {
        // "Возьми только те недели, которые принадлежат этой цели." и номер которых больше чем 0
        allWeeks.filter { $0.goal?.id == progress.id }
        //"И отсортируй их по номеру недели, от последней до первого." Например, если недели в базе были [2,1,3], после сортировки получится [3,2,1].
            .sorted(by: { $0.startDate > $1.startDate })
    }
    
    
    var body: some View {
        
        ZStack {
            Color(red: 243/255, green: 203/255, blue: 228/255)
                .ignoresSafeArea()
            
            VStack {
                ScrollView(showsIndicators: false) {
                    // "Для каждой недели создаём отдельную карточку."
                    ForEach(goalWeeks, id: \.id) { week in
                        // у кадлой карточки есть цель и неделя
                        WeekCardView(progress: progress, week: week)
                            .onLongPressGesture {
                                weekToDelete = week
                                showAlert = true
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Delete Week"),
                                    message: Text("Delete this week permanently? This action cannot be undone."),
                                    // .destructive - make button red
                                    primaryButton: .destructive(Text("Delete"), action: {
                                        if let week = weekToDelete {
                                            context.delete(week)
                                            try? context.save()
                                        }
                                        
                                        
                                        
                                    }),
                                    secondaryButton: .cancel())
                            }
                    } 
                    .padding(.bottom, 160)
                    .padding(.top, 20)
                    
                }.padding(.top, 60)
                
            }
            
            VStack(alignment: .leading) {
                VStack(spacing: 10) {
                    HStack {
                        Text(progress.goal)
                            .font(.custom("SFProRounded-Medium", size: 30))
                        Spacer()
                        
                        Text("\(progress.timePerWeek)/week")
                            .font(.system(size: 14))
                        
                    }.padding(.horizontal)
                    
                }.padding()
                // background (_content_)
                    .background {
                        Color.white
                            .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                            .ignoresSafeArea()
                    }
                
                Spacer()
                
                HStack {
                    Button {
                        showSheet = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1)
                                .fill(
                                    LinearGradient(colors: [Color(red: 230/255, green: 113/255, blue: 142/255), Color(red: 209/255, green: 64/255, blue: 100/255)], startPoint: .top, endPoint: .bottom)
                                )
                            
                            Text("Add week")
                                .foregroundStyle(Color.white)
                            
                        } .frame(width: 170, height: 50)
                            .padding(.bottom, 20)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                        
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
                            .padding(.bottom, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                    }
                    
                    
                }
                .background {
                    Color(red: 243/255, green: 203/255, blue: 228/255)
                        .background(.ultraThinMaterial)
                        .opacity(0.7)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                        .ignoresSafeArea()
                }
            }
            
        } .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showSheet) {
                // to do
                AddWeekView(goal: progress)
                    .presentationDetents([.fraction(0.7)])
            }
        
    }
    
}

#Preview {
    DetailView(progress: Goal())
}
