//
//  AddChannelVC.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/27/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    @IBAction func createChannelPressed(_ sender: Any) {
        guard let chanName = nameTxt.text, nameTxt.text != "" else { return }
        guard let chanDesc = descriptionTxt.text, descriptionTxt.text != "" else { return }
        
        DatabaseService.instance.uploadNewChannel(channelName: chanName, channelDescription: chanDesc) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap))
        bgView.addGestureRecognizer(closeTouch)
    }

    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
}
}
