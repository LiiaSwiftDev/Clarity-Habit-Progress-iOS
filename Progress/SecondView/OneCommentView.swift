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
    
    var body: some View {
        
        HStack(alignment: .center, spacing:  12) {
            // Day label
            
            Text(day)
                .foregroundStyle(.black)
                .font(.system(.title3, design: .default).weight(.semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .frame(minWidth: 30, maxWidth: 50, alignment: .leading)
            
            // Comment input field
            TextField("Add short comment", text: bindingDay)
                .foregroundStyle(.black)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .frame(maxWidth: 275)
                .background(Color("Background"))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .cornerRadius(15)
            
            // Fill remaining space
            Spacer(minLength: 0)
        }
        .padding(.bottom, 18)
        .padding(.horizontal)
    }
    
}
