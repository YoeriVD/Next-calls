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
    
    /// The currently selected reminder list name (nil if not set)
    @Published var selectedListName: String {
        didSet {
            defaults.set(selectedListName, forKey: selectedListKey)
        }
    }
    
    private init() {
        // Load saved value or use empty string if not set
        self.selectedListName = defaults.string(forKey: selectedListKey) ?? ""
    }
    
    /// Check if a list has been selected
    var hasSelectedList: Bool {
        !selectedListName.isEmpty
    }
}
