//
//  CreateLotViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 1/24/16.
//  Copyright © 2016 Riley Sung. All rights reserved.
//

import UIKit

class CreateLotViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var createOrManageLotTitleLabel: UILabel!
    @IBOutlet weak var createOrSaveButtonLabel: UIButton!

    @IBOutlet weak var deleteButtonLabel: UIButton!
    
    @IBOutlet weak var lotNameTextField: UITextField!
    @IBOutlet weak var lotLocationTextField: UITextField!
    @IBOutlet weak var lotCapacityTextField: UITextField!
    @IBOutlet weak var lotSpotsAvailableTextField: UITextField!
    @IBOutlet weak var lotBackUpTextField: UITextField!
    @IBOutlet weak var lotHoursOfAvailabilityTextField: UITextField!
    
    @IBOutlet weak var lotNameInputErrorLabel: UILabel!
    @IBOutlet weak var lotLocationInputErrorLabel: UILabel!
    @IBOutlet weak var lotCapacityInputErrorLabel: UILabel!
    @IBOutlet weak var lotSpotsAvailableInputErrorLabel: UILabel!
    @IBOutlet weak var lotBackUpLotInputErrorLabel: UILabel!
    @IBOutlet weak var lotHoursOfAvailabilityInputErrorLabel: UILabel!
    
    
    var lot = NSDictionary()
    var lotId: Int = 0
    
    var managementType = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let id = lot["ID"] {
            
            lotId = (id as! NSString).integerValue
            
        }
        
        self.lotNameTextField.delegate = self
        self.lotLocationTextField.delegate = self
        self.lotCapacityTextField.delegate = self
        self.lotSpotsAvailableTextField.delegate = self
        self.lotBackUpTextField.delegate = self
        self.lotHoursOfAvailabilityTextField.delegate = self
        
        checkCreateOrManageLot()
        hideErrorLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressDeleteButton(sender: AnyObject) {
        
        // POST to delete Lot
        
        self.performSegueWithIdentifier("unwindToAdminLotsViewController", sender: nil)
        
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        
        userText.resignFirstResponder()
        
        return true;
        
    }
    
    func checkCreateOrManageLot() {
        
        if managementType == "Manage" {
            
            let lotName = lot["Lot_Name"] as! String
            
            createOrManageLotTitleLabel.text = "Manage Lot: \(lotName)"
            createOrSaveButtonLabel.setTitle("Save", forState: .Normal)
            
            updateLotLabels()

        } else {
            
            createOrManageLotTitleLabel.text = "Create a Lot"
            
            createOrSaveButtonLabel.setTitle("Create", forState: .Normal)
            
            deleteButtonLabel.hidden = true
            
        }
        
    }
    
    func checkRequiredInputsAreSatisfied() -> Bool {
        
        if lotNameTextField.text == "" {
            
            lotNameInputErrorLabel.text = "(Must enter name)"
            
            lotNameInputErrorLabel.hidden = false
            
        } else {
            
            lotNameInputErrorLabel.hidden = true
            
        }
        
        if lotLocationTextField.text == "" {
            
            lotLocationInputErrorLabel.text = "(Must enter location)"
            
            lotLocationInputErrorLabel.hidden = false
            
        } else {
            
            lotLocationInputErrorLabel.hidden = true
            
        }
        
        if lotCapacityTextField.text == "" {
            
            lotCapacityInputErrorLabel.text = "(Must enter capacity)"
            
            lotCapacityInputErrorLabel.hidden = false
            
        } else {
            
            if let _ = Int(lotCapacityTextField.text!) {
                
                lotCapacityInputErrorLabel.hidden = true
                
            } else {
                
                lotCapacityInputErrorLabel.text = "(Input not a number)"
                
                lotCapacityInputErrorLabel.hidden = false
                
            }
            
        }
        
        if lotSpotsAvailableTextField.text == "" {
            
            lotSpotsAvailableInputErrorLabel.text = "(Must enter capacity)"
            
            lotSpotsAvailableInputErrorLabel.hidden = false
            
        } else {
            
            if let _ = Int(lotSpotsAvailableTextField.text!) {
                
                lotSpotsAvailableInputErrorLabel.hidden = true
                
            } else {
                
                lotSpotsAvailableInputErrorLabel.text = "(Input not a number)"
                
                lotSpotsAvailableInputErrorLabel.hidden = false
                
            }
            
        }
        
        if lotBackUpTextField.text == "" {
            
            lotBackUpLotInputErrorLabel.text = "(Must enter lot)"
            
            lotBackUpLotInputErrorLabel.hidden = false
            
        } else {
            
            lotBackUpLotInputErrorLabel.hidden = true
            
        }
        
        if lotHoursOfAvailabilityTextField.text == "" {
            
            lotHoursOfAvailabilityInputErrorLabel.text = "(Must enter hours)"
            
            lotHoursOfAvailabilityInputErrorLabel.hidden = false

        } else {
            
            if let _ = Int(lotHoursOfAvailabilityTextField.text!) {
                
                lotHoursOfAvailabilityInputErrorLabel.hidden = true
                
            } else {
                
                lotHoursOfAvailabilityInputErrorLabel.text = "(Input not a number)"
                lotHoursOfAvailabilityInputErrorLabel.hidden = false
                
            }
            
            
        }
        
        if lotNameInputErrorLabel.hidden == true && lotLocationInputErrorLabel.hidden == true && lotCapacityInputErrorLabel.hidden == true && lotSpotsAvailableInputErrorLabel.hidden == true && lotBackUpLotInputErrorLabel.hidden == true && lotHoursOfAvailabilityInputErrorLabel.hidden == true {
            
            return true
            
        }
        
        return false
        
    }
    
    @IBAction func didPressSaveOrCreateButton(sender: AnyObject) {
        
        if managementType == "Manage" {
            
            if checkRequiredInputsAreSatisfied() == true {
                
                hideErrorLabels()
                
                // POST method to update lot
                
                createOrSaveLot("http://192.168.99.101/updateLot.php")
                
                self.performSegueWithIdentifier("unwindToAdminLotsViewController", sender: nil)
                
            } else {
                
                // If required input fields aren't satisfied
                
            }
            
        } else {
            
            if checkRequiredInputsAreSatisfied() == true {
                
                hideErrorLabels()
                
                // POST method to create lot
                
                createOrSaveLot("http://192.168.99.101/createLot.php")

                self.performSegueWithIdentifier("unwindToAdminLotsViewController", sender: nil)
                
            } else {
                
                // If required input fields aren't satisfied
                
            }
            
        }
        
    }
    
    func hideErrorLabels() {
        
        lotNameInputErrorLabel.hidden = true
        lotLocationInputErrorLabel.hidden = true
        lotCapacityInputErrorLabel.hidden = true
        lotSpotsAvailableInputErrorLabel.hidden = true
        lotBackUpLotInputErrorLabel.hidden = true
        lotHoursOfAvailabilityInputErrorLabel.hidden = true
    
    }
    

    func updateLotLabels() {
        
        if let lotName = lot["Lot_Name"] {
            
            lotNameTextField.text = lotName as? String
            
        }
        
        if let lotLocation = lot["Location"] {
            
            lotLocationTextField.text = lotLocation as? String
            
        }
        
        if let lotCapacity = lot["Capacity_Of_Spots"] {
            
            lotCapacityTextField.text = lotCapacity as? String
            
        }
        
        if let lotSpots = lot["Available_Number_Of_Spots"] {
            
            lotSpotsAvailableTextField.text = lotSpots as? String
            
        }
        
        if let lotBackup = lot["Backup_Lot"] {
            
            lotBackUpTextField.text = lotBackup as? String
            
        }
        
        if let lotHours = lot["Hours_Of_Availabilty"] {
            
            lotHoursOfAvailabilityTextField.text = lotHours as? String
            
        }

        if let lotTotal = lot["Capacity_Of_Spots"] {
            
            lotCapacityTextField.text = lotTotal as? String
            
        }
        
    }
    
    func createOrSaveLot(url: String) {
            
//        var responseString = ""
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let lotName = String(UTF8String: lotNameTextField.text!)!
        let lotLocation = String(UTF8String: lotLocationTextField.text!)!
        let lotCapacity = Int(lotCapacityTextField.text!)!
        let lotSpots = Int(lotSpotsAvailableTextField.text!)!
        let lotBackup = String(UTF8String: lotBackUpTextField.text!)!
        let lotHours = String(UTF8String: lotHoursOfAvailabilityTextField.text!)!

        
        var postString: String! = ""
        
        
        request.HTTPMethod = "POST"
        
        if managementType == "Manage" {
            
            postString = "lotName=\(lotName)&lotLocation=\(lotLocation)&lotCapacity=\(lotCapacity)&lotSpots=\(lotSpots)&lotBackup=\(lotBackup)&lotHours=\(lotHours)&lotId=\(lotId)"

        } else {
            
            postString = "lotName=\(lotName)&lotLocation=\(lotLocation)&lotCapacity=\(lotCapacity)&lotSpots=\(lotSpots)&lotBackup=\(lotBackup)&lotHours=\(lotHours)"
            
        }
            
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
            
//            responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
//            
//                        print("Success?: ", responseString.containsString("Success"))
//            
//                        print("responseString =", responseString)
//            
        }
        
        task.resume()

    }
    
}
