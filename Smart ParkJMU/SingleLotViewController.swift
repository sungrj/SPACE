//
//  SingleLotViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 11/10/15.
//  Copyright © 2015 Riley Sung. All rights reserved.
//

import UIKit

class SingleLotViewController: UIViewController, UITableViewDataSource {
   
    var lots = []

    @IBOutlet weak var lotTable: UITableView!
    @IBOutlet weak var singleLotSelected: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
       
        lots = getLotData()

        print("Lots", lots)
    }
    
    func getLotData() -> NSArray {
        
        var outer = []
        
        let nsUrl = NSURL(string: "http://192.168.99.101/test1.php")
        
        let semaphore = dispatch_semaphore_create(0)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsUrl!){
            (data, response, error) in
            
            do {
            
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                outer = jsonResult as! NSArray
            
            } catch {
            
                print ("JSON serialization failed")
            }
            
            dispatch_semaphore_signal(semaphore)
            
        }
        
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return outer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressRefresh(sender: AnyObject) {
        
        getLotData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lots.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let lotName = (lots[indexPath.row]["Lot_Name"]) as! String
        let spotsAvailable = lots[indexPath.row]["Available_Number_Of_Spots"]!!.integerValue as Int
        let totalSpots = lots[indexPath.row]["Capacity_Of_Spots"]!!.integerValue as Int
        
        if (spotsAvailable >= totalSpots) {
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

        cell.textLabel?.numberOfLines = 3
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
