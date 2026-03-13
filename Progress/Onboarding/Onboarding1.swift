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
        ZStack {
            
            Color(red: 149/255, green: 100/255, blue: 152/255)
                .ignoresSafeArea()
            
            VStack {
 
                Spacer()
                
                HStack {
                    Image("cloud1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)

                    Image("cloud1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70)
                        .padding(.top, 60)
                        .padding(.leading, 30)
                    
                    Image("cloud2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .padding(.bottom, 50)
                        .padding(.leading, 20)
                    
                    
                }
                
                Image("girl")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .padding(.bottom, 50)
                
                Text("Welcome to Progress App!")
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 22, weight: .semibold))
                    .padding(.bottom, 20)
                    
                
                Text("No more waiting, glow up with every habit and become the person you want to be.")
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)

            Button {
                actionButton()
            } label: {
                ZStack {
                    Image("Button")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 42)
                    
                    Text("Start Now")
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.white)
                }
            }
            .padding(.bottom, 90)
             
            }
            .padding(.horizontal, 40)
            
        }

    }

}

#Preview {
    Onboarding1 {
        // nothing
    }
}
