//
//  RemindersListViewModel.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 10/07/2024.
//

import Foundation
import Combine

@Observable class NextCallListViewModel {
    var calls : [Call]
    private var contacts : [Contact] = []
    private var reminderStore : ReminderStore { ReminderStore.shared }
    private var contactStore : ContactStore { ContactStore.shared }
    private var settingsManager : SettingsManager { SettingsManager.shared }
    private var cancellables = Set<AnyCancellable>()
    
    init(reminders: [Reminder], contacts: [Contact]) {
        self.calls = []
        do{
            self.contacts = contacts
            self.calls = (try extractInlinePhoneNumbers(reminders: reminders)) + (try matchContacts(reminders: reminders))
        }
        catch{
            print(error.localizedDescription)
        }
        
        // Listen for settings changes
        setupSettingsObserver()
    }
    convenience init() {
        self.init(reminders: [], contacts: [])
    }
    
    private func setupSettingsObserver() {
        settingsManager.$selectedListName
            .dropFirst() // Skip the initial value
            .sink { [weak self] _ in
                // Refresh when list selection changes
                guard let self = self else { return }
                Task {
                    _ = await MainActor.run {
                        self.fetchReminders()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchReminders()-> NextCallListViewModel{ return fetchReminders{} }
    func fetchReminders(completion: @escaping ()-> Void) -> NextCallListViewModel {
        Task{
            do {
                try await reminderStore.requestAccess()
                let reminders = try await reminderStore.readAll()
                try await contactStore.requestAccess()
                self.contacts = try await contactStore.readAll()
                let identifiedContacts = try matchContacts(reminders: reminders)
                let inlineNumbers = try extractInlinePhoneNumbers(reminders: reminders)
                
                let calls = identifiedContacts + inlineNumbers
                DispatchQueue.main.async{
                    self.calls = calls
                    completion()
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        return self
    }
    
    func extractInlinePhoneNumbers(reminders: [Reminder]) throws -> [Call]  {
        return try reminders.compactMap { reminder in
            do {
                return try Call(with: reminder)
            }
            catch ErrorMessages.noPhone {
                return nil
            }
        }
    }
    
    func matchContacts(reminders: [Reminder]) throws -> [Call]{
        return self.contacts.compactMap{ contact in
            return reminders.compactMap{ reminder in
                for index in contact.indexes {
                    if reminder.title.lowercased().contains(index.lowercased()){
                        return Call(with: reminder, and: contact)
                    }
                }
                return nil
            }
        }
        .reduce([], +)
    }
    
    func complete(call: Call) async {
        do{
            try await reminderStore.complete(reminder: call.reminder)
            let index = self.calls.firstIndex{ listItem in
                listItem.id == call.id
            }
            guard let index else {return}
            DispatchQueue.main.async{
                self.calls.remove(at: index);
            }
        }
        catch{
            return
        }
    }
}
