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


    // Mark: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        print("UID: \(Auth.auth().currentUser?.uid)")
        if let authName = Auth.auth().currentUser?.email {
            nameLabel.text = authName
        }
    }

    
    // MARK: Actions
    @IBAction func logoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            _ = navigationController?.popViewController(animated: true)
        } catch {
            print("unable to sign out: \(error)")
        }
        
    }
}
