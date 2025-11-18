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
            
            VStack(alignment: .center) {
                
                Text("Add Comments")
                    .bold()
                    .font(.system(size: 25))
                    .padding(.bottom, 20)
                    
                 
                OneCommentView(day: "Monday", bindingDay: $monday) {
                    // save
                }
                
                OneCommentView(day: "Tuesday", bindingDay: $tuesday) {
                    // save
                }
                
                OneCommentView(day: "Wednesday", bindingDay: $wednesday) {
                    // save
                }
                
                OneCommentView(day: "Thursday", bindingDay: $thursday) {
                    // save
                }
                
                OneCommentView(day: "Friday", bindingDay: $friday) {
                    // save
                }
                
                OneCommentView(day: "Saturday", bindingDay: $saturday) {
                    // save
                }
                
                OneCommentView(day: "Sunday", bindingDay: $sunday) {
                    // save
                }
                    
                } .padding()
            
        }
        
        }
    }

#Preview {
    CommentView()
}
