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
    @IBOutlet weak var incorrectCredentionalLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // Temporary username and passwords
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordInputTextField.delegate = self
        self.usernameOrEmailInputTextField.delegate = self
        
        incorrectPasswordLabel.hidden = true
        incorrectUsernameOrPasswordLabel.hidden = true
        incorrectCredentionalLabel.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }    

    
    @IBAction func didPressLoginButton(sender: AnyObject) {
        
        let usernameInput = usernameOrEmailInputTextField.text
        let passwordInput = passwordInputTextField.text
        
        if login(usernameInput!, password: passwordInput!) == true {
            
            performSegueWithIdentifier("segueToAdminLotsView", sender: nil)
            
            globalVar.loggedIn = true
            
        } else if incorrectPasswordLabel.hidden && incorrectUsernameOrPasswordLabel.hidden == true {
                
            incorrectCredentionalLabel.hidden = false
            
        }
        
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        
        userText.resignFirstResponder()
        
        return true;
    
    }
    
    func checkAccountCredentials() -> Bool {
        
        if checkUsernameOrEmailCredentials() && checkPasswordCredentials() == true {
            
            return true

        } else {
            
            return false
            
        }
        
    }
    
    func checkUsernameOrEmailCredentials() -> Bool {
        
        if usernameOrEmailInputTextField.text!.isEmpty {
            
            incorrectUsernameOrPasswordLabel.text = "Please enter your username or email."
            incorrectUsernameOrPasswordLabel.hidden = false
            
            return false
            
        } else {
            
            incorrectUsernameOrPasswordLabel.hidden = true
            
            return true
            
        }
        
    }
    
    func checkPasswordCredentials() -> Bool {
    
        if passwordInputTextField.text!.isEmpty {
            
            incorrectPasswordLabel.text = "Please enter your password."
            incorrectPasswordLabel.hidden = false
            
            return false
        
        } else {
            
            incorrectPasswordLabel.hidden = true
            
            return true
        
        }
        
    }
    
    func login(userNameorPassword: String, password: String) -> Bool {
    
        if checkAccountCredentials() == true {
        
            var responseString = ""
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.99.101/userLogin.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "username=\(userNameorPassword)&password=\(password)"
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let semaphore = dispatch_semaphore_create(0)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {
                    // check for fundamental networking error
                    
                    print("error=\(error)")
                    
                    return
                
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                    // check for http errors
                    
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
                    print("response = \(response)")
              
                }
                
                responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
                
    //            print("Success?: ", responseString.containsString("Success"))
                
    //            print("responseString =", responseString)
                
                
                dispatch_semaphore_signal(semaphore)
                
            }
            
            task.resume()
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            
            return responseString.containsString("Success")
            
        } else {
            
            return false
            
        }
        
    }
    
}