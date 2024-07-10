//
//  Messages.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 10/07/2024.
//

import Foundation
enum ErrorMessages: LocalizedError {
    
    
    case failedReadingReminders
    case accessDenied
    case accessRestricted
    case noTitle
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .failedReadingReminders:
            return NSLocalizedString(
                "Failed to read reminders.", comment: "failed reading reminders error description")
            
        case .accessDenied:
            return NSLocalizedString(
                "The app doesn't have permission to read reminders.",
                comment: "access denied error description")
        case .accessRestricted:
                   return NSLocalizedString(
                       "This device doesn't allow access to reminders.",
                       comment: "access restricted error description")
        case .noTitle:
                   return NSLocalizedString(
                       "This reminder does not have a title.",
                       comment: "Unable to determine if it is about a call.")
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "unknown error description")
        }
        
    }
}
