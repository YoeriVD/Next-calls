//
//  RemindersViewModel.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import Foundation
import EventKit

struct Item: Identifiable {
    let id = UUID()
    let name: String
}



class RemindersViewModel: ObservableObject {
    @Published var reminders: [Item]
    private let eventStore = EKEventStore();
    
    init(start: [Item]){
        self.reminders = start
    }
    convenience init(){
        self.init(start: [])
    }
    

    func requestAccess() -> RemindersViewModel {
        eventStore.requestFullAccessToEvents { (granted, error) in
            if granted {
                self.fetchReminders()
            } else {
                print("Access to events and reminders denied")
            }
        }
        return self
    }
    func fetchReminders() {
        let predicate = eventStore.predicateForReminders(in: nil)
        eventStore.fetchReminders(matching: predicate) { (reminders) in
            if let reminders = reminders {
                DispatchQueue.main.async {
                    self.reminders = reminders.compactMap { rm in
                        return Item(name: rm.description)
                    }
                }
                
            }
            else {
                DispatchQueue.main.async {
                    self.reminders = []
                }
            }
        }
    }
}
