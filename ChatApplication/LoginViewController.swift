//
//  LoginViewController.swift
//  ChatApplication
//
//  Created by Kalle Teglstrup Wilsen on 25/02/2019.
//  Copyright © 2019 Kalle Teglstrup Wilsen. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    var dict : [String : AnyObject]!

    @IBAction func loginIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //Creating Facebook button
        let loginButton = LoginButton(readPermissions: [ .publicProfile])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        //If the user is already logged in
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
        
    }

    

    //when login button clicked
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions:[ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
        }
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }
}
