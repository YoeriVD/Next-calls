//
//  ContentView.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import SwiftUI

struct NextCallList: View {
    @Bindable var viewModel : NextCallListViewModel
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.calls) { item in
            //List([Call(reminder: Reminder(title: "test"), phone: "+32471423043")]) { item in
                NavigationLink {
                    CallDetail(call: item, viewModel: viewModel)
                } label :{
                    Text(item.reminder.title)
                }
            }
            .refreshable{
                _ = viewModel.fetchReminders()
            }
            .navigationTitle("Calls")
            .navigationViewStyle(StackNavigationViewStyle())
        } detail: {
            Text("Select")
        }
    }
}

#Preview {
    NextCallList(
        viewModel:NextCallListViewModel(
            reminders : [
                Reminder(title: "Item 1"),
                Reminder(title: "Item 2"),
                Reminder(title: "Item 3"),
                Reminder(title: "Item +32 477 40 30 40"),
                Reminder(title: "Item 0477 40 30 40"),
                Reminder(title: "Item +32477403040"),
                Reminder(title: "Item 0477403040"),
                Reminder(title: "Item 037700304"),
                Reminder(title: "Item 03 770 03 04")
            ],
            contacts: []
        )
    )
}



#Preview {
    NextCallList(viewModel: NextCallListViewModel())
}

