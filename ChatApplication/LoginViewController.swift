//
//  LoginViewController.swift
//  ChatApplication
//
//  Created by Kalle Teglstrup Wilsen on 25/02/2019.
//  Copyright © 2019 Kalle Teglstrup Wilsen. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
       
    }
    
    
    var dict : [String : AnyObject]!

    @IBAction func loginIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //Creating Facebook button
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        loginButton.readPermissions = ["email"]
        self.view.addSubview(loginButton)
        loginButton.delegate = self
        
        
    }

    func loginButtonData () {
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest?.start(completionHandler: { (connection, result, error) in
            if error != nil {
                print(error!)
            } else {
                print(result!)
            }
        }

    )}

}
