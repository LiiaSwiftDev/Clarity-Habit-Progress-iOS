//
//  CommentView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-14.
//

import SwiftUI
import SwiftData

struct CommentView: View {
    
    // чтобы сохранять, удалять
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var monday: String = ""
    @State private var tuesday: String = ""
    @State private var wednesday: String = ""
    @State private var thursday: String = ""
    @State private var friday: String = ""
    @State private var saturday: String = ""
    @State private var sunday: String = ""

    var goal: Goal
    var week: Week
   // var haveComments: Week?

    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                
                Spacer()
                
                VStack(spacing: 0) {
                    
                    OneCommentView(day: "Mon", bindingDay: $monday)
                        .padding(.top, 30)
                        .onChange(of: monday) { oldValue, newValue in
                            monday = TextHelper.limitByWidth(monday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                        }
                    
                    OneCommentView(day: "Tue", bindingDay: $tuesday)
                        .onChange(of: tuesday) { oldValue, newValue in
                            tuesday = TextHelper.limitByWidth(tuesday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                        }
                    
                    OneCommentView(day: "Wed", bindingDay: $wednesday)
                        .onChange(of: wednesday) { oldValue, newValue in
                            wednesday = TextHelper.limitByWidth(wednesday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                        }
                    
                    OneCommentView(day: "Thu", bindingDay: $thursday)
                        .onChange(of: thursday) { oldValue, newValue in
                            thursday = TextHelper.limitByWidth(thursday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                        }
                    
                    OneCommentView(day: "Fri", bindingDay: $friday)
                        .onChange(of: friday) { oldValue, newValue in
                            friday = TextHelper.limitByWidth(friday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                        }
                    
                    OneCommentView(day: "Sat", bindingDay: $saturday)
                        .onChange(of: saturday) { oldValue, newValue in
                            saturday = TextHelper.limitByWidth(saturday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                        }
                    
                    OneCommentView(day: "Sun", bindingDay: $sunday)
                        .onChange(of: sunday) { oldValue, newValue in
                            sunday = TextHelper.limitByWidth(sunday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                        }
            
                    Button {
                        // save
                        week.monday = monday
                        week.tuesday = tuesday
                        week.wednesday = wednesday
                        week.thursday = thursday
                        week.friday = friday
                        week.saturday = saturday
                        week.sunday = sunday
                        
                        try? context.save()
                        
                        dismiss()
                        
                    } label: {
                        Text("Save")
                            .font(.system(size: 20, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 46)
                    

                }
                .padding(.horizontal)
                .background {
                    Color.white
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                }
                
            }.onAppear(perform: {
                    monday = week.monday
                    tuesday = week.tuesday
                    wednesday = week.wednesday
                    thursday = week.thursday
                    friday = week.friday
                    saturday = week.saturday
                    sunday = week.sunday
                
            })
            .ignoresSafeArea()
            
        }
        
        }
    }

//#Preview {
  //  CommentView()
//}
