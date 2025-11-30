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
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            
            TextField("Add short comment", text: bindingDay)
                .padding(.horizontal, 25)
                .frame(width: 275, height: 58)
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
