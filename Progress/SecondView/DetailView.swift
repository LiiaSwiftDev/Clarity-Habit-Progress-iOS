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
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // SwiftData context (save/update/delete)
    @Environment(\.modelContext) private var context
    
    // Dismiss current screen
    @Environment(\.dismiss) var dismiss
    
    // Current screen width
    @Environment(\.horizontalSizeClass) private var hSize
    
    // All weeks in database (for all goals)
    @Query private var allWeeks: [Week]
    
    // The goal we are showing on this screen
    var progress: Goal
    
    // Weeks for this goal, sorted (newest first)
    var goalWeeks: [Week] {
        allWeeks.filter { $0.goal?.id == progress.id }
        
            .sorted(by: { $0.startDate > $1.startDate })
    }
    
    var body: some View {
        
        @Bindable var model = model
        
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    // Back button
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
                
                // Goal title and times per week
                HStack {
                    Text(progress.goal)
                        .font(.screanTitle)
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                    
                    Text("\(progress.timePerWeek)/week")
                        .font(.timesPerWeek)
                        .foregroundStyle(Color("TimesPerWeek"))
                    
                }.padding(.horizontal)
                
                // Weeks list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(goalWeeks, id: \.id) { week in
                            WeekCardView(progress: progress, week: week)
                                .padding(.horizontal, 20)
                                .animation(.easeInOut(duration: 0.5), value: goalWeeks)
                                .onTapGesture {
                                    model.selectedWeek = week
                                    model.showSheetComment = true
                                }
                                .onLongPressGesture {
                                    model.weekToDelete = week
                                    model.showAlert = true
                                }
                                .alert(isPresented: $model.showAlert) {
                                    Alert(
                                        title: Text("Delete Week"),
                                        message: Text("Delete this week permanently? This action cannot be undone."),
                                        primaryButton: .destructive(Text("Delete"), action: {
                                            
                                            if let week = model.weekToDelete {
                                                
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
            
            // Add Week button at bottom
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        model.showSheet = true
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
                        .opacity(0.7)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        // Show Add Week sheet
        .sheet(isPresented: $model.showSheet) {
            AddWeekView(goal: progress)
                .presentationDetents([.height(560)])
        }
        // Show Comment sheet
        .sheet(isPresented: $model.showSheetComment, content: {
            if let week = model.selectedWeek {
                CommentView(goal: progress, week: week)
                    .presentationDetents([.height(560)])
            }
        })
        
        .onAppear {
            TelemetryDeck.signal("Visited Detail Screen")
            
            // Create first week if none exist
            if goalWeeks.isEmpty {
                firstWeek()
            }
        }
    }
    
    // Create first week for a goal if it doesn't exist
    func firstWeek() {
        var calendar = Calendar.current
        // Monday
        calendar.firstWeekday = 2
        let today = Date()
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        
        // Only create if this week doesn't already exist
        if !progress.weeks.contains(where: { week in
            week.startDate == weekStart && week.endDate == weekEnd
        }) {
            let firstWeek = Week(goal: progress, startDate: weekStart, endDate: weekEnd)
            context.insert(firstWeek)
            try? context.save()
        }
    }
    
}

#Preview {
    DetailView(progress: Goal())
}
