//
//  SingleLotViewController.swift
//  Smart ParkJMU
//
//  Created by Riley Sung on 11/10/15.
//  Copyright © 2015 Riley Sung. All rights reserved.
//

import UIKit

class SingleLotViewController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var refreshControl:UIRefreshControl!
    
    // Lot iVars
    var lot = NSDictionary()
    var lotId: Int = 91235
    var lotPropertyNames: NSMutableArray = []
    var lotPropertyInfo: NSMutableArray = []
    
    // Lot Times iVars
    let userPermitTypes = ["Commuter", "Resident", "Red Zone", "Blue Zone", "Freshman"]
    var selectedPermitType: String = "Commuter"
    var selectedLotTimesForPermit: NSDictionary = [:]
    var parsedLotTimes = Dictionary<String, Dictionary<String, String>>()
    
    @IBOutlet weak var lotNameLabel: UILabel!
    @IBOutlet weak var lotLocationLabel: UILabel!
    @IBOutlet weak var lotGeneralSpotInfoLabel: UILabel!
    @IBOutlet weak var lotTotalSpotInfoLabel: UILabel!
    @IBOutlet weak var permitTypeLotTimesPicker: UIPickerView!
    
    // Lot Times Labels
    @IBOutlet weak var monThurTitleLabel: UILabel!
    @IBOutlet weak var monThurHoursAvailabilityLabel: UILabel!
    @IBOutlet weak var fridayTitleLabel: UILabel!
    @IBOutlet weak var fridayHoursAvailabilityLabel: UILabel!
    @IBOutlet weak var satSunTitleLabel: UILabel!
    @IBOutlet weak var satSunHoursAvailabilityLabel: UILabel!
    @IBOutlet weak var timeLoadingHoursAvailabilityLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.permitTypeLotTimesPicker.delegate = self
        self.permitTypeLotTimesPicker.dataSource = self
        
        hideTimeLabels()
        
        lot = SingleLotViewController.getLotData(lotId)[0] as! NSDictionary
        lotNameLabel.text = lot["Lot_Name"] as? String
        lotLocationLabel.text = lot["Location"] as? String

        updateLotNames()
        updateLotSpotsInfo()

        selectedLotTimesForPermit = getLotTimeForPermitType(selectedPermitType, lotId: lotId)[0] as! NSDictionary
        
        print(lot)

        parseLotTimes(selectedLotTimesForPermit)
        updateLotTimes()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressRefresh(sender: AnyObject) {
        
        lot = SingleLotViewController.getLotData(lotId)[0] as! NSDictionary
        
        updateLotSpotsInfo()
        
    }
    
    func hideTimeLabels() {
        monThurTitleLabel.hidden = true
        monThurHoursAvailabilityLabel.hidden = true
        fridayTitleLabel.hidden = true
        fridayHoursAvailabilityLabel.hidden = true
        satSunTitleLabel.hidden = true
        satSunHoursAvailabilityLabel.hidden = true
        timeLoadingHoursAvailabilityLabel.hidden = false
    }
    
    func showTimeLabels() {
        monThurTitleLabel.hidden = false
        monThurHoursAvailabilityLabel.hidden = false
        fridayTitleLabel.hidden = false
        fridayHoursAvailabilityLabel.hidden = false
        satSunTitleLabel.hidden = false
        satSunHoursAvailabilityLabel.hidden = false
        timeLoadingHoursAvailabilityLabel.hidden = true
    }
    
    func updateLotNames () {
        // Reset lotPropertyNames Array
        lotPropertyNames = []
        
        lotPropertyNames.addObject("Handicap")
        lotPropertyNames.addObject("Metered")
        lotPropertyNames.addObject("Motorcycle")
        lotPropertyNames.addObject("Visitor")
        lotPropertyNames.addObject("Housekeeping")
        lotPropertyNames.addObject("Service")
        lotPropertyNames.addObject("Hall Director")
        lotPropertyNames.addObject("Miscellaneous")
    }
    
    func updateLotSpotsInfo () {
        
        // Reset lotPropertyInfo Array
        lotPropertyInfo = []
        
        lotGeneralSpotInfoLabel.text = "\(lot["General_Available"]!.integerValue) | \(lot["General_Capacity"]!.integerValue)"
        lotPropertyInfo.addObject("\(lot["Handicap_Available"]!.integerValue) | \(lot["Handicap_Capacity"]!.integerValue)")
        lotPropertyInfo.addObject("\(lot["Metered_Available"]!.integerValue) | \(lot["Metered_Capacity"]!.integerValue)")
        lotPropertyInfo.addObject("\(lot["Motorcycle_Available"]!.integerValue) | \(lot["Motorcycle_Capacity"]!.integerValue)")
        lotPropertyInfo.addObject("\(lot["Visitor_Available"]!.integerValue) | \(lot["Visitor_Capacity"]!.integerValue)")
        lotPropertyInfo.addObject("\(lot["Housekeeping_Available"]!.integerValue) | \(lot["Housekeeping_Capacity"]!.integerValue)")
        lotPropertyInfo.addObject("\(lot["Service_Available"]!.integerValue) | \(lot["Service_Capacity"]!.integerValue)")
        lotPropertyInfo.addObject("\(lot["Hall_Director_Available"]!.integerValue) | \(lot["Hall_Director_Capacity"]!.integerValue)")
        lotPropertyInfo.addObject("\(lot["Misc_Available"]!.integerValue) | \(lot["Misc_Capacity"]!.integerValue)")
        lotTotalSpotInfoLabel.text = "\(lot["Total_Available"]!.integerValue) | \(lot["Total_Capacity"]!.integerValue)"
        
        showTimeLabels()
    }
    
    func updateLotTimes() {
        
        monThurHoursAvailabilityLabel.text = compareHoursOfAvailability(parsedLotTimes["Mon-Thur"]!["Open"]!, date2: parsedLotTimes["Mon-Thur"]!["Closed"]!)
        fridayHoursAvailabilityLabel.text = compareHoursOfAvailability(parsedLotTimes["Friday"]!["Open"]!, date2: parsedLotTimes["Friday"]!["Closed"]!)
        satSunHoursAvailabilityLabel.text = compareHoursOfAvailability(parsedLotTimes["Sat-Sun"]!["Open"]!, date2: parsedLotTimes["Sat-Sun"]!["Closed"]!)
    
    }
    
    func compareHoursOfAvailability(date1: String, date2: String) -> String {
        
        let df = NSDateFormatter()
        df.dateFormat = "h:mm a"
        df.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        if date1 != "Closed" || date2 != "Closed" {
            
            if df.dateFromString(date1)!
                .compare(df.dateFromString(date2)!) == NSComparisonResult.OrderedDescending {
                    
                    return "After \(date1)"
                    
            } else if df.dateFromString(date1)!
                .compare(df.dateFromString(date2)!) == NSComparisonResult.OrderedAscending {
                    
                    return "\(date1) - \(date2)"
                    
            } else {
                
                return "Open all day"
            }
            
        } else {
            
            return "Closed"
        }
    }
    
    func parseLotTimes(lotTimes: NSDictionary) {
        parsedLotTimes = ["Mon-Thur":["Open":"", "Closed":""], "Friday":["Open":"", "Closed":""], "Sat-Sun":["Open":"", "Closed":""]]
        var time: String
        
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let df = NSDateFormatter()
            df.dateFormat = "h:mm a"
            df.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        for (key, value) in lotTimes {
            // Converts values to HH:MM AM/PM format if not time
            
            if value as? String != nil {
                let tempTime = dateFormatter.dateFromString( value as! String )!
                time = df.stringFromDate(tempTime)
            } else {
                time = "Closed"
            }
            
            // Created parsed object
            
            if key.containsString("Mon_Thur_Open") {
            
                parsedLotTimes["Mon-Thur"]!["Open"]?.appendContentsOf(time)

            } else if key.containsString("Mon_Thur_Closed") {
                
                parsedLotTimes["Mon-Thur"]!["Closed"]?.appendContentsOf(time)
            
            } else if key.containsString("Fri_Open") {
                
                parsedLotTimes["Friday"]!["Open"]?.appendContentsOf(time)
                
            } else if key.containsString("Fri_Closed") {
                
                parsedLotTimes["Friday"]!["Closed"]?.appendContentsOf(time)
                
            } else if key.containsString("Sat_Sun_Open") {
                
                parsedLotTimes["Sat-Sun"]!["Open"]?.appendContentsOf(time)
                
            } else if key.containsString("Sat_Sun_Closed") {
                
                parsedLotTimes["Sat-Sun"]!["Closed"]?.appendContentsOf(time)
            }
        }
    
    }
    
    // Region: GET methods
    
    class func getLotData(lotId: Int) -> NSArray {
        
        var lotData = []
    
//        var responseString = ""
    
        let request = NSMutableURLRequest(URL: NSURL(string: "http://spacejmu.bitnamiapp.com/SPACEApiCalls/getLotData.php")!)
        
        request.HTTPMethod = "POST"
        
        let postString = "lotId=\(lotId)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let semaphore = dispatch_semaphore_create(0)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                
                print("error=\(error)")
                
                return
                
            }
            
            do {
                
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                lotData = jsonResult as! NSArray
                
//                print("data: ", lotData)
                
            } catch {
                
                print ("JSON serialization failed")
            }
            
