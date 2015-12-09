//
//  ViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 11/9/15.
//  Copyright © 2015 Riley Sung. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController, UITableViewDataSource {

    var lots: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         
        let query: PFQuery = PFQuery(className: "Lots")
        query.findObjectsInBackgroundWithBlock {
            (data: [PFObject]?, error: NSError?) -> Void in
                if error == nil && data != nil {
                    print("data", data)
                    print( "data -> \(data.dynamicType)")
                    if let data = data {
                        for lot in data {
                            print("This lotID is: ", lot["Name"])
                            self.lots.append(lot)
                        }
                    }
                } else {
                    print(error)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lots.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "Hello" //"lots[indexPath.row].Name
        cell.textLabel?.sizeToFit()
        cell.textLabel?.font = UIFont.systemFontOfSize(38)          // font size
        cell.textLabel?.textAlignment = NSTextAlignment.Center      // align text in the center
        cell.backgroundColor = UIColor.clearColor()                 // cell background clear
        
        
        return cell
    }
    
    
    // IBAction + segue
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        print("ViewController.unwrapToViewController:")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let singleLotViewController = segue.destinationViewController as? SingleLotViewController {
            print("viewController.Preparing singleLotViewController")
            singleLotViewController.view.backgroundColor = UIColor.blueColor()
        
//         pass data to the view controller
            singleLotViewController.lot = self.lots
        }
    }


}

