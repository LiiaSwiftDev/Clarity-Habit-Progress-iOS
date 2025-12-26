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
        
        HStack(alignment: .center, spacing:  12) {
            Text(day)
                .foregroundStyle(.black)
                .font(.system(.title3, design: .default).weight(.semibold))
            // «Тексту разрешена ТОЛЬКО ОДНА строка»
                .lineLimit(1)
            // я разрешаю уменшить максимум на 20 проц от исходного размера
                .minimumScaleFactor(0.8)
            // SwiftUI выбирает ОДНО число между 30 и 50 и применяет его ко ВСЕМ строкам, если это возможно.
                .frame(minWidth: 30, maxWidth: 50, alignment: .leading)
            
            TextField("Add short comment", text: bindingDay)
                .foregroundStyle(.black)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .frame(maxWidth: 275)
                .background(Color("Background"))
                .overlay(
                        RoundedRectangle(cornerRadius: 15)
                        // как системная рамка
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                .cornerRadius(15)
            
            // фиксирует размер TextField чтобы он не растягивался, и заполняет лишее пространство
            // [ Ты ] [ Друг ] [ ПОДУШКА ] Диван стал шире → растёт только подушка
            Spacer(minLength: 0)

        }
            .padding(.bottom, 18)
            .padding(.horizontal)
    }
    
}
