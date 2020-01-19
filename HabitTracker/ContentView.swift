//
//  ContentView.swift
//  HabitTracker
//
//  Created by Oliver Lippold on 05/01/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddScreen = false
    @ObservedObject var habits = Habits()
    
    var body: some View {
        NavigationView {
            List(habits.habits) { habit in
                NavigationLink(destination: EditHabitView(habits: self.habits,  currentHabit: habit)) {
                    VStack(alignment: .leading, spacing: 2)
                    {
                        Text(habit.name)
                        HStack {
                            Text(habit.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("Habit done: \(habit.activityCount)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
                
                
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddScreen) {
                    AddHabitView(habits: self.habits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
