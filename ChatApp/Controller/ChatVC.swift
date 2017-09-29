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

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var chanNameLbl: UILabel!
    @IBOutlet weak var messageTxtLbl: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
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
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        let chanName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        DatabaseService.instance.uploadMsg(channelName: chanName, message: messageTxtLbl.text!, userId: uid!) { (success) in
            if success {
                self.view.endEditing(true)
                self.messageTxtLbl.text = ""
                self.tableView.reloadData()
            }
        }
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func selectedChannelName(_ notif: Notification) {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chanNameLbl.text = "#\(channelName)"
        MessageService.instance.getAllMessagesByChannel(chanName: channelName)
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
        
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
