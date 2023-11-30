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
        NavigationView{
            VStack {
                
                VStack{
                    Text("UserName")
                        .font(.title2)
                        .padding(.top, 20)
                        .foregroundColor(.white)
                }
                .frame(width: 400, height: 120)
                .background {
                    Color("newColor")
                }
                .ignoresSafeArea()
                
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
        }
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
