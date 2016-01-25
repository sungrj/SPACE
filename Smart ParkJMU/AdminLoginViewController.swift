//
//  AdminLoginViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 1/24/16.
//  Copyright © 2016 Riley Sung. All rights reserved.
//

import UIKit

class AdminLoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var usernameOrEmailInputTextField: UITextField!
    @IBOutlet weak var passwordInputTextField: UITextField!
    
    @IBOutlet weak var incorrectUsernameOrPasswordLabel: UILabel!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // Temporary username and passwords
    
    let correctUsername = "sungrj"
    let correctPassword = "hello"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordInputTextField.delegate = self
        self.usernameOrEmailInputTextField.delegate = self
        
        incorrectPasswordLabel.hidden = true
        incorrectUsernameOrPasswordLabel.hidden = true
        
        loginButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func didPressLoginButton(sender: AnyObject) {
        
        if checkAccountCredentials() == true {
            
            performSegueWithIdentifier("segueToAdminLotsView", sender: nil)
        
            globalVar.loggedIn = true
            
        }
        
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        
        userText.resignFirstResponder()
        
        return true;
    
    }
    
    
    func checkAccountCredentials() -> Bool {
        
        if usernameOrEmailInputTextField.text!.isEmpty {
            
            incorrectUsernameOrPasswordLabel.text = "Please enter your username or email."
            incorrectUsernameOrPasswordLabel.hidden = false
            
        } else if usernameOrEmailInputTextField.text! != correctUsername {
            
            incorrectUsernameOrPasswordLabel.text = "Username or email doesn't exist."
            incorrectUsernameOrPasswordLabel.hidden = false
            
        }
        
        if usernameOrEmailInputTextField.text == correctUsername {
            
            incorrectUsernameOrPasswordLabel.hidden = true
            
        }
        
        if passwordInputTextField.text!.isEmpty {
            
            incorrectPasswordLabel.text = "Please enter your password."
            incorrectPasswordLabel.hidden = false
            
        } else if passwordInputTextField.text != correctPassword {
            
            incorrectPasswordLabel.text = "Password is incorrect."
            incorrectPasswordLabel.hidden = false
            
        }
        
        if passwordInputTextField.text == correctPassword {
            
            incorrectPasswordLabel.hidden = true
            
        }
        
        if (usernameOrEmailInputTextField.text == correctUsername) &&
            (passwordInputTextField.text == correctPassword) {
                
                incorrectPasswordLabel.hidden = true
                incorrectUsernameOrPasswordLabel.hidden = true
                
                return true
                
        }
        
        return false
        
    }
    
    
}
