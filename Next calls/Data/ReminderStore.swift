//
//  ReminderStore.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 10/07/2024.
//

import Foundation
import EventKit

final class ReminderStore{
    static let shared = ReminderStore()
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .fullAccess
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            return
        case .restricted:
            throw ErrorMessages.accessRestricted
        case .notDetermined:
            let accessGranted = try await ekStore.requestFullAccessToReminders()
            guard accessGranted else {
                throw ErrorMessages.accessDenied
            }
        case .denied:
            throw ErrorMessages.accessDenied
        case .fullAccess:
            return
        case .writeOnly:
            throw ErrorMessages.accessRestricted
        @unknown default:
            throw ErrorMessages.unknown
        }
        
    }
    
    
    func readAll() async throws -> [Reminder] {
        guard isAvailable else {
            throw ErrorMessages.accessDenied
        }
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekReminders = try await ekStore.reminders(matching: predicate)
        let reminders: [Reminder] = try ekReminders
            .filter{reminder in !reminder.isCompleted }
            .compactMap { ekReminder in
                do {
                    return try Reminder(with: ekReminder)
                }
                catch ErrorMessages.noTitle {
                    return nil
                }
            }
        return reminders
    }
}
