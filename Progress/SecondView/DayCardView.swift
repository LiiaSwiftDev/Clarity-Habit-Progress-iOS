//
//  DayCardView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-10-07.
//

import SwiftUI

struct DayCardView: View {
    
    var days: String
    var numberOfDays: String
    
    // сколько дней было отмечено галочкой перевет значение в Detail View
    @Binding var isMarked: Int
    var totaldays: Int
    
    @State private var checked = false
    
    var body: some View {
        ZStack {
          
            Rectangle()
                .frame(width: 70, height: 80)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 7))
            VStack(alignment: .center, spacing: 0) {
                Text(days)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.bottom, 6)
                
                Text(numberOfDays)
                    .font(.system(size: 15, weight: .bold))
                    .padding(.bottom, 3)
                Button {
                    // make it green when user press and back
                    checked.toggle()
                    
                    if checked {
                        isMarked += 1
                    }
                    else{
                        isMarked -= 1
                    }
                } label: {
                    if checked {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20))
                                .foregroundStyle(Color.green)
                                .background(Color.white)
                              
                    }
                    else {
                        Image(systemName: "circle")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.gray.opacity(0.4))
                                .background(Color.white)
                              
                    }
                }

            } .padding(.vertical, 5)
            
        }
    }
}

#Preview {
    DayCardView(days: "Mon", numberOfDays: "6", isMarked: .constant(0), totaldays: 3)
}
