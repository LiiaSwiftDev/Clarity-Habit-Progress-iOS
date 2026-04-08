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
    
    // Support email configuration (used in MainView)
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
    
    // Days of week (Mon = 0 ... Sun = 6)
    let days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    // mon-sun in Comment View
    var monday: String = ""
    var tuesday: String = ""
    var wednesday: String = ""
    var thursday: String = ""
    var friday: String = ""
    var saturday: String = ""
    var sunday: String = ""
    
    
    // Format date range (e.g. "September 28 - October 4, 2025")
    func formattedDateRange(from start: Date, to end: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM d"
        
        let startStr = formatter.string(from: start)
        let endStr = formatter.string(from: end)
        
        formatter.dateFormat = "yyyy"
        let yearStr = formatter.string(from: end)
        
        return "\(startStr) - \(endStr), \(yearStr)"
    }
    
    // Progress bar fill color
    func colorProgressBar(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedInside")
        case 0.31..<0.7 : return Color("OrangeInside")
        case 0.7..<100 : return Color("GreenInside")
        default:
            return .gray
        }
    }
    
    // Progress bar stroke color
    func colorStroke(progress: Double) -> Color {
        switch progress {
        case 0..<0.31 : return Color("RedOutside")
        case 0.31..<0.7 : return Color("OrangeOutside")
        case 0.7..<100 : return Color("GreenOutside")
        default:
            return .gray
        }
    }
    
    // Convert progress (0.66 → "66")
    func getPercentage(input: Double) -> String {
        return String(Int(input * 100))
    }
}
