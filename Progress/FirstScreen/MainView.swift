//
//  ContentView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-01.
//

import SwiftUI
import SwiftData
import TelemetryDeck

struct MainView: View {
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // SwiftData context (save/update/delete)
    @Environment(\.modelContext) private var context
    
    // URL opener (e.g. email support)
    @Environment(\.openURL) var openURL
    
    // Fetch goals from database
    @Query private var goals: [Goal]
    
    // Sorted goals (newest first)
    var allGoals: [Goal] {
        goals.sorted(by: { $0.createDate > $1.createDate })
    }
    
    var body: some View {
        
        @Bindable var model = model
        
        NavigationStack {
            
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                // Show coach mark if there is no habits
                if allGoals.isEmpty {
                    VStack {
                        Spacer()
                        
                        // Image
                        Image("empty-box")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 176)
                            .padding(.bottom, 65)
                        
                        // Text
                        Text("No Habits\nCreate your first habit")
                            .font(Font.system(size: 18))
                            .foregroundStyle(Color(red: 129/255, green: 129/255, blue: 129/255))
                            .multilineTextAlignment(.center)
                            .frame(width: 185)
                        
                        Spacer()
                    }
                }
                
                VStack(spacing: 0) {
                    HStack {
                        // Header
                        Text("My habits")
                            .font(.screanTitle)
                            .foregroundStyle(Color.black)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                        // Email support
                        Button {
                            model.email.send(urlOpener: openURL)
                        } label: {
                            HStack {
                                Text("Email Support")
                                Image(systemName: "envelope.circle.fill")
                            }
                        }.padding(.bottom, 70)
                        
                    } .padding(.horizontal, 22)
                        .padding(.top, 20)
                    
                    // Goals list
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 6) {
                            ForEach(allGoals) { g in
                                
                                NavigationLink {
                                    
                                    DetailView(progress: g)
                                    
                                } label: {
                                    GoalCardView(goalStorage: g)
                                        .padding(.top, 10)
                                        .onLongPressGesture {
                                            model.newGoal = g
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
                        
                        // Add new habit button
                        Button {
                            self.model.newGoal = Goal()
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(Color("ButtonColor"))
                                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
                                
                                Text("New habit")
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
                            .background(.thinMaterial)
                            .opacity(0.7)
                            .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                            .ignoresSafeArea()
                    }
                }
                
            } // Add / edit sheet
            .sheet(item: $model.newGoal) { goal in
                // Check if editing
                let isEdit = goal.goal.trimmingCharacters(in: .whitespacesAndNewlines) != ""
                
                AddNewGoalView(goal: goal, editMood: isEdit)
                    .presentationDetents([.fraction(0.35)])
            }
            .onAppear {
                // Analytics
                TelemetryDeck.signal("Visited Home Screen")
            }
        }
        
    }
    
}
#Preview {
    MainView()
}
