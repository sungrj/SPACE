//
//  CreateLotViewControllerTwo.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 3/15/16.
//  Copyright © 2016 Riley Sung. All rights reserved.
//

import UIKit

class CreateLotViewControllerTwo: UIViewController {

    
    @IBOutlet weak var createOrManageLotTitleLabel: UILabel!
    @IBOutlet weak var createOrSaveButtonLabel: UIButton!
    
    @IBOutlet weak var deleteButtonLabel: UIButton!
    
    @IBOutlet weak var lotNameTextField: UITextField!
    @IBOutlet weak var lotLocationTextField: UITextField!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    // Spot Available/Total Text Fields
    @IBOutlet weak var housekeepingSpotsAvailableTextField: UITextField!
    @IBOutlet weak var housekeepingSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var serviceSpotsAvailableTextField: UITextField!
    @IBOutlet weak var serviceSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var hallDirectorSpotsAvailableTextField: UITextField!
    @IBOutlet weak var hallDirectorSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var miscSpotsAvailableTextField: UITextField!
    @IBOutlet weak var miscSpotsTotalTextField: UITextField!
    
    @IBOutlet weak var totalSpotsAvailableTextField: UILabel!
    @IBOutlet weak var totalSpotsTotalTextField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
