//
//  MessageCell.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/29/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        userNameLbl.text = "\((message.username)!)"
        messageBodyLbl.text = "\((message.message)!)"
        userImg.image = UIImage(named: "\((message.userAvatar)!)")
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: "\((message.userAvatarColor)!)")
    }

}
