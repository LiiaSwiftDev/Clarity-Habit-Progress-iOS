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
        
        VStack(alignment: .leading, spacing: 10) {
            Text(day)
                .font(.system(size: 20))
                .bold()
            
            HStack {
                TextField("", text: bindingDay)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 22))

            }
        }.padding(.bottom, 20)
    }
    
}
