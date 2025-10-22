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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 243/255, green: 203/255, blue: 228/255)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("My goals")
                        .font(.custom("SFProRounded-Bold", size: 34))
                        .padding(.bottom, 30)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(goals) { g in
                                
                                NavigationLink {
                                    
                                    DetailView(progress: g)
                                    
                                } label: {
                                    GoalCardView(goalStorage: g)
                                        .padding(.top, 10)
                                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
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
                                    .stroke(Color.black, lineWidth: 1)
                                    .fill(
                                        LinearGradient(colors: [Color(red: 230/255, green: 113/255, blue: 142/255), Color(red: 209/255, green: 64/255, blue: 100/255)], startPoint: .top, endPoint: .bottom)
                                    )
                                
                                Text("+ New goal")
                                    .foregroundStyle(Color.white)
                                
                            }.frame(width: 366, height: 50)
                                .padding(.bottom, 20)
                                .padding(.top, 10)
                            
                        }

                        Spacer()
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