//                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
//                    // check for http errors
//                    
//                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                    
//                    print("response = \(response)")
//                    
//                }
//                
//                responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
//                
//                print("responseString =", responseString)
            
            
            dispatch_semaphore_signal(semaphore)
            
        }
        
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        if lotId != 91235 {
            return lotData
        } else {
            print("Something went wrong when the lotId was passed in from ViewController")
            return lotData
        }
        
    }
    
    func getLotTimeForPermitType(permitType: String, lotId: Int) -> NSArray {
        
        var lotTimeForPermitType = []
               
        let request = NSMutableURLRequest(URL: NSURL(string: "http://spacejmu.bitnamiapp.com/SPACEApiCalls/getSingleLotTime.php")!)
        
        let postString = "permitType=\(permitType)&lotId=\(lotId)"
        
        request.HTTPMethod = "POST"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let semaphore = dispatch_semaphore_create(0)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                
                print("error=\(error)")
                
                return
                
            }
            
            do {
                
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                lotTimeForPermitType = jsonResult as! NSArray
                
            } catch {
                
                print ("JSON serialization failed")

            }
            
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                    // check for http errors
                    print("response: \(response)")

                }            
            
            dispatch_semaphore_signal(semaphore)
            
        }
        
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return lotTimeForPermitType
    }
    
    // Region: Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lotPropertyNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GeneralTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GeneralTableViewCell
        
        cell.lotPropertyNameLabel.text = lotPropertyNames[indexPath.row] as? String
        cell.lotPropertySpotInfoLabel.text = lotPropertyInfo[indexPath.row] as? String
        
        
        return cell
    }
    
    // Region: Picker
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userPermitTypes.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // Makes pickerView font color to purple
        var attributedString: NSAttributedString
        attributedString = NSAttributedString(string: userPermitTypes[row], attributes: [NSForegroundColorAttributeName : UIColor.purpleColor()])
        
        return attributedString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Selects permit type for lot/permit hours of availability ***Defaults to Commuter if none***
        if userPermitTypes[row] == "Red Zone" {
        
            selectedPermitType = "Red"
        
        } else if userPermitTypes[row] == "Blue Zone" {
            
            selectedPermitType = "Blue"

        } else {
            
            if selectedLotTimesForPermit != userPermitTypes {
                
                selectedPermitType = userPermitTypes[row]
            }
        }
        
        selectedLotTimesForPermit = getLotTimeForPermitType(selectedPermitType, lotId: lotId)[0] as! NSDictionary
        
        parseLotTimes(selectedLotTimesForPermit)
        hideTimeLabels()
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.updateLotTimes()
            self.showTimeLabels()
        }
        

    }

}