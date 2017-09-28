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
}
