//
//  Call+Contact.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import Foundation
extension Call {
    init(with reminder: Reminder, and contact:Contact){
        self.reminder = reminder
        self.phone = contact.phone.number.cleanPhoneNumber()
    }
}
