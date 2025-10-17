//
//  Onboarding1.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-09.
//

import SwiftUI

struct Onboarding1: View {
    
    @Environment(\.dismiss) var dismiss
    
    var actionButton: () -> Void
   
    var body: some View {
        ZStack {
            
            Color(red: 5/255, green: 114/255, blue: 161/255)
            
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Skip")
                                .foregroundStyle(Color.gray)
                                .padding(.horizontal, 16)
                                .padding(.top, 56)
                                .padding(.bottom, 99)
                }

                VStack(alignment: .center, spacing: 0) {
                    Image("girl")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 45)
                        
                    
                    Text("Welcome to Progress App!")
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 20)
                    
                    Text("Track your goals, celebrate your achievements, and stay motivated every day.")
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 110)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        // TODO
                        actionButton()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.black ,lineWidth: 1)
                                .fill(Color.white)
                                .frame(height: 50)
                            
                            Text("Continue")
                                .bold()
                                .foregroundStyle(Color.black)
                        }
                    }.padding(.bottom, 115)
                    
                }

            }
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    Onboarding1 {
        // nothing
    }
}
