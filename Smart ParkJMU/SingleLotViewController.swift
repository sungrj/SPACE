//
//  SingleLotViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 11/10/15.
//  Copyright © 2015 Riley Sung. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SingleLotViewController: UIViewController, UITableViewDataSource {
    
    
    var lot = [] {
        didSet {
            print("Lots: ",lot)
        }
    }
    
    @IBOutlet weak var lotTable: UITableView!
    @IBOutlet weak var singleLotSelected: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        print("SingleLotViewController.viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lot.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let lotName = (lot[indexPath.row]["Name"]) as! String
        let spotsAvailable = lot[indexPath.row]["spotsAvailable"] as! Int
        let totalSpots = lot[indexPath.row]["totalSpots"]!!.integerValue as Int
        
        if (spotsAvailable > totalSpots) {
            cell.textLabel?.text = "Name: \(lotName)" + "\n" +
                                   "Spots Available: Full\n" +
                                   "Total Spots: \(totalSpots)"
        }
        else if (spotsAvailable <= 0) {
            cell.textLabel?.text = "Name: \(lotName)" + "\n" +
                                   "Spots Available: Empty\n" +
                                   "Total Spots: \(totalSpots)"
        } else {
            cell.textLabel?.text = "Name: \(lotName)" + "\n" +
                                   "Spots Available: \(spotsAvailable)" + "\n" +
                                   "Total Spots: \(totalSpots)"

        }

        cell.textLabel?.numberOfLines = 4
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.sizeToFit()
        cell.textLabel?.font = UIFont.systemFontOfSize(18)          // font size
        cell.backgroundColor = UIColor.clearColor()                 // cell background clear
        
        return cell
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
