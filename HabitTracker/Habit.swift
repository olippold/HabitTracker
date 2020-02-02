//
//  Habit.swift
//  HabitTracker
//
//  Created by Oliver Lippold on 05/01/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable {
    
    let id = UUID()
    var name: String = ""
    var description: String = ""
    var activityCount = 0
    
    mutating func logHabit() {
        activityCount += 1
    }
}

class Habits: ObservableObject {
    
    @Published var habits = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: habits) {
                self.habits = decoded
                return
            }
        }
        
        self.habits = []
    }
    
    func updateHabitCount(habit: Habit) {
        guard let index = habits.firstIndex(where: {$0.id == habit.id}) else { return }
        
        habits[index].activityCount += 1
    }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
    
}
