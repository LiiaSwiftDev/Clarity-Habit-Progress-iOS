//
//  CommentView.swift
//  Progress
//
//  Created by Лия Кошеленко on 2025-11-14.
//

import SwiftUI
import SwiftData
import TelemetryDeck

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
    
    // Хранит какое TextField сейчас активно (куда нажал пользователь).
    @FocusState private var focusedField: DayField?

    // Просто имена для каждого поля, чтобы их различать.
    enum DayField: Hashable {
            case monday, tuesday, wednesday, thursday, friday, saturday, sunday
        }

    var body: some View {
        ZStack {
            // «Прокрути ScrollView туда, куда я скажу».
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        //Spacer()
                        
                        VStack(spacing: 0) {
                            
                            OneCommentView(day: "Mon", bindingDay: $monday)
                            // «Это поле — Monday. Когда на него нажали, запомни это».
                                .focused($focusedField, equals: .monday)
                                .id(DayField.monday)
                                .padding(.top, 30)
                                .onChange(of: monday) { oldValue, newValue in
                                    monday = TextHelper.limitByWidth(monday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                                }
                            
                            OneCommentView(day: "Tue", bindingDay: $tuesday)
                                .focused($focusedField, equals: .tuesday)
                                .id(DayField.tuesday)
                                .onChange(of: tuesday) { oldValue, newValue in
                                    tuesday = TextHelper.limitByWidth(tuesday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                                }
                            
                            OneCommentView(day: "Wed", bindingDay: $wednesday)
                                .focused($focusedField, equals: .wednesday)
                                .id(DayField.wednesday)
                                .onChange(of: wednesday) { oldValue, newValue in
                                    wednesday = TextHelper.limitByWidth(wednesday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                                }
                            
                            OneCommentView(day: "Thu", bindingDay: $thursday)
                                .focused($focusedField, equals: .thursday)
                                .id(DayField.thursday)
                                .onChange(of: thursday) { oldValue, newValue in
                                    thursday = TextHelper.limitByWidth(thursday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                                }
                            
                            OneCommentView(day: "Fri", bindingDay: $friday)
                                .focused($focusedField, equals: .friday)
                                .id(DayField.friday)
                                .onChange(of: friday) { oldValue, newValue in
                                    friday = TextHelper.limitByWidth(friday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                                }
                            
                            OneCommentView(day: "Sat", bindingDay: $saturday)
                                .focused($focusedField, equals: .saturday)
                                .id(DayField.saturday)
                                .onChange(of: saturday) { oldValue, newValue in
                                    saturday = TextHelper.limitByWidth(saturday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                                }
                            
                            OneCommentView(day: "Sun", bindingDay: $sunday)
                                .focused($focusedField, equals: .sunday)
                                .id(DayField.sunday)
                                .onChange(of: sunday) { oldValue, newValue in
                                    sunday = TextHelper.limitByWidth(sunday, font: UIFont.systemFont(ofSize: 17, weight: .regular), maxWidth: 225)
                                }
                            
                            
                        }
                        .padding(.horizontal, 30)
                        .background {
                            Color.white
                                .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        }
                        // «Каждый раз, когда focusedField изменится — выполни код».
                        .onChange(of: focusedField) { field in
                            // Когда поле фокусируется, скроллим к нему
                            if let field = field {
                                withAnimation {
                                    proxy.scrollTo(field, anchor: .center)
                                }
                            }
                        }
                        
                    }.onAppear(perform: {
                        monday = week.monday
                        tuesday = week.tuesday
                        wednesday = week.wednesday
                        thursday = week.thursday
                        friday = week.friday
                        saturday = week.saturday
                        sunday = week.sunday
                        
                        TelemetryDeck.signal("Visit Comment View")
                        
                    })
                    .padding(.bottom, 8)
                    //.ignoresSafeArea(.keyboard)
                }
                .safeAreaInset(edge: .bottom) {
                    //
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
                        
                        TelemetryDeck.signal("Saved comments")
                        
                    } label: {
                        Text("Save")
                            .font(.system(size: 20, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
            }
        }
        
        }
    }

//#Preview {
  //  CommentView()
//}
