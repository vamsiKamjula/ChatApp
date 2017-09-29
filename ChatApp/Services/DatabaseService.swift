//
//  DatabaseService.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/28/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseService {
    
    static let instance = DatabaseService()
    
    func getUserData(uid: String) {
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                guard let name = dictionary["name"] as? String else { return }
                guard let email = dictionary["email"] as? String else { return }
                guard let avatarName = dictionary["avatarName"] as? String else { return }
                guard let avatarColor = dictionary["avatarColor"] as? String else { return }
                
                UserDataService.instance.setUserData(id: uid, color: avatarColor, avatarName: avatarName, email: email, name: name)
            }
        }, withCancel: nil)
    }
    
        
    func uploadNewChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let channelReference = ref.child("channels").child(channelName)
        let values = ["channelName": channelName, "channelDescription": channelDescription]
        
        channelReference.setValue(values) { (error, ref) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            completion(true)
        }
    }
    
    func uploadMsg(channelName: String, message: String, userId: String, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let msgReference = ref.child("channels").child(channelName).child("messages").childByAutoId()
        let values = ["message": message, "userAvatar": UserDataService.instance.avatarName, "userAvatarColor": UserDataService.instance.avatarColor, "username": UserDataService.instance.name, "userId": userId]
        
        msgReference.setValue(values) { (error, ref) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            completion(true)
        }
    }
}
