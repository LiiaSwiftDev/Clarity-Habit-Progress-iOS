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
    var buttonAction: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(day)
                .bold()
            HStack {
                TextField("Enter a comment", text: bindingDay)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 20)
                
                Button("Save") {
                    buttonAction()
                }
                .buttonStyle(.borderedProminent)
            }
        }.padding(.bottom, 20)
    }
    
}
