//
//  ViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 11/9/15.
//  Copyright © 2015 Riley Sung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var didPressButtonLoginOrGoToAdminPage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkLoginStatus()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "" //"lots[indexPath.row].Name
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
        
        if let singleLotViewController = segue.destinationViewController as? SingleLotViewController {
            print("viewController.Preparing singleLotViewController")
            singleLotViewController.view.backgroundColor = UIColor.blueColor()
        
//         pass data to the view controller
//            singleLotViewController.lot = self.lots
        }
    }
    
    func checkLoginStatus() {
        
        if globalVar.loggedIn == true {
            
            didPressButtonLoginOrGoToAdminPage.setTitle("Admin Page", forState: .Normal)
            
        } else {
            
            didPressButtonLoginOrGoToAdminPage.setTitle("Login", forState: .Normal)
            
        }
    }


}

