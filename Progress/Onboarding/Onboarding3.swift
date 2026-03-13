//
//  Onboarding4.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-10.
//

import SwiftUI

struct Onboarding3: View {
    
    @State private var showComment = false
    @State private var pointerOpacity = 0.0
    @State private var scale = 1.0
    @State private var animationTask: Task<Void, Never>?
    
    var actionButton: () -> Void
    
    var body: some View {
        ZStack {
            
            Color(red: 149/255, green: 100/255, blue: 152/255)
                .ignoresSafeArea()
            
                Image(showComment ? "screen4" : "screen3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 650)
                    .animation(.easeInOut(duration: 0.5), value: showComment) // плавное переключение
                    .padding(.top, 50)
                
                Image("hand")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                    .padding(.bottom, 200)
                    .padding(.leading, 190)
                    .opacity(pointerOpacity)
                    .scaleEffect(scale)
            
            VStack {
                
                Text("We take care of\n your notes,\nso nothing slips")
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 22, weight: .semibold))
                    .padding(.top, 100)
                
                Spacer()
                
            Button {
                actionButton()
            } label: {
                ZStack {
                    Image("Button")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 42)
                    
                    Text("Continue")
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.white)
                }
            }
            .padding(.bottom, 90)
             
            }
            
        }
        .onAppear {
            startAnimationLoop()
        }
        .onDisappear {
            animationTask?.cancel()
        }
    }
    
    func startAnimationLoop() {

            animationTask = Task {

                while !Task.isCancelled {

                    showComment = false
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
                        showComment = true
                    }

                    try? await Task.sleep(nanoseconds: 2_000_000_000)

                }
            }
        }
    
}

#Preview {
    Onboarding3(actionButton: { // nothing
    })
}
