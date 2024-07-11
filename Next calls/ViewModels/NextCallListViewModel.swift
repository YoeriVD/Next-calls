//
//  RemindersListViewModel.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 10/07/2024.
//

import Foundation

class NextCallListViewModel : ObservableObject {
    @Published var calls : [Call]
    private var reminderStore : ReminderStore { ReminderStore.shared }
    
    init(reminders: [Reminder]) {
        self.calls = []
        do{
            self.calls = try extractCalls(reminders: reminders)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    convenience init() {
        self.init(reminders: [])
    }
    
    func fetchReminders() -> NextCallListViewModel {
        Task{
            do {
                try await reminderStore.requestAccess()
                let reminders = try await reminderStore.readAll()
                let calls = try extractCalls(reminders: reminders)
                self.calls = calls
            } catch {
                print(error.localizedDescription)
            }
        }
        return self
    }
    
    func extractCalls(reminders: [Reminder]) throws -> [Call]  {
        return try reminders.compactMap { reminder in
            do {
                return try Call(with: reminder)
            }
            catch ErrorMessages.noPhone {
                return nil
            }
        }
    }
}
