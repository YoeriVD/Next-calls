//
//  ContentView.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import SwiftUI

struct RemindersListView: View {
    @StateObject var viewModel : RemindersViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.reminders) {
                item in Text(item.name)
            }
            .navigationTitle("Simple list")
        }
    }
}


#Preview {
    RemindersListView(viewModel: RemindersViewModel(
        start: [
                Item(name: "Item 1"),
                Item(name: "Item 2"),
                Item(name: "Item 3")
            ]
        )
    )
}
