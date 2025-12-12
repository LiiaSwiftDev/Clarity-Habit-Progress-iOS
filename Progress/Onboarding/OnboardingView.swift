//
//  OnboardingView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-09.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var selectedIndex = 0
    
    var body: some View {
        
        ZStack {
            
            Color(red: 5/255, green: 114/255, blue: 161/255)
            
            TabView(selection: $selectedIndex) {
                
                Onboarding1(actionButton: {
                    withAnimation {
                        // переходим на сторую страницу
                        selectedIndex = 1
                    }
                    
                })
                .ignoresSafeArea()
                .tag(0)
                
                Onboarding2(actionButton: {
                    // выходим из onboarding и переходим в приложение
                    dismiss()
                })
                .ignoresSafeArea()
                .tag(1)
                
            }.tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Spacer()
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedIndex == 0 ? .white : .gray)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedIndex == 1 ? .white : .gray)
                    Spacer()
                }.padding(.bottom, 235)
            }
                
        }.ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
