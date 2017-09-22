//
//  ChannelVC.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/22/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
}
