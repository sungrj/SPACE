//
//  ViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 11/9/15.
//  Copyright © 2015 Riley Sung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var lots = []
    
    @IBOutlet weak var lotsTableView: UITableView!
    @IBOutlet weak var didPressButtonLoginOrGoToAdminPage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkLoginStatus()
        
        lots = ViewController.getLotNames()
//        print("Lots:", ViewController.getAllLotsData())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    class func getAllLotsData() -> NSArray {
        
        var lotData = []
        
        let nsUrl = NSURL(string: "http://spacejmu.bitnamiapp.com/SPACEApiCalls/test1.php")
        
        let semaphore = dispatch_semaphore_create(0)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsUrl!){
            (data, response, error) in
            
            do {
                
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                lotData = jsonResult as! NSArray
                
            } catch {
                
                print ("JSON serialization failed")
            }
            
            dispatch_semaphore_signal(semaphore)
            
        }
        
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return lotData
    }
    
    class func getLotNames() -> NSArray {
        
        var lotData = []
        
        let nsUrl = NSURL(string: "http://spacejmu.bitnamiapp.com/SPACEApiCalls/getLotNames.php")
        
        let semaphore = dispatch_semaphore_create(0)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsUrl!){
            (data, response, error) in
            
            do {
                
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                lotData = jsonResult as! NSArray
//                print("data: ", lotData)
                
            } catch {
                
                print ("JSON serialization failed")
            }
            
            dispatch_semaphore_signal(semaphore)
            
        }
        
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return lotData
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return lots.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let lotName = (lots[indexPath.row]["Lot_Name"]) as! String
        
        cell.textLabel?.text = lotName
        cell.textLabel?.sizeToFit()
        cell.textLabel?.font = UIFont.systemFontOfSize(38)          // font size
        cell.textLabel?.textAlignment = NSTextAlignment.Center      // align text in the center
        cell.backgroundColor = UIColor.clearColor()                 // cell background clear
        
        return cell
    }
    
    
    
    
    // IBAction + segue
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        
        checkLoginStatus()
        
    }
    
    
    @IBAction func didPressLoginOrAdminPage(sender: AnyObject) {
        
        if globalVar.loggedIn == false {
            
            self.performSegueWithIdentifier("seguetoAdminLoginViewController", sender: nil)
            
        } else {
            
            self.performSegueWithIdentifier("segueToAdminLotsViewController", sender: nil)
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToSingleLotViewController" {

            if let destination = segue.destinationViewController as? SingleLotViewController {

                if let index = lotsTableView.indexPathForSelectedRow?.row {

                    let lotPassed = lots[index] as! NSDictionary
                    destination.lotId = lotPassed["Id"]!.integerValue
                
                }
            }
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("segueToSingleLotViewController", sender: nil)
    
    }
    
    func checkLoginStatus() {
        
        if globalVar.loggedIn == true {
            
            didPressButtonLoginOrGoToAdminPage.setTitle("Admin Page", forState: .Normal)
            
        } else {
            
            didPressButtonLoginOrGoToAdminPage.setTitle("Login", forState: .Normal)
            
        }
    }
    
}

