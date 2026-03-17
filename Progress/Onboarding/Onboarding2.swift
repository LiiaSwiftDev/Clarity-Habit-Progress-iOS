//
//  Onboarding3.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-10.
//

import SwiftUI

struct Onboarding2: View {
    
    @State private var showDetail = false
    @State private var pointerOpacity = 0.0
    @State private var scale = 1.0
    @State private var animationTask: Task<Void, Never>?
    
    var actionButton: () -> Void
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color(red: 149/255, green: 100/255, blue: 152/255)
                    .ignoresSafeArea()
                
                    Image(showDetail ? "screen2" : "screen1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geo.size.height * 0.8)
                        .animation(.easeInOut(duration: 0.5), value: showDetail) // плавное переключение
                        .padding(.top, 70)
                    
                    Image("hand")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geo.size.height * 0.08)
                        .padding(.bottom, 230)
                        .padding(.leading, 50)
                        .opacity(pointerOpacity)
                        .scaleEffect(scale)
                
                VStack {
                    
                    Text("Track your growth\nand enjoy\nyour progress")
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: geo.size.width * 0.05, weight: .semibold))
                        .padding(.top, geo.size.height * 0.12)
                    
                    Spacer()
                    
                Button {
                    actionButton()
                } label: {
                    ZStack {
                        Image("Button")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width * 0.6, height: 42)
                        
                        Text("Continue")
                            .font(Font.system(size: 18, weight: .medium))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.bottom, geo.size.height * 0.1)
                 
                }
                
            }
            .onAppear {
                startAnimationLoop()
            }
            .onDisappear {
                animationTask?.cancel()
            }
        }
        
    }
    
    func startAnimationLoop() {

            animationTask = Task {

                while !Task.isCancelled {

                    showDetail = false
                    pointerOpacity = 0
                    scale = 1

                    try? await Task.sleep(nanoseconds: 200_000_000)

                    await MainActor.run {
                        withAnimation(.easeIn(duration: 0.3)) {
                            pointerOpacity = 1
                        }
                    }

                    try? await Task.sleep(nanoseconds: 500_000_000)

                    await MainActor.run {
                        withAnimation(.linear(duration: 0.3)) {
                            scale = 0.85
                        }
                    }

                    try? await Task.sleep(nanoseconds: 300_000_000)

                    await MainActor.run {
                        withAnimation(.linear(duration: 0.3)) {
                            scale = 1
                        }
                    }

                    try? await Task.sleep(nanoseconds: 400_000_000)

                    await MainActor.run {
                        withAnimation(.easeOut(duration: 0.2)) {
                            pointerOpacity = 0
                        }
                    }

                    try? await Task.sleep(nanoseconds: 300_000_000)

                    await MainActor.run {
                        showDetail = true
                    }

                    try? await Task.sleep(nanoseconds: 2_000_000_000)

                }
            }
        }
    
}

#Preview {
    Onboarding2(actionButton: { // nothing
    })
}
