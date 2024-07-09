//
//  Next_callsApp.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import SwiftUI


@main
struct Next_callsApp: App {

    var body: some Scene {
        WindowGroup {
            RemindersListView(viewModel : RemindersViewModel().requestAccess())
        }
    }
}
