//
//  NewEvalViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/5/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class NewEvalViewController: UIViewController, UIPickerViewDataSource ,UIPickerViewDelegate
{
    private var versionsArray = [Version]()
    private var previousVersionsArray = [String]()
    private var currentVersionArray = [Version]()
    private var currentVersion: String?
    private var selectedPreviousVersion: String?
    private var selectedVersionAfterDoneButtonClick = ""
    var currentObject: PFObject?
    
    var blurEffectView:UIVisualEffectView?
    
    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet weak var versionPicker: UIPickerView!
    @IBOutlet weak var versionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var currentVersionLabel: UILabel!
    @IBOutlet weak var newEvalDoneButton: UIButton!
    
    @IBAction func segmentControlIndexChanged(sender: AnyObject)
    {
        switch (versionSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            self.versionPicker.hidden = true
            self.currentVersionLabel.hidden = false
            getCurrentVersionFromArray()
            let formattedStartDate = formatDates(self.currentVersionArray[0].startDate, endDate: self.currentVersionArray[0].endDate)
            self.currentVersionLabel.text = "\(self.currentVersionArray[0].version): \(formattedStartDate.startDateString)"
        case 1:
            self.versionPicker.hidden = false
            self.currentVersionLabel.hidden = true
            getPreviousVersionsFromArray()
            
            //this is to initialize picker default in case no selection is made in the picker
            self.selectedPreviousVersion = self.previousVersionsArray[0]
            
            versionPicker.reloadAllComponents()
        default:
            break
        }
        self.newEvalDoneButton.hidden = false
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject)
    {
        self.selectedVersionAfterDoneButtonClick = getSelectedVersion()
        print("This is the slected version \(self.selectedVersionAfterDoneButtonClick)")
        
        //TODO: Create a new row in Sessions table with the selected version. At this point we know this 
        //is a new eval with a new session.
        
//        var gameScore = PFObject(className:"GameScore")
//        gameScore["score"] = 1337
//        gameScore["playerName"] = "Sean Plott"
//        gameScore["cheatMode"] = false
//        gameScore.saveInBackgroundWithBlock {
//            (success: Bool, error: NSError?) -> Void in
//            if (success) {
//                // The object has been saved.
//            } else {
//                // There was a problem, check error.description
//            }
//        }
        
    }
    
    
    //to fix the label size use label.adjustsFontSizeToFitWidth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllVersionsFromParse()

        self.currentVersionLabel.text = self.currentVersion
        
        self.versionPicker.delegate = self
        self.versionPicker.dataSource = self
        
        backgroundImageView.image = UIImage(named: "cloudNRSred")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
        
        self.versionSegmentedControl.selectedSegmentIndex = -1
        self.versionPicker.hidden = true
        self.currentVersionLabel.adjustsFontSizeToFitWidth = true
        self.newEvalDoneButton.hidden = true
    }
    
    /*
    // get current version from the initiallized array so 
    // we don't have to do another load from Parse
    func getCurrentVersionFromArray()
    {
        let filteredArray = self.versionsArray.filter({$0.isCurrentVersion == true})
        for element in filteredArray
        {
            
            let formattedStartDate = NSDateFormatter.localizedStringFromDate(element.startDate, dateStyle: .ShortStyle, timeStyle: .NoStyle)
            print("\(element.version) \(formattedStartDate)")
            self.currentVersion = "\(element.version): \(formattedStartDate) - Today"
        }
        
    }
*/
    
    //NEW BRANCH: 
    func getCurrentVersionFromArray()
    {
        let filteredArray = self.versionsArray.filter({$0.isCurrentVersion == true})
        if filteredArray.count > 1
        {
            let alertController = UIAlertController(title: "Current Version Message", message:
                "More than one current version exists in database. Talk to administrator.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        for element in filteredArray
        {
            currentVersionArray.append(element)
        }
    }
    
    // get previous versions from the initiallized array so
    // we don't have to do another load from Parse
    func getPreviousVersionsFromArray()
    {
        self.previousVersionsArray.removeAll()
        let filteredArray = self.versionsArray.filter({$0.isCurrentVersion ==  false})
        for element in filteredArray
        {
            
            let formattedStartDate = NSDateFormatter.localizedStringFromDate(element.startDate, dateStyle: .ShortStyle, timeStyle: .NoStyle)
            let formattedEndDate = NSDateFormatter.localizedStringFromDate(element.endDate, dateStyle: .ShortStyle, timeStyle: .NoStyle)
            self.previousVersionsArray.append("\(element.version): \(formattedStartDate) - \(formattedEndDate)")
        }
    }
    
//    func printDate(date: NSDate, format: String = "YY/MM/dd") -> String {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.stringFromDate(date)
//    }
    func formatDates(startDate: NSDate, endDate: NSDate) -> (startDateString:String, endDateString: String)
    {
        let startDateFormatter = NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        let endDateFormatter = NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        
        return (startDateFormatter, endDateFormatter)
    }
    
    
    //using parse documentation
    func loadAllVersionsFromParse()
    {
        let query = PFQuery(className: "Version")
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            if error == nil
            {
                print("Successfully retrieved \(objects!.count) versions.")
                
                if let objects = objects
                {
                    for object in objects
                    {
                        //print(object.objectId)
                        let versionObject = Version(pfObject: object)
                        print(versionObject.version)
                        print(versionObject.startDate)
                        print(versionObject.endDate)
                        //print(versionObject.isCurrentVersion)
                        self.versionsArray.append(versionObject)
                    }
                }
                else
                {
                    print ("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
        versionPicker.reloadAllComponents()
    }
    
    
    func versionArrayCheck()
    {
        print ("Version Array Check")
        for versionElement in self.versionsArray
        {
            print (versionElement.version, " ", versionElement.startDate)
        }
    }
    
    func previousVersionsArrayCheck()
    {
        print("Previous Versions Array Check")
        for element in self.previousVersionsArray
        {
            print(element)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //picker delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
//        return self.versionsArray.count
        return self.previousVersionsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return self.versionsArray[row].version
        return self.previousVersionsArray[row]
    }
    
    /* better memory management version
     change attributes of the text in the picker */
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()}
//            //color the label's background
//            let hue = CGFloat(row)/CGFloat(self.previousVersionsArray.count)
//            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
//        }
        let titleData = self.previousVersionsArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 16.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
        
    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedPreviousVersion = self.previousVersionsArray[self.versionPicker.selectedRowInComponent(0)]
    }
    
    /* Returns a string for output for the currentLabel text or the text in the UIPicker. Currently
        not something that can be saved to the database becuase the version and the date must be seperate

    */
    func getSelectedVersion() -> String
    {
        var selectedVersion = ""
        
        switch (self.versionSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            selectedVersion = self.currentVersionLabel.text!
        case 1: //self.selectedPrevious version comes from pickerView didSelectRow delegate
            selectedVersion = self.selectedPreviousVersion!
        default:
            break
        }
        return selectedVersion
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNewEvalSubphases"
        {
            let destinationController = segue.destinationViewController as! SubphaseViewController
            destinationController.destinationTempString = "This is the passed data."
            
            destinationController.navigationItem.title = "New Eval \(selectedVersionAfterDoneButtonClick)"
        }
    }

   
}
