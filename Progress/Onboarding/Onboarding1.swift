//
//  Onboarding2.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-09.
//

import SwiftUI

struct Onboarding1: View {
    
    var actionButton: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background
                Color(red: 149/255, green: 100/255, blue: 152/255)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    // Cloud images
                    HStack {
                        Image("cloud1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width * 0.18)
                            .padding(.bottom, geo.size.height * 0.08)
                            .padding(.trailing, geo.size.width * 0.08)
                        
                        Image("cloud1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width * 0.2)
                            .padding(.top, 60)
                            .padding(.leading, 30)
                        
                        Image("cloud2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width * 0.20)
                            .padding(.bottom, geo.size.height * 0.12)
                            .padding(.leading, 20)
                        
                    }
                    
                    // Main image
                    Image("girl")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geo.size.height * 0.35)
                        .padding(.bottom, 50)
                    
                    // Text
                    Text("Welcome to Progress App!")
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 22, weight: .semibold))
                        .padding(.bottom, geo.size.height * 0.02)
                    
                    Text("No more waiting, glow up with every habit and become the person you want to be.")
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, geo.size.height * 0.06)
                    
                    // Button
                    Button {
                        actionButton()
                    } label: {
                        ZStack {
                            Image("Button")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width * 0.6, height: 42)
                            
                            Text("Start Now")
                                .font(Font.system(size: 18, weight: .medium))
                                .foregroundStyle(Color.white)
                        }
                    }
                    .padding(.bottom, geo.size.height * 0.1)
                    
                }
                .padding(.horizontal, 40)
                
            }
        }
    }
}

#Preview {
    Onboarding1 {
        // nothing
    }
}
