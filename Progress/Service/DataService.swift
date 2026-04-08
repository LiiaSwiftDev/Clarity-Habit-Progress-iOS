//
//  DataService.swift
//  Progress
//
//  Created by Лия Кошеленко on 2026-03-03.
//

import Foundation

struct DataService {
    
    // Load goal options from local JSON file
    func getOptions() -> [Options] {
        
        // 1. Get file URL from bundle
        if let url = Bundle.main.url(forResource: "GoalOptions", withExtension: "json") {
            
            do {
                // 2. Read file data
                let data = try Data(contentsOf: url)
                
                // 3. Parse json
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
