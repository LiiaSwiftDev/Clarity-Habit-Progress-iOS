//
//  OptionView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-03.
//

import SwiftUI

struct OptionView: View {
    
    // This is a shared object that holds app data and is used across different screens
    @Environment(HabitModel.self) var model
    
    // Emoji to display
    var emoji: String
    
    // Habit name (e.g., "Workout")
    var habitOption: String
    
    // Is this option selected
    var isSelected: Bool
    
    // Action to perform when tapped
    let onTap: () -> Void
    @State private var tapped = false
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ZStack {
                // Background circle
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.purple)
                    .opacity(0.2)
                    .overlay(content: {
                        // Border circle (highlight if selected)
                        Circle()
                            .stroke(isSelected ? Color(red: 188/255, green: 59/255, blue: 168/255) : Color.clear, lineWidth: 2)
                            .frame(width: 68, height: 68)
                    })
                    .padding(.top, 10)
                
                // Emoji
                Text(emoji)
                    .font(Font.system(size: 31))
                    .padding(.top, 10)
            }
            
            // Habit name
            Text(habitOption)
                .font(Font.system(size: 16))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 78)
                .padding(.top, 7)
            
        }
        .frame(width: 75,
               height: 140,
               alignment: .top)
        // Tap animation
        .scaleEffect(scale)
        .onTapGesture {
            // shrink
            withAnimation(.easeIn(duration: 0.2)) {
                scale = 0.85
            }
            
            // expand
            withAnimation(.easeOut(duration: 0.3).delay(0.12)) {
                scale = 1.1
            }
            
            // return to normal
            withAnimation(.easeOut(duration: 0.35).delay(0.17)) {
                scale = 1.0
            }
            
            // Run the action when tapped
            onTap()
            
            tapped.toggle()
        } // Haptic Feedback
        .sensoryFeedback(.impact(weight: .light, intensity: 0.8), trigger: tapped)
    }
}


#Preview {
    OptionView(emoji: "💪", habitOption: "Workout", isSelected: false, onTap: {
        print("Tapped in preview")
    })
}
