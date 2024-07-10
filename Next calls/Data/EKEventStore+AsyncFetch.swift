//
//  EKEventStore+AsyncFetch.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 10/07/2024.
//

import Foundation
import EventKit

extension EKEventStore {
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) { reminders in
                if let reminders {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: ErrorMessages.failedReadingReminders)
                }
            }
        }
    }
}
