//
//  RegisterViewController.swift
//  
//
//  Created by Kalle Teglstrup Wilsen on 18/03/2019.
//

import UIKit
import FirebaseDatabase
import Firebase



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
    
    func emailCheck(){
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists(){
            for childSnap in snapshot.children.allObjects{
                let snap = childSnap as! DataSnapshot
                self.ref.child("users/" + snap.key + "/email/").observeSingleEvent(of: .value, with: { (emailSnapshot) in
                    
                    print("Test stop 1")
                    let emailCheck = emailSnapshot.value as? String
                    if let actualEmail = emailCheck{

                            if actualEmail == self.email{
                                self.emailExists = true
                            }
                            else if actualEmail != self.email && self.emailExists == false{
                                self.emailExists = false
                            }
                        
                        print("actualEmail: " + actualEmail)
                    }
                    else{
                        print("Test stop 2")
                        self.emailExists = false
                    }
                })
            }
            }
            else{
                print("Error no snapshot")
            }
        })
        
        
        if self.emailExists == false{
            self.createUser()
        }
        else if self.emailExists == true{
            print("Avoid creating user")
        }
    }
    
    func createUser() {
        if password == confirmPassword{
            if firstname != "" || lastname != "" || email != "" || password != "" || confirmPassword != "" {
                
                let childID = self.ref
                    .child("users")
                    .childByAutoId()
                let childIDkey = childID.key!
                
                ref.child("users/" + childIDkey + "/firstname").setValue(firstname)
                ref.child("users/" + childIDkey + "/lastname").setValue(lastname)
                ref.child("users/" + childIDkey + "/email").setValue(email)
                ref.child("users/" + childIDkey + "/password").setValue(password)
                
                
                let userCreateSucces = UIAlertController(title: "ChatAPP", message: "User created!", preferredStyle: UIAlertController.Style.alert)
                userCreateSucces.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default){
                    UIAlertAction in
                    self.performSegue(withIdentifier: "registerSegue", sender: self)
                })
                self.present(userCreateSucces, animated: true, completion: nil)
                
                print("User created succesfully!")
            }
        
        else{
            let userCreateFailMissing = UIAlertController(title: "ChatAPP", message: "User could not be created - Some fields are left empty", preferredStyle: UIAlertController.Style.alert)
            userCreateFailMissing.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
            self.present(userCreateFailMissing, animated: true, completion: nil)
        }
            
        }
        else{
            let userCreateFailPassword = UIAlertController(title: "ChatAPP", message: "User could not be created - Passwords dont match", preferredStyle: UIAlertController.Style.alert)
            userCreateFailPassword.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
            self.present(userCreateFailPassword, animated: true, completion: nil)

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

        createUser()
        
        
 
    }
    
    
    
    
    
    @IBOutlet weak var firstnameText: UITextField!
    
    @IBOutlet weak var lastnameText: UITextField!

    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var confirmPasswordText: UITextField!
}
