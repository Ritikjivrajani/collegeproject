//
//  ChatScreen.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var messages: [Message] = []
    @State private var newMessage = ""
    @State private var isKeyboardHidden = true

    var body: some View {
        VStack {
            // Display Messages
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(messages) { message in
                        MessageView(message: message)
                    }
                }
            }
            .padding()

            // Input TextField and Send Button
            HStack {
                TextField("Type a message...", text: $newMessage, onEditingChanged: { editing in
                    isKeyboardHidden = !editing
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(8)

                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.accentColor)
                }
                .padding(8)
            }
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding()
            .gesture(
                DragGesture().onChanged { gesture in
                    if gesture.translation.height > 0 && !isKeyboardHidden {
                        // Swipe down detected, dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            )
        }
        .navigationTitle("Chat")
    }

    func sendMessage() {
        guard !newMessage.isEmpty else { return }

        let newMessageObject = Message(sender: "You", content: newMessage, messageType: .text)
        messages.append(newMessageObject)

        // Clear the input field
        newMessage = ""

        // Simulate receiving a message after sending
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let receivedMessage = Message(sender: "Friend", content: "Hello! 😊", messageType: .text)
            self.messages.append(receivedMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum MessageType {
    case text
}

struct Message: Identifiable {
    let id = UUID()
    let sender: String
    let content: String
    let messageType: MessageType
}

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