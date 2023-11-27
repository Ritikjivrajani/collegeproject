//
//  MessageModel.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 27/11/23.
//

import Foundation

enum MessageType {
    case text
}

struct Message: Identifiable {
    let id = UUID()
    let sender: String
    let content: String
    let messageType: MessageType
}
