//
//  DataBaseServices.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/27/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataBaseServices {
    
    static let instance = DataBaseServices()
    
    func uploadNewChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let channelReference = ref.child("channels").childByAutoId()
        let values = ["channelName": channelName, "channelDescription": channelDescription]
        
        channelReference.setValue(values) { (error, ref) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            completion(true)
        }
    }
}
