//
//  OneCommentView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-17.
//

import SwiftUI

struct OneCommentView: View {
    
    var day: String
    var bindingDay: Binding<String>
   // var buttonAction: () -> Void
    
    var body: some View {
        
        HStack {
            Text(day)
                .foregroundStyle(.black)
                .font(.system(.title3, design: .default).weight(.semibold))
            // «Тексту разрешена ТОЛЬКО ОДНА строка»
                .lineLimit(1)
            // я разрешаю уменшить максимум на 20 проц от исходного размера
                .minimumScaleFactor(0.8)

            Spacer()
            
            TextField("Add short comment", text: bindingDay)
                .foregroundStyle(.black)
                .padding(.horizontal, 25)
              //  .frame(width: 275, height: 58)
                .frame(minHeight: 50)
                .frame(maxWidth: 275)
                .background(Color("Background"))
                .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        // как системная рамка
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                .cornerRadius(15)

        }
            .padding(.bottom, 18)
            .padding(.horizontal)
    }
    
}
