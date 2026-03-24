//
//  Onboarding4.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-10.
//

import SwiftUI

struct Onboarding3: View {
    
    // toggle between screen3 and screen4 images
    @State private var showComment = false
    @State private var pointerOpacity = 0.0
    @State private var scale = 1.0
    // stores the currently running animation task
    @State private var animationTask: Task<Void, Never>?
    
    var actionButton: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color(red: 149/255, green: 100/255, blue: 152/255)
                    .ignoresSafeArea()
                
                // Main image
                Image(showComment ? "screen4" : "screen3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geo.size.height * 0.8)
                    .animation(.easeInOut(duration: 0.5), value: showComment)
                    .padding(.top, 70)
                
                // Hand image
                Image("hand")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geo.size.height * 0.08)
                    .padding(.bottom, 200)
                    .padding(.leading, geo.size.width * 0.46)
                    .opacity(pointerOpacity)
                    .scaleEffect(scale)
                
                VStack {
                    // Text
                    Text("We take care of\n your notes,\nso nothing slips")
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: geo.size.width * 0.05, weight: .semibold))
                        .padding(.top, geo.size.height * 0.12)
                    
                    Spacer()
                    
                    // Button "Continue"
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
            // when the screen appears → start the animation
            .onAppear {
                startAnimationLoop()
            }
            // when the screen disappears → stop the running animation
            .onDisappear {
                animationTask?.cancel()
            }
        }
        
    }
    
    func startAnimationLoop() {
        // stores a reference to the task in animationTask
        animationTask = Task {
            
            // run this loop until the task is cancelled
            while !Task.isCancelled {
                
                // initial state so that on reset it always starts here
                showComment = false
                pointerOpacity = 0
                scale = 1
                
                // pause before continuing for 0.2 seconds.
                try? await Task.sleep(nanoseconds: 200_000_000)
                
                // animate pointerOpacity to 1
                await MainActor.run {
                    withAnimation(.easeIn(duration: 0.3)) {
                        pointerOpacity = 1
                    }
                }
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                
                // animate hand image shrinking to 0.85
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
                
                // animate hand image disappearing
                await MainActor.run {
                    withAnimation(.easeOut(duration: 0.2)) {
                        pointerOpacity = 0
                    }
                }
                
                try? await Task.sleep(nanoseconds: 300_000_000)
                
                await MainActor.run {
                    showComment = true
                }
                
                // shows "screen2" for 2 seconds
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                
            }
        }
    }
}

#Preview {
    Onboarding3(actionButton: { // nothing
    })
}
