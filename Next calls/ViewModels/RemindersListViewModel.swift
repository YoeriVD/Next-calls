//
//  RemindersListViewModel.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 10/07/2024.
//

import Foundation

class RemindersListViewModel : ObservableObject {
    @Published var reminders : [Reminder]
    private var reminderStore : ReminderStore { ReminderStore.shared }
    
    init(reminders: [Reminder]) {
        self.reminders = reminders
    }
    convenience init() {
        self.init(reminders: [])
    }
    
    func fetchReminders() -> RemindersListViewModel {
        Task{
            do {
                try await reminderStore.requestAccess()
                self.reminders = try await reminderStore.readAll()
            } catch {
                print(error.localizedDescription)
            }
        }
        return self
    }
}
