//
//  UserVC.swift
//  Targeter
//
//  Created by mac on 11/10/17.
//  Copyright © 2017 Alder. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI

class UserViewController: UIViewController {
    
    // MARK: Properties
    var userID = Auth.auth().currentUser?.uid
    var ref:DatabaseReference!

    // Mark: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var cityAgeLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        // Configure Firebase
        configDatabase()
    }
    
    // MARK: Config firebase
    func configDatabase(){
        ref = Database.database().reference()
        if let userID = userID {
            ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let userName = value?["name"] as? String ?? ""
/*
                        self.nameTextField.text = value?[Constants.UserData.name] as? String ?? ""
                        self.ageTextField.text = value?[Constants.UserData.age] as? String ?? ""
                        self.cityTextField.text = value?[Constants.UserData.city] as? String ?? ""
                        self.aboutTextField.text = value?[Constants.UserData.about] as? String ?? ""
                        //self.nameTextField.text = name
*/
                self.nameLabel.text = userName
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Assist functions
    func configUI() {
    }
    
    // MARK: Actions
    @IBAction func editButton(_ sender: Any) {
    }
    @IBAction func logoutButton(_ sender: Any) {
        do {
            // Trying to sign out from Firebase
            try Auth.auth().signOut()
            _ = navigationController?.popViewController(animated: true)
        } catch {
            print("unable to sign out: \(error)")
        }
        
    }
}
