//
//  AuthService.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/24/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AuthService {
    
    static let instance = AuthService()
 
    func userSignUp(name: String, email: String, pass: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        Auth.auth().createUser(withEmail: email, password: pass, completion: { (user: User?, error) in
            if let createUserError = error {
                print(createUserError.localizedDescription)
                return
            }
            
            guard let uid = user?.uid else { return }
            
            let ref = Database.database().reference(fromURL: "https://chattychat-97d2a.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email, "avatarName": avatarName, "avatarColor": avatarColor]
            userReference.updateChildValues(values, withCompletionBlock: { (databaseErr, ref) in
                if databaseErr != nil {
                    print((databaseErr?.localizedDescription)!)
                    return
                }
                UserDataService.instance.setUserData(id: uid, color: avatarColor, avatarName: avatarName, email: email, name: name)
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            })
        })
    }
    
    func userSignIn(email: String, pass: String, completion: @escaping CompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, loginError) in
            if loginError != nil {
                print((loginError?.localizedDescription)!)
                return
            }
            
            guard let uid = user?.uid else { return }
            
            DatabaseService.instance.getUserData(uid: uid)
            NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
            completion(true)
        }
    }
}
