//
//  SignInViewController.swift
//  Targeter
//
//  Created by Apple User on 12/3/19.
//  Copyright © 2019 Alder. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var facebookButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookButton.delegate = self
        facebookButton.readPermissions = ["public_profile", "email"]
        
        hideKeyboardWhenTappedAround()
        // Set up Navigation controller
        setNavigationController()
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SignInViewController: FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
       // print(credential)
        ProgressHUD.show("Loading...")
        Auth.auth().signIn(with: credential) { (result, error) in
            if let result = result {
                print(result)
            }
            if let error = error {
                print(error)
            }
            
            self.fatchFacebookUser(completion: { (dict) in
                let user = UserModel.transformFaceBookDataToUser(dict: dict)
                let chooseUsernameVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ChooseUsernameViewController") as! ChooseUsernameViewController
                AuthService.saveNewUserInfo(profileImageUrl: user.imageURLString, name: user.name, username: user.email)
                ProgressHUD.dismiss()
                self.show(chooseUsernameVC, sender: nil)
                //ProgressHUD.dismiss()
            })
            
            //self.dismiss(animated: true, completion: nil)

        }
        return
    }
    
    func fatchFacebookUser(completion: @escaping  ([String: Any]) -> Void) {
        AuthService.getUserInfoDictionaryFromFacebook { (dict) in
            completion(dict)            
        }
    }
}

