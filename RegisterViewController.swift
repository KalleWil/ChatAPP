//
//  RegisterViewController.swift
//  
//
//  Created by Kalle Teglstrup Wilsen on 18/03/2019.
//

import UIKit
import FirebaseDatabase

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let ref = Database.database().reference()
        
        ref.childByAutoId().setValue(["firstname":"Kalle2"])
        
        //ref.child("someID/firstname").setValue("Kalle")
    }
    


}
