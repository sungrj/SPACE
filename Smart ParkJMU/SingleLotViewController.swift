//
//  SingleLotViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 11/10/15.
//  Copyright © 2015 Riley Sung. All rights reserved.
//

import UIKit

class SingleLotViewController: UIViewController {

    var refreshControl:UIRefreshControl!
    
    var lot = NSDictionary()
    
    @IBOutlet weak var lotNameLabel: UILabel!
    @IBOutlet weak var lotLocationLabel: UILabel!
    @IBOutlet weak var lotBackupLotLabel: UILabel!
    @IBOutlet weak var lotHoursOfAvailabilityLabel: UILabel!
    @IBOutlet weak var lotSpotsAvailableLabel: UILabel!
    @IBOutlet weak var lotTotalSpotsLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Lot from view", lot)
        
        updateLotLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressRefresh(sender: AnyObject) {
        
        let lots = ViewController.getAllLotsData()
            
        for item in lots {

            if let thisLot = item["Lot_Name"] {
                
                if (thisLot as! NSString) == lotNameLabel.text {
                    
                    lot = item as! NSDictionary
                    
                }
                
            }
            
        }
        
        updateLotLabels()
        
    }
    
    func updateLotLabels() {
        
        if let lotName = lot["Lot_Name"] {
            
            lotNameLabel.text = lotName as? String
            
        }
        
        if let lotLocation = lot["Location"] {
            
            lotLocationLabel.text = lotLocation as? String
            
        }
        
        if let lotBackup = lot["Backup_Lot"] {
            
            lotBackupLotLabel.text = lotBackup as? String
            
        }
        
        if let lotHours = lot["Hours_Of_Availability"] {
            
            lotHoursOfAvailabilityLabel.text = lotHours as? String
            
        }
        
        if let lotSpots = lot["Available_Number_Of_Spots"] {
            
            lotSpotsAvailableLabel.text = lotSpots as? String
            
        }
        
        if let lotTotal = lot["Capacity_Of_Spots"] {
            
            lotTotalSpotsLabel.text = lotTotal as? String
            
        }
        
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
