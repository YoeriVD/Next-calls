//
//  SettingsManager.swift
//  Next calls
//
//  Created to manage app settings with persistence
//

import Foundation
import SwiftUI

/// Manager class for app settings with UserDefaults persistence
final class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    
    private let defaults = UserDefaults.standard
    private let selectedListKey = "selectedReminderList"
    private let defaultListName = "Volgende acties"
    
    /// The currently selected reminder list name
    @Published var selectedListName: String {
        didSet {
            defaults.set(selectedListName, forKey: selectedListKey)
        }
    }
    
    private init() {
        // Load saved value or use default
        self.selectedListName = defaults.string(forKey: selectedListKey) ?? defaultListName
    }
    
    /// Reset to default list name
    func resetToDefault() {
        selectedListName = defaultListName
    }
}
