//
//  CreateAccountVC.swift
//  ChatApp
//
//  Created by vamsi krishna reddy kamjula on 9/23/17.
//  Copyright © 2017 applicationDevelopment. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountVC: UIViewController {

    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAcntPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                if let newUserError = error {
                    print(newUserError.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: UNWIND, sender: nil)
                print("\(user!) !!!")
            })
    }
    
    @IBAction func chooseAvtrPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func genBackgroundColorPressed(_ sender: Any) {
    }
}
