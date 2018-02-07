//
//  kevinFirebaseApp.swift
//  kevin1
//
//  Created by ios246 on 2018/1/31.
//  Copyright © 2018年 ios135. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class kevinFirebaseApp: UIViewController {
    var ref: DatabaseReference!
    
    
 
    @IBAction func firbase(_ sender: UIButton) {
        
        
        
        Auth.auth().createUser(withEmail: "kevin@abc.vcm", password: "kenken") { (user, error) in
            // ...
            print("user")
            if let error = error{
                print(error.localizedDescription)
                
            }
        }
        Auth.auth().signIn(withEmail:"kevin@abc.vcm",password: "kenken"){ (user, error) in
            // ... }
            if let user = user{
           let uid = user.uid
           let email = user.email
                print("uid = \(uid) email = \(String(describing: email))")
                self.ref.child("shop").child(user.uid).setValue(["shoprname": "shoprname"])
                self.ref.child("users/\(user.uid)/username").setValue("username")
                self.ref.child("users/\(user.uid)/seername").setValue("seename")
            
        }
    }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

