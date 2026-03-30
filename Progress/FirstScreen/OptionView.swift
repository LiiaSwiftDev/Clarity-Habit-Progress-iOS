//
//  OptionView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-03.
//

import SwiftUI

struct OptionView: View {
    
    @Environment(HabitModel.self) var model
    
    var emoji: String
    var habitOption: String
    var isSelected: Bool
    //То есть onTap — это как кнопка-пустышка, в которую можно положить любую функцию, и потом вызвать её.
    let onTap: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0) {
                 
                ZStack {
                    // круг
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color.purple)
                        .opacity(0.2)
                        .overlay(content: {
                            // сверху на него другой круг
                            // чтоьы обводка была внутри круга 70, делаем круг 68 и обводка 2, получаем 70
                            Circle()
                                .stroke(isSelected ? Color(red: 188/255, green: 59/255, blue: 168/255) : Color.clear, lineWidth: 2)
                                .frame(width: 68, height: 68)
                        })
                        .padding(.top, 10)

                    // emoji "💪"
                    Text(emoji)
                        .font(Font.system(size: 31))
                        .padding(.top, 10)
                }
                
                // "Workout"
                Text(habitOption)
                    .font(Font.system(size: 16))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 78)
                    .padding(.top, 7)
        
            }
                .frame(width: 75,
                       height: 140, alignment: .top)
              //  .padding(.leading)
                .scaleEffect(model.scale)
                .onTapGesture {
                    // 1️⃣ сжать до 0.85
                        withAnimation(.easeIn(duration: 0.2)) {
                            model.scale = 0.85
                        }
                        
                        // 2️⃣ расширить до 1.1 с небольшой задержкой
                        withAnimation(.easeOut(duration: 0.3).delay(0.12)) {
                            model.scale = 1.1
                        }
                        
                        // 3️⃣ вернуть в 1.0
                        withAnimation(.easeOut(duration: 0.35).delay(0.17)) {
                            model.scale = 1.0
                    }
                    
                    //Когда SwiftUI видит, что пользователь нажал на кружок (onTapGesture), оно выполняет функцию, которая хранится в onTap.
                    onTap()
                }
        }
    }


#Preview {
    OptionView(emoji: "💪", habitOption: "Workout", isSelected: false, onTap: {
        print("Tapped in preview")
    })
}
