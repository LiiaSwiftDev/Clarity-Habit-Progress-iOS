//
//  DetailView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-04.
//

import SwiftUI
import SwiftData
import TelemetryDeck

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
    @State private var showSheetComment = false
    
    @State private var selectedWeek: Week?
    // отфильтрованые недели "Возьми из всего массива только те недели, которые принадлежат текущей цели progress."
    var goalWeeks: [Week] {
        // "Возьми только те недели, которые принадлежат этой цели." и номер которых больше чем 0
        allWeeks.filter { $0.goal?.id == progress.id }
        //"И отсортируй их по номеру недели, от последней до первого." Например, если недели в базе были [2,1,3], после сортировки получится [3,2,1].
            .sorted(by: { $0.startDate > $1.startDate })
    }
    
    
    var body: some View {
        
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 38, height: 40)
                                .foregroundStyle(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 4, x: 0, y: 4)
                            
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(Color.black)
                        }
                    }.padding(.leading, 20)
                    
                    Spacer()
                    
                }

                HStack {
                    Text(progress.goal)
                        .font(.screanTitle)
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                    
                    Text("\(progress.timePerWeek)/week")
                        .font(.timesPerWeek)
                        .foregroundStyle(Color("TimesPerWeek"))
                    
                }.padding(.horizontal)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            // "Для каждой недели создаём отдельную карточку."
                            ForEach(goalWeeks, id: \.id) { week in
                                // у кадлой карточки есть цель и неделя
                                WeekCardView(progress: progress, week: week)
                                    .animation(.easeInOut(duration: 0.5), value: goalWeeks)
                                    .onTapGesture {
                                        selectedWeek = week
                                        showSheetComment = true
                                    }
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
                                                        
                                                        TelemetryDeck.signal("Delete week")
                                                                }
                                            }),
                                            secondaryButton: .cancel())
                                    }
                            }
                           
                        } .padding(.bottom, 160)
                }    
            }
            
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        showSheet = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color("ButtonColor"))
                                .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
                            
                            Text("Add Week")
                                .font(.buttonText)
                                .foregroundStyle(Color("GrayInside"))
                                .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: 0.5, y: 0)
                                .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: -0.5, y: 0)
                                .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: 0, y: 0.5)
                                .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: 0, y: -0.5)
                                
                                
                            
                        } .frame(height: 60)
                            .padding(.bottom, 20)
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                        
                    }
                    
                    Spacer()

                }
                .background {
                    Color("Background")
                        .background(.thinMaterial)
                        //.opacity(0.7)
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
            .sheet(isPresented: $showSheetComment) {
                if let selectedWeek {
                    CommentView(goal: progress, week: selectedWeek)
                        .presentationDetents([.fraction(0.85)])
                }
            }

            .onAppear {
                TelemetryDeck.signal("Visited Detail Screen") 
            }
        
    }
    
}

#Preview {
    DetailView(progress: Goal())
}
