//
//  AdminLotsViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 1/24/16.
//  Copyright © 2016 Riley Sung. All rights reserved.
//

import UIKit

class AdminLotsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var lots = []
    
    
    @IBOutlet weak var adminLotsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lots = ViewController.getAllLotsData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressLogout(sender: AnyObject) {
        
        globalVar.loggedIn = false
        
    }
    
    
    @IBAction func unwindToAdminLotsViewController(segue: UIStoryboardSegue) {
    }
    
    // Data Source Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return lots.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let lotName = (lots[indexPath.row]["Lot_Name"]) as! String
        
        cell.textLabel!.text = lotName
        
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.textLabel?.sizeToFit()
        cell.textLabel?.font = UIFont.systemFontOfSize(38)          // font size
        cell.textLabel?.textAlignment = NSTextAlignment.Center      // align text in the center
        cell.backgroundColor = UIColor.clearColor()                 // cell background clear
       
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("segueToManageLotFromTable", sender: nil)

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToManageLotFromTable" {
            
            if let destination = segue.destinationViewController as? CreateLotViewController {
                
                if let index = adminLotsTableView.indexPathForSelectedRow?.row {
                    
                    destination.lot = lots[index] as! NSDictionary
                    destination.managementType = "Manage"
                    
                }
            }
            
        } else {
            
            if let destination = segue.destinationViewController as? CreateLotViewController {
        
                    destination.managementType = "Create"
                    
            }
            
        }
            
        if let destination = segue.destinationViewController as? ViewController {
            
            destination.lots = ViewController.getAllLotsData()
            
            destination.lotsTableView.reloadData()
            
            
        }
    }

}
