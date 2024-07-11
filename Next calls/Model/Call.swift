//
//  Call.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import Foundation
struct Call: Identifiable {
    let id = UUID()
    let reminder: Reminder
    let phone: String
    func getPhoneUrl() -> URL?{
        return URL(string: "tel://" + phone)
    }
}
