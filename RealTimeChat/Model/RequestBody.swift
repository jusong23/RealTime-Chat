//
//  RequestBody.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/21.
//

import Foundation

// MARK: - RequestBody
struct RequestBody: Codable {
    let message: Message_
}

// MARK: - Message
struct Message_: Codable {
    let token: String
    let notification: Notification
}

// MARK: - Notification
struct Notification: Codable {
    let body, title: String
}
