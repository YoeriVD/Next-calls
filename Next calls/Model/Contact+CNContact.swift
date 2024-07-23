//
//  Contact+CNContact.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import Foundation
import Contacts

extension Contact {
    init(with contact: CNContact) throws {
        
        
        indexes = [
            "\(contact.familyName) \(contact.givenName)",
            "\(contact.familyName), \(contact.givenName)",
            "\(contact.givenName) \(contact.familyName)",
            "\(contact.givenName), \(contact.familyName)",
            contact.nickname,
            contact.organizationName
        ].compactMap{index in
            return index.lowercased().trimmingCharacters(in: CharacterSet.whitespaces)
        }.filter{ index in
            return index != "," && index != ""
        }
        
        phone = try Phone(with: contact.phoneNumbers.first?.value)
    }
}


extension Phone {
    init(with phoneNumber : CNPhoneNumber?) throws {
        guard let phoneNumber = phoneNumber else { throw ErrorMessages.noPhone }
        description = phoneNumber.description
        number = phoneNumber.stringValue
    }
}
