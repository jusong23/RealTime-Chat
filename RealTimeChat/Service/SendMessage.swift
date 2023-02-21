//
//  SendMessage.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/21.
//

import Foundation
import UIKit

class SendMessage {
    func sendPostRequest(token: String, body: String, title: String) {
        let body = RequestBody(message: Message_(token: token, notification: Notification(body: body, title: title)))

        let encoder = JSONEncoder()

        guard let url = URL(string: "https://fcm.googleapis.com/v1/projects/realtime-chat-90e97/messages:send") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer ya29.a0AVvZVsp_NuYtjF6Qs16UpRSfOpLW6Ah8-MRzO_ce4BkXFiAD2Lxa4VkyaRZTtCilUVoNZZ3SEsyOnASpZpaJqzSJ5j_CuKhFGM5-o_ePfaJAIo7Of8XqkB2rOu_G22mcYrkB8ci6uegfl-lk-jW3xb9pEgHtaCgYKAWESARASFQGbdwaIDFb8T5lqojNsL1gzAijUfg0163", forHTTPHeaderField: "Authorization") //MARK: API의 헤더 - 1시간마다 만료
        request.httpMethod = "POST"
        request.httpBody = try? encoder.encode(body)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                return
            }

            // 요청 성공 여부
            guard let data = data, let str = String(data: data, encoding: .utf8) else {
                fatalError("Invalid Data")
            }

        }
        task.resume()
    }
}
