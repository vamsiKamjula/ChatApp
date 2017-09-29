//
//  MessageService.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/27/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        channels.removeAll()
        Database.database().reference().child("channels").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let name = dictionary["channelName"] as? String
                let description = dictionary["channelDescription"] as? String
                
                let channel = Channel(channelTitle: name, channelDescription: description)
                self.channels.append(channel)
                completion(true)
            }
        }, withCancel: nil)
    }
    
    func getAllMessagesByChannel(chanName: String, completion: @escaping CompletionHandler) {

Database.database().reference().child("channels").child(chanName).child("messages").observe(.childAdded, with: { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                guard let messageBody = data["message"] as? String else { return }
                let username = data["username"] as? String
                let userAvatar = data["userAvatar"] as? String
                let userAvatarColor = data["userAvatarColor"] as? String
                let userId = data["userId"] as? String
                
                let message = Message(message: messageBody, username: username!, userAvatar: userAvatar!, userAvatarColor: userAvatarColor!, userId: userId!)
                self.messages.append(message)
            }
        completion(true)
        }, withCancel: nil)
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
}
