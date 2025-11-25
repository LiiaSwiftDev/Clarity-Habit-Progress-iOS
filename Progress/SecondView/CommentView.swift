//
//  CommentView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-14.
//

import SwiftUI

struct CommentView: View {
    
    @State var monday: String = ""
    @State var tuesday: String = ""
    @State var wednesday: String = ""
    @State var thursday: String = ""
    @State var friday: String = ""
    @State var saturday: String = ""
    @State var sunday: String = ""
    
    var body: some View {
        ZStack {

            Color("Background")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {

                HStack {
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        ZStack {
                            Capsule()
                                .frame(width: 70, height: 35)
                            
                            Text("Save")
                                .foregroundStyle(Color.white)
                                .bold()
                            
                        }
                        
                        
                    }
                }
                
                Text("Comments")
                    .bold()
                    .font(.system(size: 37))
                    .padding(.bottom, 10)
                    
                 
                OneCommentView(day: "Monday", bindingDay: $monday)
                
                OneCommentView(day: "Tuesday", bindingDay: $tuesday)
                
                OneCommentView(day: "Wednesday", bindingDay: $wednesday)
                
                OneCommentView(day: "Thursday", bindingDay: $thursday)
                
                OneCommentView(day: "Friday", bindingDay: $friday)
                
                OneCommentView(day: "Saturday", bindingDay: $saturday)
                
                OneCommentView(day: "Sunday", bindingDay: $sunday)
                    
                } .padding()
                
            
        }
        
        }
    }

#Preview {
    CommentView()
}
