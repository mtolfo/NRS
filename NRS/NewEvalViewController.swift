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
            self.currentVersionLabel.text = self.currentVersion
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
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        self.selectedVersionAfterDoneButtonClick = getSelectedVersion()
        print("This is the slected version \(self.selectedVersionAfterDoneButtonClick)")
        
        //TODO: Create a new row in Sessions table with the selected version. At this point we know this 
        //is a new eval with a new session.
    }
    
    
    //to fix the label size use label.adjustsFontSizeToFitWidth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVersionsFromParse()

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
    
    func loadCurrentVersionFromParse()
    {
        //self.versionsArray.removeAll()
        let query = PFQuery(className: "Version")
        query.whereKey("isCurrentVersion", equalTo: true)
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            if error == nil
            {
                print("Successfully retrieved \(objects!.count) versions.")
                for object in objects!
                {
                    self.currentObject = object
                }
                //self.currentVersionLabel.text = self.currentObject?.valueForKey("isCurrentVersion") as? String
                //print (self.currentObject?["version"] as? String)
                //self.currentVersionLabel.text = self.currentObject!["version"] as? String
                self.currentVersion = self.currentObject!["version"] as? String
                print ("Using: \(self.currentObject?.valueForKey("version") as? String)")
            }
        }
    }
    
    // get current version from the initiallized array so 
    // we don't have to do another load from Parse
    func getCurrentVersionFromArray()
    {
        let filteredArray = self.versionsArray.filter({$0.isCurrentVersion == true})
        for element in filteredArray
        {
            print(element.version)
            self.currentVersion = element.version
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
            self.previousVersionsArray.append(element.version)
        }
    }
    
    
    //using parse documentation
    func loadVersionsFromParse()
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
            print (versionElement.version)
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
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        //words in picker view have a white color
        let titleData = self.previousVersionsArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return myTitle
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedPreviousVersion = self.previousVersionsArray[self.versionPicker.selectedRowInComponent(0)]
    }

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
