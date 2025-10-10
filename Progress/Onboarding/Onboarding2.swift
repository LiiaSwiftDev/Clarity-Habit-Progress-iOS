//
//  Onboarding2.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-09.
//

import SwiftUI

struct Onboarding2: View {
    
    var actionButton: () -> Void
    
    var body: some View {
        ZStack {
            
            Color(red: 5/255, green: 114/255, blue: 161/255)
            
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                
                Image("goal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, 47)
                    .padding(.trailing, 5)
                 
                VStack(alignment: .center, spacing: 0) {

                    Text("Set your goals")
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 20)
                    
                    Text("Choose what you want to achieve and take your first step toward progress.")
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
                            
                            Text("Get Started")
                                .bold()
                                .foregroundStyle(Color.black)
                        }
                    }.padding(.bottom, 115)
                    
                }
                .padding(.horizontal)
            }
            
            
        }
    }
}

#Preview {
    Onboarding2 {
        // nothing
    }
}
