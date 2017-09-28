//
//  ChatVC.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/22/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
   
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser?.uid
            DatabaseService.instance.getUserData(uid: uid!)
            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        }
        
        MessageService.instance.findAllChannels()
    }
}
