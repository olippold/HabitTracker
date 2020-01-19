//
//  EditHabitView.swift
//  HabitTracker
//
//  Created by Oliver Lippold on 19/01/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import SwiftUI

struct EditHabitView: View {
    @ObservedObject var habits: Habits
    @State var currentHabit: Habit
    
    var body: some View {
        Form {
            Section {
                Text("Description: \(currentHabit.description)")
                Text("Activity Count: \(currentHabit.activityCount)")
            }
            
            Section {
                Button("Log Habit") {
                    self.logHabit()
                }
            }
        }
        .navigationBarTitle(Text(currentHabit.name))
    }
    
    func logHabit() {
        self.currentHabit.activityCount += 1
        habits.updateHabitCount(habit: currentHabit)
    }
}

struct EditHabitView_Previews: PreviewProvider {
    static var previews: some View {
        EditHabitView(habits: Habits(),  currentHabit: Habit())
    }
}
