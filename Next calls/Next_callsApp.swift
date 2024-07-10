//
//  Next_callsApp.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import SwiftUI



func fetchReminders() async -> [Reminder] {
    var reminderStore : ReminderStore { ReminderStore.shared }
    
    do {
        try await reminderStore.requestAccess()
        let reminders = try await reminderStore.readAll()
        return reminders
    } catch {
        print(error.localizedDescription)
    }
    return [
        Reminder(title: "Item 1"),
        Reminder(title: "Item 2"),
        Reminder(title: "Item 3")
    ]
}

var reminders : [Reminder] = []


@main
struct Next_callsApp: App {
    init(){
        Task{
            var rm = await fetchReminders()
            reminders.append(contentsOf: rm)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RemindersListView(reminders: reminders)
        }
    }
}
