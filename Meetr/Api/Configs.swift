//
//  Configs.swift
//  Meetr
//
//  Created by Christian Mølholt Jensen on 23/11/2020.
//

import Foundation

let serverKey = SERVER_KEY
let fcmUrl = "https://fcm.googleapis.com/fcm/send"
func sendRequestNotification(fromUser: UserModel, toUser: UserModel, message: String, badge: Int) {
    var request = URLRequest(url: URL(string: fcmUrl)!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    
    // Custom data maybe for later user to segue
    let notification: [String: Any] = ["to": "/topics/\(toUser.id)",
                                       "notification": ["body": message,
                                       "sound": "default",
                                       "badge": badge,
                                       "customData": ["userId": fromUser.id,
                                                      "name": fromUser.name,
                                                      "birth": fromUser.birth,
                                                      "profileImageUrl": fromUser.profileImageUrl]
                                       ]
    ]
    
    let data = try! JSONSerialization.data(withJSONObject: notification, options: [])
    request.httpBody = data
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        guard let data = data, error == nil else {
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("HttpUrlResponse \(httpResponse.statusCode)")
            print("Response \(response!)")
        }
        
        if let responseString = String(data: data, encoding: String.Encoding.utf8) {
            print("ResponseString \(responseString)")
        }
    }.resume()
}
