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
    @IBOutlet weak var alertLabel: UILabel!

    
    
    var lot = NSDictionary()
    var lotId: Int = 0
    
    var managementType = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let id = lot["ID"] {
            
            lotId = (id as! NSString).integerValue
            
        }
        
        
        checkCreateOrManageLot()
        hideErrorLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destination = segue.destinationViewController as? AdminLotsViewController {
            destination.lots = ViewController.getAllLotsData()
            destination.adminLotsTableView.reloadData()
//            print("data reloaded")
        }
    }
    
    @IBAction func didPressDeleteButton(sender: AnyObject) {
        
        
        
        let refreshAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete lot '\(lotNameTextField.text as String!)'?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            
            // POST method to delete Lot
            self.deleteLot()
            
            self.performSegueWithIdentifier("unwindToAdminLotsViewController", sender: nil)
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
            // Do nothing on cancel
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func didPressSaveOrCreateButton(sender: AnyObject) {
        
//        if managementType == "Manage" {
//            
//            if checkRequiredInputsAreSatisfied() == true {
//                
//                hideErrorLabels()
//                
//                // POST method to update lot
//                
//                createOrSaveLot("http://space-jmu.bitnamiapp.com/updateLot.php")
//                
//            } else {
//                
//                // If required input fields aren't satisfied
//                
//            }
//            
//        } else if managementType == "Create" {
//            
//            if checkRequiredInputsAreSatisfied() == true {
//                
//                hideErrorLabels()
//                
//                // POST method to create lot
//                
//                createOrSaveLot("http://space-jmu.bitnamiapp.com/createLot.php")
//                
//            }
//            
//        }
        
    }
    
    func checkCreateOrManageLot() {
        
        if managementType == "Manage" {
            
            let lotName = lot["Lot_Name"] as! String
            
            createOrManageLotTitleLabel.text = "Manage Lot: \(lotName)"
            createOrSaveButtonLabel.setTitle("Save", forState: .Normal)
            
//            updateLotLabels()
            
        } else {
            
            createOrManageLotTitleLabel.text = "Create a Lot"
            
            createOrSaveButtonLabel.setTitle("Create", forState: .Normal)
            
            deleteButtonLabel.hidden = true
            
        }
        
    }
    
//    func checkRequiredInputsAreSatisfied() -> Bool {
//        
//        if lotNameTextField.text == "" {
//            
//            lotNameInputErrorLabel.text = "(Must enter name)"
//            
//            lotNameInputErrorLabel.hidden = false
//            
//        } else {
//            
//            lotNameInputErrorLabel.hidden = true
//            
//        }
//        
//        if lotLocationTextField.text == "" {
//            
//            lotLocationInputErrorLabel.text = "(Must enter location)"
//            
//            lotLocationInputErrorLabel.hidden = false
//            
//        } else {
//            
//            lotLocationInputErrorLabel.hidden = true
//            
//        }
//        
//        if lotCapacityTextField.text == "" {
//            
//            lotCapacityInputErrorLabel.text = "(Must enter capacity)"
//            
//            lotCapacityInputErrorLabel.hidden = false
//            
//        } else {
//            
//            if let _ = Int(lotCapacityTextField.text!) {
//                
//                lotCapacityInputErrorLabel.hidden = true
//                
//            } else {
//                
//                lotCapacityInputErrorLabel.text = "(Input not a number)"
//                
//                lotCapacityInputErrorLabel.hidden = false
//                
//            }
//            
//        }
//        
//        if lotSpotsAvailableTextField.text == "" {
//            
//            lotSpotsAvailableInputErrorLabel.text = "(Must enter capacity)"
//            
//            lotSpotsAvailableInputErrorLabel.hidden = false
//            
//        } else {
//            
//            if let _ = Int(lotSpotsAvailableTextField.text!) {
//                
//                lotSpotsAvailableInputErrorLabel.hidden = true
//                
//            } else {
//                
//                lotSpotsAvailableInputErrorLabel.text = "(Input not a number)"
//                
//                lotSpotsAvailableInputErrorLabel.hidden = false
//                
//            }
//            
//        }
//        
//        if lotBackUpTextField.text == "" {
//            
//            lotBackUpLotInputErrorLabel.text = "(Must enter lot)"
//            
//            lotBackUpLotInputErrorLabel.hidden = false
//            
//        } else {
//            
//            lotBackUpLotInputErrorLabel.hidden = true
//            
//        }
//        
//        if lotHoursOfAvailabilityTextField.text == "" {
//            
//            lotHoursOfAvailabilityInputErrorLabel.text = "(Must enter hours)"
//            
//            lotHoursOfAvailabilityInputErrorLabel.hidden = false
//            
//        } else {
//            
//            if let _ = Int(lotHoursOfAvailabilityTextField.text!) {
//                
//                lotHoursOfAvailabilityInputErrorLabel.hidden = true
//                
//            } else {
//                
//                lotHoursOfAvailabilityInputErrorLabel.text = "(Input not a number)"
//                lotHoursOfAvailabilityInputErrorLabel.hidden = false
//                
//            }
//            
//            
//        }
//        
//        if lotNameInputErrorLabel.hidden == true && lotLocationInputErrorLabel.hidden == true && lotCapacityInputErrorLabel.hidden == true && lotSpotsAvailableInputErrorLabel.hidden == true && lotBackUpLotInputErrorLabel.hidden == true && lotHoursOfAvailabilityInputErrorLabel.hidden == true {
//            
//            return true
//            
//        }
//        
//        return false
//        
//    }
    
    func createOrSaveLot(url: String) {
            
//        var responseString = ""
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let lotName = String(UTF8String: lotNameTextField.text!)!
        let lotLocation = String(UTF8String: lotLocationTextField.text!)!
        let lotCapacity = 3 //Int(lotCapacityTextField.text!)!
        let lotSpots = 3 //Int(lotSpotsAvailableTextField.text!)!
        let lotBackup = 3 //String(UTF8String: lotBackUpTextField.text!)!
        let lotHours = 3 //String(UTF8String: lotHoursOfAvailabilityTextField.text!)!

        
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
            
//                        print("Success?: ", responseString.containsString("Success"))
            
//                        print("responseString =", responseString)

        }
        
        task.resume()
        
//        print("before perform segue")
        self.performSegueWithIdentifier("unwindToAdminLotsViewController", sender: nil)
//        print("after perform segue")
    }
    
    func deleteLot() {
        
//        var responseString = ""
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://space-jmu.bitnamiapp.com/deleteLot.php")!)
        
        let postString: String! = "lotId=\(lotId)"
        
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
            
//            responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
            
//            print("Success?: ", responseString.containsString("Success"))
            
//            print("responseString =", responseString)
            
        }
        
        task.resume()
        
    }
    
    func hideErrorLabels() {
        
//        lotNameInputErrorLabel.hidden = true
//        lotLocationInputErrorLabel.hidden = true
//        lotCapacityInputErrorLabel.hidden = true
//        lotSpotsAvailableInputErrorLabel.hidden = true
//        lotBackUpLotInputErrorLabel.hidden = true
//        lotHoursOfAvailabilityInputErrorLabel.hidden = true
        
    }
    
//    func updateLotLabels() {
//        
//        if let lotName = lot["Lot_Name"] {
//            
//            lotNameTextField.text = lotName as? String
//            
//        }
//        
//        if let lotLocation = lot["Location"] {
//            
//            lotLocationTextField.text = lotLocation as? String
//            
//        }
//        
//        if let lotCapacity = lot["Capacity_Of_Spots"] {
//            
//            lotCapacityTextField.text = lotCapacity as? String
//            
//        }
//        
//        if let lotSpots = lot["Available_Number_Of_Spots"] {
//            
//            lotSpotsAvailableTextField.text = lotSpots as? String
//            
//        }
//        
//        if let lotBackup = lot["Backup_Lot"] {
//            
//            lotBackUpTextField.text = lotBackup as? String
//            
//        }
//        
//        if let lotHours = lot["Hours_Of_Availabilty"] {
//            
//            lotHoursOfAvailabilityTextField.text = lotHours as? String
//            
//        }
//        
//        if let lotTotal = lot["Capacity_Of_Spots"] {
//            
//            lotCapacityTextField.text = lotTotal as? String
//            
//        }
//        
//    }
    

    
}
