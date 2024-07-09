//
//  ContentView.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import SwiftUI

struct RemindersListView: View {
    let items : [Item]
    
    var body: some View {
        NavigationView {
            List(items) {
                item in Text(item.name)
            }
            .navigationTitle("Simple list")
        }
    }
}

#Preview {
    RemindersListView(items: [
        Item(name: "Item 1"),
        Item(name: "Item 2"),
        Item(name: "Item 3")
    ])
}
