//
//  RegisterViewController.swift
//  
//
//  Created by Kalle Teglstrup Wilsen on 18/03/2019.
//

import UIKit
import FirebaseDatabase



class RegisterViewController: UIViewController {

    let ref = Database.database().reference()
    var databaseHandle:DatabaseHandle?
    
    var username: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var emailExists: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelRegister(_ sender: UIButton) {
        
        performSegue(withIdentifier: "cancelSegue", sender: self)
        
    }
    
    func emailCheck() {
        databaseHandle = ref.child("users").observe(.value) { (snapshot) in
            for childSnap in snapshot.children.allObjects{
                let snap = childSnap as! DataSnapshot
                self.databaseHandle = self.ref.child("users/" + snap.key + "/email/").observe(.value, with: { (emailSnapshot) in
                    let emailCheck = emailSnapshot.value as? String
                    if let actualEmail = emailCheck{
                        if actualEmail == self.email{
                            self.emailExists = true
                            print("Email exists in database")
                        }
                    }
                })
                
            }
        }
        if emailExists == true{}
        else{
            emailExists = false
        }
    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        username = firstnameText.text! + lastnameText.text!
        firstname = firstnameText.text!
        lastname = lastnameText.text!
        email = emailText.text!
        password = passwordText.text!
        confirmPassword = confirmPasswordText.text!
        
        print("Username: " + username)
        print("Firstname: " + firstname)
        print("Lastname: " + lastname)
        print("Email: " + email)
        print("Password: " + password)
        print("ConfirmPassword: " + confirmPassword)
        
        emailCheck()
        
        if password == confirmPassword{
            if emailExists == !true{
            
            let childID = self.ref
                .child("users")
                .childByAutoId()
            let childIDkey = childID.key!
            
            ref.child("users/" + childIDkey + "/firstname").setValue(firstname)
            ref.child("users/" + childIDkey + "/lastname").setValue(lastname)
            ref.child("users/" + childIDkey + "/email").setValue(email)
            ref.child("users/" + childIDkey + "/password").setValue(password)
            
            print("User created succesfully!")
            }
            else{
                print("ERROR! - Email already exists")
            }
        }
        else{
            print("ERROR! - Passwords dont match")
        }
        
 
    }
    
    
    
    
    
    @IBOutlet weak var firstnameText: UITextField!
    
    @IBOutlet weak var lastnameText: UITextField!

    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var confirmPasswordText: UITextField!
}
