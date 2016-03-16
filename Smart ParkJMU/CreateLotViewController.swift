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

    
    @IBOutlet weak var generalSpotsAvailableTextField: UITextField!
    @IBOutlet weak var generalSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var handicapSpotsAvailableTextField: UITextField!
    @IBOutlet weak var handicapSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var meteredSpotsAvailableTextField: UITextField!
    @IBOutlet weak var meteredSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var motorcycleSpotsAvailableTextField: UITextField!
    @IBOutlet weak var motorcycleSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var visitorSpotsAvailableTextField: UITextField!
    @IBOutlet weak var visitorSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var totalSpotsAvailableTextField: UILabel!
    @IBOutlet weak var totalSpotsTotalTextField: UILabel!
    
    @IBAction func calculateAvailableSpots(sender: UITextField) {
        calculateAvailableSpots()
    }
    
    @IBAction func calculateTotalSpots(sender: UITextField) {
        calculateTotalSpots()
    }
    
    
    var lot = NSDictionary()
    var lotId: Int = 0
    
    var managementType = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        alertLabel.hidden = false
        alertLabel.layer.masksToBounds = true;
        alertLabel.layer.cornerRadius = 19;
        
        if let id = lot["ID"] {
            
            lotId = (id as! NSString).integerValue
            
        }

        checkCreateOrManageLot()
        
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
        calculateAvailableSpots()
        
        if managementType == "Manage" {
            
            if checkRequiredInputsAreSatisfied() == true {
                
                // POST method to update lot
                
//                createOrSaveLot("http://space-jmu.bitnamiapp.com/updateLot.php")
                
            } else {
                
                // If required input fields aren't satisfied
                
            }
            
        } else if managementType == "Create" {
            
            if checkRequiredInputsAreSatisfied() == true {
                
                // POST method to create lot
                
//                createOrSaveLot("http://space-jmu.bitnamiapp.com/createLot.php")
                
            }
            
        }
        
    }
    
    @IBAction func unwindToFirstCreateOrSaveViewController(segue: UIStoryboardSegue) {
    }

    func checkCreateOrManageLot() {
        
        if managementType == "Manage" {
            
            let lotName = lot["Lot_Name"] as! String
            
            createOrManageLotTitleLabel.text = "Manage Lot: \(lotName)"
            createOrSaveButtonLabel.setTitle("Save", forState: .Normal)
            
//            updateLotLabels()
            
        } else {
            
            createOrManageLotTitleLabel.text = "Create Lot"
            
            createOrSaveButtonLabel.setTitle("Create", forState: .Normal)
            
            deleteButtonLabel.hidden = true
            
        }
        
    }
    
    func checkRequiredInputsAreSatisfied() -> Bool {
        
        
        if lotNameTextField.text == "" {
            
            alertLabel.text = "Must enter name"
            
            alertLabel.hidden = false
            
            return false
            
        } else {
            
            alertLabel.hidden = true
            
        }
        
        if lotLocationTextField.text == "" {
            
            alertLabel.text = "Must enter location"
            
            alertLabel.hidden = false
            
            return false
            
        } else {
            
            alertLabel.hidden = true
            
        }
        
        if let _ = Int(generalSpotsAvailableTextField.text!) {
            
        } else if generalSpotsAvailableTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if let _ = Int(generalSpotsTotalTextField.text!) {
            
        } else if generalSpotsTotalTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if Int(generalSpotsAvailableTextField.text!) > Int(generalSpotsTotalTextField.text!)  {
            
            alertLabel.text = "Available spots must be less than total"
            alertLabel.hidden = false
            return false
            
        }
        
        if let _ = Int(handicapSpotsAvailableTextField.text!) {
            
        } else if handicapSpotsAvailableTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if let _ = Int(handicapSpotsTotalTextField.text!) {
            
        } else if handicapSpotsTotalTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if Int(handicapSpotsAvailableTextField.text!) > Int(handicapSpotsTotalTextField.text!)  {
            
            alertLabel.text = "Available spots must be less than total"
            alertLabel.hidden = false
            return false
            
        }
        
        if let _ = Int(meteredSpotsAvailableTextField.text!) {
            
        } else if meteredSpotsAvailableTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if let _ = Int(meteredSpotsTotalTextField.text!) {
            
        } else if meteredSpotsTotalTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if Int(meteredSpotsAvailableTextField.text!) > Int(meteredSpotsTotalTextField.text!)  {
            
            alertLabel.text = "Available spots must be less than total"
            alertLabel.hidden = false
            return false
            
        }
        
        if let _ = Int(motorcycleSpotsAvailableTextField.text!) {
            
        } else if motorcycleSpotsAvailableTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if let _ = Int(motorcycleSpotsTotalTextField.text!) {
            
        } else if motorcycleSpotsTotalTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if Int(motorcycleSpotsAvailableTextField.text!) > Int(motorcycleSpotsTotalTextField.text!)  {
            
            alertLabel.text = "Available spots must be less than total"
            alertLabel.hidden = false
            return false
            
        }
        
        if let _ = Int(visitorSpotsAvailableTextField.text!) {
            
        } else if visitorSpotsAvailableTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if let _ = Int(visitorSpotsTotalTextField.text!) {
            
        } else if visitorSpotsTotalTextField.text == "" {
            
            alertLabel.text = "Enter all spot availabilities"
            alertLabel.hidden = false
            return false
            
        } else {
            
            alertLabel.text = "Spot availabilities aren't integers"
            alertLabel.hidden = false
            return false
        }
        
        if Int(visitorSpotsAvailableTextField.text!) > Int(visitorSpotsTotalTextField.text!)  {
            
            alertLabel.text = "Available spots must be less than total"
            alertLabel.hidden = false
            return false
            
        }
    
        alertLabel.hidden = true
        return true
        
    }
    
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
    
    func calculateAvailableSpots() {
        if let genAvail = Int(generalSpotsAvailableTextField.text!) as Int? {
            if let handicapAvail = Int(handicapSpotsAvailableTextField.text!) as Int? {
                if let meteredAvail = Int(meteredSpotsAvailableTextField.text!) as Int? {
                    if let motorcycleAvail = Int(motorcycleSpotsAvailableTextField.text!) as Int? {
                        if let visitorAvail = Int(visitorSpotsAvailableTextField.text!) as Int? {
                            if let totalAvail = (genAvail + handicapAvail + meteredAvail + motorcycleAvail + visitorAvail) as Int? {
                                calculateTotalAvailableSpots(totalAvail)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func calculateTotalSpots() {
        if let genTotal = Int(generalSpotsTotalTextField.text!) as Int? {
            if let handicapTotal = Int(handicapSpotsTotalTextField.text!) as Int? {
                if let meteredTotal = Int(meteredSpotsTotalTextField.text!) as Int? {
                    if let motorcycleTotal = Int(motorcycleSpotsTotalTextField.text!) as Int? {
                        if let visitorTotal = Int(visitorSpotsTotalTextField.text!) as Int? {
                            if let totalTotal = (genTotal + handicapTotal + meteredTotal + motorcycleTotal + visitorTotal) as Int? {
                                calculateTotalTotalSpots(totalTotal)
                            }
                        }
                    }
                }
            }
        }
    }

    
    func calculateTotalAvailableSpots(numberOfAvailableSpots: Int) {
        totalSpotsAvailableTextField.text = String(numberOfAvailableSpots)
    }
    
    func calculateTotalTotalSpots(numberOfTotalSpots: Int) {
        totalSpotsTotalTextField.text = String(numberOfTotalSpots)
    }


    
}
