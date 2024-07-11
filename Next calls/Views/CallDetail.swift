//
//  ReminderDetailView.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import SwiftUI

struct CallDetail: View {
    let call: Call
    
    func makeCall() {
        guard let url = call.getPhoneUrl() else { return }
        print("calling " + url.path())
        UIApplication.shared.open(url)
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
        }
        
    }
}

#Preview {
    CallDetail(
        call: Call(
            reminder: Reminder(title: "bellen met +32 477 34 65 89"),
            phone: "+32 477 34 65 89"
        )
    )
}
