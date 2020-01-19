//
//  Habit.swift
//  HabitTracker
//
//  Created by Oliver Lippold on 05/01/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable {
    
    /*enum CodingKeys: CodingKey {
        case id, name, description, activityCount
    } */
    
    let id = UUID()
    var name: String = ""
    var description: String = ""
    var activityCount = 0
    
    mutating func logHabit() {
        activityCount += 1
    }
    
    /*init() { }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        activityCount = try container.decode(Int.self, forKey: .activityCount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(activityCount, forKey: .activityCount)
    } */
}

class Habits: ObservableObject {
    enum CodingKeys: CodingKey {
        case habits
    }
    
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
    
    /*required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        habits = try container.decode([Habit].self, forKey: .habits)
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(habits, forKey: .habits)
    } */
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
    
}
