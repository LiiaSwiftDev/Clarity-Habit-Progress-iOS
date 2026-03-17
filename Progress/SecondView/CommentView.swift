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
    
    @Environment(HabitModel.self) var model
    // чтобы сохранять, удалять
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var goal: Goal
    var week: Week
    
    // Хранит какое TextField сейчас активно (куда нажал пользователь).
    @FocusState private var focusedField: DayField?
    
    // Просто имена для каждого поля, чтобы их различать.
    enum DayField: Hashable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    var body: some View {
        
        @Bindable var model = model
        
        ZStack {
            // «Прокрути ScrollView туда, куда я скажу».
            ScrollViewReader { proxy in
                ScrollView {

                    VStack(alignment: .center, spacing: 0) {
                        
                        OneCommentView(day: "Mon", bindingDay: $model.monday)
                        // «Это поле — Monday. Когда на него нажали, запомни это».
                            .focused($focusedField, equals: .monday)
                            .id(DayField.monday)
                            .padding(.top, 30)
                            .onChange(of: model.monday) { oldValue, newValue in
                                model.monday = TextHelper.limitByWidth(model.monday, font: UIFont.systemFont(ofSize: 21, weight: .regular), maxWidth: 250)
                            }
                        
                        OneCommentView(day: "Tue", bindingDay: $model.tuesday)
                            .focused($focusedField, equals: .tuesday)
                            .id(DayField.tuesday)
                            .onChange(of: model.tuesday) { oldValue, newValue in
                                model.tuesday = TextHelper.limitByWidth(model.tuesday, font: UIFont.systemFont(ofSize: 21, weight: .regular), maxWidth: 250)
                            }
                        
                        OneCommentView(day: "Wed", bindingDay: $model.wednesday)
                            .focused($focusedField, equals: .wednesday)
                            .id(DayField.wednesday)
                            .onChange(of: model.wednesday) { oldValue, newValue in
                                model.wednesday = TextHelper.limitByWidth(model.wednesday, font: UIFont.systemFont(ofSize: 21, weight: .regular), maxWidth: 250)
                            }
                        
                        OneCommentView(day: "Thu", bindingDay: $model.thursday)
                            .focused($focusedField, equals: .thursday)
                            .id(DayField.thursday)
                            .onChange(of: model.thursday) { oldValue, newValue in
                                model.thursday = TextHelper.limitByWidth(model.thursday, font: UIFont.systemFont(ofSize: 21, weight: .regular), maxWidth: 250)
                            }
                        
                        OneCommentView(day: "Fri", bindingDay: $model.friday)
                            .focused($focusedField, equals: .friday)
                            .id(DayField.friday)
                            .onChange(of: model.friday) { oldValue, newValue in
                                model.friday = TextHelper.limitByWidth(model.friday, font: UIFont.systemFont(ofSize: 21, weight: .regular), maxWidth: 250)
                            }
                        
                        OneCommentView(day: "Sat", bindingDay: $model.saturday)
                            .focused($focusedField, equals: .saturday)
                            .id(DayField.saturday)
                            .onChange(of: model.saturday) { oldValue, newValue in
                                model.saturday = TextHelper.limitByWidth(model.saturday, font: UIFont.systemFont(ofSize: 21, weight: .regular), maxWidth: 250)
                            }
                        
                        OneCommentView(day: "Sun", bindingDay: $model.sunday)
                            .focused($focusedField, equals: .sunday)
                            .id(DayField.sunday)
                            .onChange(of: model.sunday) { oldValue, newValue in
                                model.sunday = TextHelper.limitByWidth(model.sunday, font: UIFont.systemFont(ofSize: 21, weight: .regular), maxWidth: 250)
                            }
                        
                        
                    }
                    .padding(.horizontal, 30)
                    .background {
                        Color.white
                            .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                    }
                    // «Каждый раз, когда focusedField изменится — выполни код».
                    // oldValue - nil (нечего не выбрано), newValue - выбранный textfield
                    .onChange(of: focusedField, { oldValue, newValue in
                        // proxy — это объект, который умеет управлять прокруткой ScrollView Он позволяет программно прокручивать ScrollView к конкретным элементам
                        if let field = newValue {
                            withAnimation {
                                proxy.scrollTo(field, anchor: .center)
                            }
                        }
                    })
                    .onAppear(perform: {
                        model.monday = week.monday
                        model.tuesday = week.tuesday
                        model.wednesday = week.wednesday
                        model.thursday = week.thursday
                        model.friday = week.friday
                        model.saturday = week.saturday
                        model.sunday = week.sunday
                        
                        TelemetryDeck.signal("Visit Comment View")
                        
                    })
                    .padding(.bottom, 8)
                }
                .safeAreaInset(edge: .bottom) {
                    //
                    Button {
                        // save
                        week.monday = model.monday
                        week.tuesday = model.tuesday
                        week.wednesday = model.wednesday
                        week.thursday = model.thursday
                        week.friday = model.friday
                        week.saturday = model.saturday
                        week.sunday = model.sunday
                        
                        try? context.save()
                        
                        dismiss()
                        
                        TelemetryDeck.signal("Saved comments")
                        
                    } label: {
                        Text("Save")
                            .font(.system(size: 20, weight: .semibold))
                            .frame(maxWidth: 310)
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

