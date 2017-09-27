//
//  AuthService.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/24/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import Foundation
import FirebaseDatabase

class AuthService {
    
    static let instance = AuthService()
 
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
}
