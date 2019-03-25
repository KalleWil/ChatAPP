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
    
    var username: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //ref.childByAutoId().setValue(["firstname":"Kalle2"])
        
        //ref.child("someID/firstname").setValue("Kalle")
    }

    @IBAction func cancelRegister(_ sender: UIButton) {
        
        performSegue(withIdentifier: "cancelSegue", sender: self)
        
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
        
        if password == confirmPassword {
            //ref.childByAutoId().setValue(["firstname":firstname])
            
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
            print("ERROR! - Passwords dont match")
        }
        
 
    }
    
    
    
    @IBOutlet weak var firstnameText: UITextField!
    
    @IBOutlet weak var lastnameText: UITextField!

    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var confirmPasswordText: UITextField!
}
