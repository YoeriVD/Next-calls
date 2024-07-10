//
//  Reminder+EKReminder.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 10/07/2024.
//

import Foundation
import EventKit

extension Reminder {
    init(with ekReminder: EKReminder) throws {
        guard let title = ekReminder.title else {
            throw ErrorMessages.noTitle
        }
        self.title = title
    }
}
