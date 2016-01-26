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
    @IBOutlet weak var lotBackUpTextField: UITextField!
    @IBOutlet weak var lotHoursOfAvailabilityTextField: UITextField!
    
    @IBOutlet weak var lotNameInputErrorLabel: UILabel!
    @IBOutlet weak var lotLocationInputErrorLabel: UILabel!
    @IBOutlet weak var lotCapacityInputErrorLabel: UILabel!
    @IBOutlet weak var lotBackUpLotInputErrorLabel: UILabel!
    @IBOutlet weak var lotHoursOfAvailabilityInputErrorLabel: UILabel!
    
    
    let managementType = "Create"
    var lotName = "C10"
    var lotLocation = "ISAT/HHS"
    var lotCapacity = 150
    var lotBackUp = "Festival"
    var lotHoursOfAvailability = 12
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.lotNameTextField.delegate = self
        self.lotLocationTextField.delegate = self
        self.lotCapacityTextField.delegate = self
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
            
            createOrManageLotTitleLabel.text = "Manage Lot: \(lotName)"
            createOrSaveButtonLabel.setTitle("Save", forState: .Normal)
            
            lotNameTextField.text = "\(lotName)"
            lotLocationTextField.text = "\(lotLocation)"
            lotCapacityTextField.text = "\(lotCapacity)"
            lotBackUpTextField.text = "\(lotBackUp)"
            lotHoursOfAvailabilityTextField.text = "\(lotHoursOfAvailability)"

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
        
        if lotNameInputErrorLabel.hidden == true && lotLocationInputErrorLabel.hidden == true && lotCapacityInputErrorLabel.hidden == true && lotBackUpLotInputErrorLabel.hidden == true && lotHoursOfAvailabilityInputErrorLabel.hidden == true {
            
            return true
            
        }
        
        return false
        
    }
    
    @IBAction func didPressSaveOrCreateButton(sender: AnyObject) {
        
        if managementType == "Manage" {
            
            if checkRequiredInputsAreSatisfied() == true {
                
                hideErrorLabels()
                
                let lot = createLotVariable()
                
                print("Lot: \(lot)")
                
                // POST method to update lot
                
                self.performSegueWithIdentifier("unwindToAdminLotsViewController", sender: nil)
                
            } else {
                
                // If required input fields aren't satisfied
                
            }
            
            
        } else {
            
            if checkRequiredInputsAreSatisfied() == true {
                
                hideErrorLabels()
                
                let lot = createLotVariable()
                
                print("Lot: \(lot)")
                
                // POST method to create lot

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
        lotBackUpLotInputErrorLabel.hidden = true
        lotHoursOfAvailabilityInputErrorLabel.hidden = true
    
    }
    
    func createLotVariable() -> [String: AnyObject] {
        
        let lot: [String: AnyObject] = [
            "Lot_Name": lotNameTextField.text!,
            "Lot_Location": lotLocationTextField.text!,
            "Lot_Capacity": Int(lotCapacityTextField.text!)!,
            "Back_Up_Lot": lotBackUpTextField.text!,
            "Hours_Of_Availability": Int(lotHoursOfAvailabilityTextField.text!)!
        ]
        
        return lot
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
