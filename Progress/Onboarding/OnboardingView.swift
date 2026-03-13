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
            
            Color(red: 149/255, green: 100/255, blue: 152/255)
            
            TabView(selection: $selectedIndex) {
                
                Onboarding1(actionButton: {
                    withAnimation {
                        // переходим на сторую страницу
                        selectedIndex = 1
                    }
                    
                })
                .ignoresSafeArea()
                .tag(0)
                
                Onboarding2 {
                    withAnimation {
                        // переходим на сторую страницу
                        selectedIndex = 2
                    }
                }
                .ignoresSafeArea()
                .tag(1)
                
                Onboarding3 {
                    // выходим из onboarding и переходим в приложение
                    dismiss()
                }
                .ignoresSafeArea()
                .tag(2)
                
            }.tabViewStyle(.page(indexDisplayMode: .never))
            
        }.ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
