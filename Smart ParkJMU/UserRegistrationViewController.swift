//
//  UserRegistrationViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 2/22/16.
//  Copyright © 2016 Riley Sung. All rights reserved.
//

import UIKit

class UserRegistrationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var nameTextInputField: UITextField!
    @IBOutlet weak var emailTextInputField: UITextField!
    @IBOutlet weak var passwordTextInputField: UITextField!
    @IBOutlet weak var confirmPasswordTextInputField: UITextField!
    @IBOutlet weak var permitTypePicker: UIPickerView!
    @IBOutlet weak var alertLabel: UILabel!
    
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var password: String = ""
    var permitType: String = ""
    var carType: String = ""
    
    let permitTypes: [[String]] = [["Commuter", "Resident", "Red Zone", "Blue Zone", "Freshman"],
                                   ["None", "Handicap", "Motorcycle", "Service", "Housekeeping", "Hall Director"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.permitTypePicker.delegate = self
        self.permitTypePicker.dataSource = self
        
        alertLabel.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return permitTypes[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return permitTypes[component][row]
    }

    @IBAction func didPressRegister(sender: AnyObject) {

        // print("Email: ", email, "Password: ", password, "First: ", firstName, "Last: ", lastName, "permitType: ", permitType, "Car Type:", carType)
        
        if checkCredentials() == true {
            
            createUser()
            
            alertLabel.hidden = true
        }
    }
    
    func checkName() -> Bool {
        if (nameTextInputField.text!.isEmpty) {
            
            alertLabel.hidden = false
            alertLabel.text = "Enter your full name."
            return false
            
        } else {
            
            let nameRegEx = "[A-Za-z]+\\s[A-Za-z]+"
            let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
            let result = nameTest.evaluateWithObject(nameTextInputField.text!)
            
//            print("check name", result)
            
            if result == true {
            
                // Separates Name into array of first and last name separately
                let fullNameArray = nameTextInputField.text!.componentsSeparatedByString(" ")
            
                firstName = fullNameArray[0] // First
                lastName = fullNameArray[1] // Last
                
                alertLabel.hidden = true
                
                return true
            } else {
                
                alertLabel.hidden = false
                alertLabel.text = "Must enter 'First Last' Names."
                return false
            }
        }
    }
    
    func checkEmail() -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(emailTextInputField.text!)
        
        // print("check email", result)
        
        email = emailTextInputField.text!
        
        if result == false {
            alertLabel.hidden = false
            alertLabel.text = "Incorrect email address!"
            return false
        } else {
            return true
        }

    }
    
    func checkPassword() -> Bool {
        
        if (passwordTextInputField.text == confirmPasswordTextInputField.text) && (passwordTextInputField.text! != "") && (confirmPasswordTextInputField.text! != "") {
            
            password = confirmPasswordTextInputField.text!
            
            return true
            
        } else {
            alertLabel.hidden = false
            alertLabel.text = "Passwords don't match!"
            return false
        }
    
    }
    
    func checkPickerValues() {
        permitType = permitTypes[0][permitTypePicker.selectedRowInComponent(0)]
        carType = permitTypes[1][permitTypePicker.selectedRowInComponent(1)]
    }
    
    func checkCredentials() -> Bool {
        
        if checkName() && checkEmail() && checkPassword() == true {
            checkPickerValues()
            return true
        } else {
            return false
        }
    }

    // TODO: For Account Update- Phone number validation
//    func checkPhone() -> Bool {
//        let phoneNumber = phoneNumberInputField.text!
//        let phoneRegEx = "(?\\d{3})?\\s\\d{3}-\\d{4}"
//    }

    func createUser() {
        
        var responseString = ""
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://spacejmu.bitnamiapp.com/SPACEApiCalls/userRegister.php")!)
        
        let postString = "email=\(email)&password=\(password)&firstName=\(firstName)&lastName=\(lastName)&permitType=\(permitType)&carType=\(carType)"
        
        request.HTTPMethod = "POST"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
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

            print("responseString =", responseString)
            if responseString.containsString("exists") {
                dispatch_async(dispatch_get_main_queue(), {
                    self.alertLabel.text = responseString
                    self.alertLabel.hidden = false
                })

            }
            
        }
        
        task.resume()
        

        
    }

    

}
