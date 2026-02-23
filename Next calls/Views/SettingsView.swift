//
//  SettingsView.swift
//  Next calls
//
//  Settings view for configuring app preferences
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var settings = SettingsManager.shared
    @State private var availableLists: [String] = []
    @State private var isLoading = true
    @Environment(\.dismiss) private var dismiss
    
    private var reminderStore: ReminderStore { ReminderStore.shared }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else if availableLists.isEmpty {
                        Text("No reminder lists found")
                            .foregroundStyle(.secondary)
                    } else {
                        Picker("Reminder List", selection: $settings.selectedListName) {
                            ForEach(availableLists, id: \.self) { listName in
                                Text(listName).tag(listName)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                } header: {
                    Text("Task List")
                } footer: {
                    Text("Select which reminder list to use for displaying calls. The app will show incomplete reminders from this list.")
                }
                
                Section {
                    Button("Reset to Default") {
                        settings.resetToDefault()
                    }
                } footer: {
                    Text("Resets the selected list to \"Volgende acties\"")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .task {
                await loadAvailableLists()
            }
        }
    }
    
    private func loadAvailableLists() async {
        do {
            try await reminderStore.requestAccess()
            // Fetch on background thread to avoid UI blocking
            let lists = await Task.detached {
                reminderStore.fetchAllLists()
            }.value
            
            await MainActor.run {
                self.availableLists = lists
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.availableLists = []
                self.isLoading = false
            }
            print("Failed to load reminder lists: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SettingsView()
}
