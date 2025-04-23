//
//  ContactStore.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import Foundation
import Contacts

final class ContactStore{
    static let shared = ContactStore()
    private let cnStore = CNContactStore()
    private var contacts: [Contact]?
    var isAvailable: Bool {
        CNContactStore.authorizationStatus(for: .contacts) == .authorized
    }
    
    func requestAccess() async throws {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            return
        case .restricted:
            throw ErrorMessages.accessRestricted
        case .notDetermined:
            let accessGranted = try await cnStore.requestAccess(for: .contacts)
            guard accessGranted else {
                throw ErrorMessages.accessDenied
            }
        case .denied:
            throw ErrorMessages.accessDenied
        case .limited:
            throw ErrorMessages.limited
        @unknown default:
            throw ErrorMessages.unknown
        }
    }
    
    func readAll() async throws -> [Contact] {
        guard self.contacts == nil else {
            return self.contacts!
        }
        guard isAvailable else {
            throw ErrorMessages.accessDenied
        }
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey, CNContactOrganizationNameKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        var contacts = [CNContact]()
        try cnStore.enumerateContacts(with: request){(contact, stop) in
            contacts.append(contact)
        }
        let contactsMapped =  try contacts.compactMap{ c in
            do {
                return try Contact(with: c)
            } catch ErrorMessages.noPhone {
                return nil
            }
        }
        self.contacts = contactsMapped
        return contactsMapped
    }
}

