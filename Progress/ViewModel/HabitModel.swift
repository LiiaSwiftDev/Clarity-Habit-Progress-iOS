//
//  HabitModel.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-17.
//

import Foundation
import SwiftUI

@Observable
class HabitModel {
    
    // @State — чтобы можно было менять email прямо в приложении. in main view
    var email = SupportEmail(toAddress: "app.team.liia@gmail.com",
                             subject: "Support Email",
                             messageHeader: "Please describe your issue below")
    
    // Show sheet in main view (to add/edit habit)
    var newGoal: Goal?
    
    // TextField in AddNewGoalView
    var text: String = ""
    // confirmation to delete habit in AddNewGoalView
    var showConfirmation: Bool = false
    // Default 1 times per week in AddNewGoalView
    var selectedOption = 1
    // All options for times per week in AddNewGoalView
    let options = [1, 2, 3, 4, 5, 6, 7]
    var service = DataService()
    // Chosen habit in AddNewGoalView
    var selectedGoal: Options?
    // All emoji and options in AddNewGoalView
    var displayOptions = [Options]()
    
    
    // Show add week view in Detail view
    var showSheet = false
    // Show comment view in Detail view
    var showSheetComment = false
    // Chosen week to delete
    var weekToDelete: Week? = nil
    // Show window to double check if user want to delete week (Detail view)
    var showAlert: Bool = false
    // The week selected for adding comments (Detail view)
    var selectedWeek: Week?
    
    // Это массив названий дней недели, чтобы знать, что показывать на экране. mon - 0, tue - 1... и т.д. (Week Card View)
    let days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    // mon-sun in Comment View
    var monday: String = ""
    var tuesday: String = ""
    var wednesday: String = ""
    var thursday: String = ""
    var friday: String = ""
    var saturday: String = ""
    var sunday: String = ""
    
    
    // Функция делает текст дату красивой до 2025-09-28 и 2025-10-04, после September 28 - October 4, 2025
    // Внешнее имя    from, to    видно при вызове функции
    // Внутреннее имя    start, end    видно внутри функции
    func formattedDateRange(from start: Date, to end: Date) -> String {
        // Мы создаём помощника по имени formatter. Этот помощник умеет превращать дату в текст. (Например, из числа делает слово “September 28”.)
        let formatter = DateFormatter()
        // Мы говорим помощнику, на каком языке он должен писать. "en_US" — значит “американский английский”. поэтому месяц будет написан September, а не сентябрь.
        formatter.locale = Locale(identifier: "en_US")
        // Мы говорим, в каком виде писать дату. "MMMM d" — это шаблон: MMMM = название месяца (например, September); d = день числа (например, 4). Вместе получится September 4.
        formatter.dateFormat = "MMMM d"
        
        //  Мы берём первую дату (start) И просим помощника превратить её в текст. Теперь startStr = например "September 28".
        let startStr = formatter.string(from: start)
        // То же самое, но для второй даты (end). Теперь endStr = например "October 4".
        let endStr = formatter.string(from: end)
        
        // Мы снова говорим помощнику: “Теперь напиши только год.” в таком так виде
        formatter.dateFormat = "yyyy"
        // Мы просим написать год из даты end (из конца недели). Теперь yearStr = "2025".
        let yearStr = formatter.string(from: end)
        
        // получаем "September 28 - October 4, 2025"
        return "\(startStr) - \(endStr), \(yearStr)"
    }
    
    func colorProgressBar(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedInside")
        case 0.31..<0.7 : return Color("OrangeInside")
        case 0.7..<100 : return Color("GreenInside")
        default:
            return .gray
        }
    }
    
    func colorStroke(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedOutside")
        case 0.31..<0.7 : return Color("OrangeOutside")
        case 0.7..<100 : return Color("GreenOutside")
        default:
            return .gray
        }
    }
    
    func getPercentage(input: Double) -> String {
        // 0.66 * 100 = 66.0, Int(66.0) = 66
        return String(Int(input * 100))
    }
    
}
