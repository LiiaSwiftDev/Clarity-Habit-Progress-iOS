//
//  DataService.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-03.
//

import Foundation

struct DataService {
    
    func getOptions() -> [Options] {
        
        // 1. путь к файлу
        if let url = Bundle.main.url(forResource: "GoalOptions", withExtension: "json") {
            
            do {
                // 2. прочитать файл
                let data = try Data(contentsOf: url)
                
                // 3. parse json
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode([Options].self, from: data)
                    
                    return result
                }
                catch {
                    print("Couldn't parse file \(error)")
                }
                
            }
            catch {
                print("Couldn't read file \(error)")
            }
            
        }
        return [Options]()
    }
    
}
