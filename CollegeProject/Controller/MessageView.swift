//
//  MessageView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 27/11/23.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    var body: some View {
        HStack {
            if message.sender == "You" {
                Spacer()
            }

            switch message.messageType {
            case .text:
                Text(message.content)
                    .padding(10)
                    .background(message.sender == "You" ? Color.blue : Color.white)
                    .foregroundColor(message.sender == "You" ? .white : .black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: message.sender == "You" ? 0 : 1)
                    )
            }

            if message.sender != "You" {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MessageView(message: Message(sender: "you", content: "123-456-789", messageType: .text))
}
