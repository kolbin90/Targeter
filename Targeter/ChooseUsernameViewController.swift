//
//  ChooseUsernameViewController.swift
//  Targeter
//
//  Created by Apple User on 12/5/19.
//  Copyright © 2019 Alder. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ChooseUsernameViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    
    // MARK: Variables
    var success = false
    
    // MARK: Init
    deinit {
        if !success {
            logout()
        }
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        // Set up Navigation controller
        setNavigationController(largeTitleDisplayMode: .never)
        handleTextField()
        // Do any additional setup after loading the view.
    }
    // MARK: Handle textfield
    func handleTextField() {
        usernameTextfield.addTarget(self, action: #selector(ChooseUsernameViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let username = usernameTextfield.text, !username.isEmpty else {
            finishButton.isEnabled = false
            lineView.backgroundColor = .red
            return
        }
        if isValidUsername(input: username) {
            finishButton.isEnabled = true
            Api.user.singleObserveUser(withUsername: username, completion: { (user) in
                DispatchQueue.main.async {
                    self.lineView.backgroundColor = .red
                    self.warningLabel.text = "Username is taken"
                    self.warningLabel.isHidden = false
                    self.finishButton.isEnabled = false
                }
            }) { (error) in
                DispatchQueue.main.async {
                    self.lineView.backgroundColor = .green
                    self.warningLabel.isHidden = true
                    self.finishButton.isEnabled = true
                }
                
            }
        } else {
            self.lineView.backgroundColor = .red
            self.warningLabel.text = "Only letters, underscores and numbers allowed"
            self.warningLabel.isHidden = false
            self.finishButton.isEnabled = false
        }
        
    }
    func isValidUsername(input:String) -> Bool {
        let usernameRegEx = "\\w{1,18}"
        let usernamePred = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: input)
    }
    
    // MARK: Assist methods
    func logout(){
        let manager = LoginManager()
        manager.logOut()
        if let _ = Api.user.currentUser {
            AuthService.firebaseLogOut()
        }
    }
    
    // MARK: Actions
    @IBAction func cancelButton(_ sender: Any) {
        logout()
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func finishButton(_ sender: Any) {
        AuthService.saveNewUserInfo(profileImageUrl: nil, name: nil, username: usernameTextfield.text, email: nil)
        success = true
        self.dismiss(animated: true, completion: nil)
    }
}



