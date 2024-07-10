//
//  ContentView.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import SwiftUI

struct RemindersListView: View {
    var reminders : [Reminder]
   
    var body: some View {
        NavigationView {
            List(reminders) {
                item in Text(item.title)
            }
            .navigationTitle("Simple list")
        }
    }
}


#Preview {
    RemindersListView(reminders: [
                Reminder(title: "Item 1"),
                Reminder(title: "Item 2"),
                Reminder(title: "Item 3")
            ]
        )
}
