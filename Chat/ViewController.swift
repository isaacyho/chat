//
//  ViewController.swift
//  Chat
//
//  Created by Isaac Ho on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userTextField.text, password: passwordTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil
            {
                println("got user" )
                self.performSegueWithIdentifier("parseSegue", sender: self)
                
                
            } else {
                println( "bad user" )
            }
        }
        
    }
    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        user.username = userTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                println ("success" )
                self.performSegueWithIdentifier("parseSegue", sender: self)
                
                
                
            } else {
                println( "error" )
            }
        }
        
    }

}

