//
//  Call+Reminder.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import Foundation
extension Call {
    init(with reminder: Reminder) throws {
        guard let phone = extractPhoneNumber(from: reminder.title) else {
            throw ErrorMessages.noPhone
        }
        self.reminder = reminder
        self.phone = phone.cleanPhoneNumber()
    }
}

func extractPhoneNumber(from text: String) -> String? {
    let pattern = #"\+?\d{2,3} ?(?:\d{1,3} ?)?(?:\d{2,3} ?){2,4}\d{2,3}|0 ?\d ?\d{2,3} ?\d{2,3} ?\d{2,3}|\d{3,4} ?\d{3} ?\d{2} ?\d{2}"#
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(text.startIndex..<text.endIndex, in: text)
    
    if let match = regex?.firstMatch(in: text, options: [], range: range) {
        if let phoneRange = Range(match.range, in: text) {
            return String(text[phoneRange])
        }
    }
    
    return nil
}
