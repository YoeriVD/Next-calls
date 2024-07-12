//
//  ReminderDetailView.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import SwiftUI

struct CallDetail: View {
    let call: Call
    let viewModel: NextCallListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    func makeCall() {
        guard let url = call.getPhoneUrl() else { return }
        print("calling " + url.path())
        UIApplication.shared.open(url)
    }
    func complete() {
        Task{
            await viewModel.complete(call: call)
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Reminder").font(.title)
            Text(call.reminder.title).font(.subheadline)
            Spacer()
            Button(call.phone, systemImage: "phone", action: makeCall)
                .buttonStyle(BorderedProminentButtonStyle())
                .font(.title)
            Spacer()
            Button("Complete", systemImage: "checkmark", action: complete)
        }
        
    }
}

#Preview {
    CallDetail(
        call: Call(
            reminder: Reminder(title: "bellen met +32 477 34 65 89"),
            phone: "+32 477 34 65 89"
        ),
        viewModel: NextCallListViewModel()
    )
}
