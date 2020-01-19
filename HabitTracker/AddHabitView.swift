//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Oliver Lippold on 05/01/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    @State private var name = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name of habit", text: $name)
                TextField("Description of habit", text: $description)
                Button("Save") {
                    // add the habit
                    let item = Habit(name: self.name, description: self.description, activityCount: 0)
                    self.habits.addHabit(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Add Habit")
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
