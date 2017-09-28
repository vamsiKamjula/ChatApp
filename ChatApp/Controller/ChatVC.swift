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
    @IBOutlet weak var chanNameLbl: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
   
        NotificationCenter.default.addObserver(self, selector: #selector(selectedChannelName(_:)), name: NOTIF_SELECTED_CHANNEL, object: nil)
        
        
        if Auth.auth().currentUser != nil {
            let uid = Auth.auth().currentUser?.uid
            DatabaseService.instance.getUserData(uid: uid!)
            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        } else {
            chanNameLbl.text = "Please Log In"
            MessageService.instance.clearChannels()
        }
    }
    
    @objc func selectedChannelName(_ notif: Notification) {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chanNameLbl.text = "#\(channelName)"
    }
    
}
