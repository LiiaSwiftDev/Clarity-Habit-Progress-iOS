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

    @State private var showSheet = false
    @State var edit = false
    // optional потому что пока мы не выбрали это nil
    @State var selectedGoal: Goal?
   
    
    var allGoals: [Goal] {
        goals.sorted(by: { $0.createDate > $1.createDate })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        Text("My goals")
                            .font(.screanTitle)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                    } .padding(.horizontal, 22)
                        .padding(.top, 20)
                        
           
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 6) {
                            ForEach(allGoals) { g in
                                
                                NavigationLink {
                                    
                                    DetailView(progress: g)
                                    
                                } label: {
                                    GoalCardView(goalStorage: g)
                                        .padding(.top, 10)
                                        .onLongPressGesture {
                                            selectedGoal = g
                                            showSheet = true
                                            edit = true
                                        }
                                    
                                } .buttonStyle(.plain)
                            }
                        }.padding(.horizontal)
                         .padding(.bottom, 160)
                    }
                }
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            // Add new goal
                            showSheet = true
                            edit = false
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(Color("ButtonColor"))
                                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
                                
                                Text("New goal")
                                    .font(.buttonText)
                                    .foregroundStyle(Color("GrayInside"))
                                    .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: 0.5, y: 0)
                                    .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: -0.5, y: 0)
                                    .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: 0, y: 0.5)
                                    .shadow(color: Color("GrayOutside").opacity(0.9) ,radius: 0, x: 0, y: -0.5)
                                    
                                    
                                
                            }.frame(height: 60)
                                .padding(.bottom, 20)
                                .padding(.top, 10)
                                .padding(.horizontal, 10)
                            
                        }

                        Spacer()
                    }
                    .background {
                        Color("Background")
                            .background(.ultraThinMaterial)
                            .opacity(0.7)
                            .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                            .ignoresSafeArea()
                    }
                    
                    
                }
                    .sheet(isPresented: $showSheet) {
                        // show sheet to add new goal
                        AddNewGoalView(editMood: edit, goalS: selectedGoal)
                            .presentationDetents([.fraction(0.2)])
                    }
            }
        }
    }
}

#Preview {
    MainView()
}
