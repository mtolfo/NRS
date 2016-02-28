//
//  NewEvalViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/5/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

protocol NewEvalViewControllerDelegate
{
    func getNewEvalSessionId(sessionId:String)
}




class NewEvalViewController: UIViewController, UIPickerViewDataSource ,UIPickerViewDelegate
{
    private var versionsArray = [Version]()
    private var previousVersionsArrayString = [String]()
    private var currentVersionArray = [Version]()
    private var previousVersionArray = [Version]()
    private var currentVersion: String?
    private var selectedPreviousVersion: String?
    private var selectedVersionAfterDoneButtonClick = ""
    private var phaseItemArray = [PhaseItem]()
    //private var startingPhaseItemDatabaseName = ""
    private var startingPhaseItemName = (databaseName: "", regularName: "")
    private var sessionId = ""
    private var temp = ""
    //var newEvalVcDelegate:NewEvalViewControllerDelegate? = nil
    
    
    var currentObject: PFObject?
    var newEvalScoreSessionPfObject:PFObject?
    
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

            self.currentVersionLabel.text = "\(self.currentVersionArray[0].version): \(formattedStartDate.startDateString)-Today"
        case 1:
            self.versionPicker.hidden = false
            self.currentVersionLabel.hidden = true
            getPreviousVersionsFromArray()
            
            //this is to initialize picker default in case no selection is made in the picker
            self.selectedPreviousVersion = self.previousVersionArray[0].version
            
            versionPicker.reloadAllComponents()
        default:
            break
        }
        self.newEvalDoneButton.hidden = false
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject)
    {
        self.selectedVersionAfterDoneButtonClick = getSelectedVersion()
        self.startingPhaseItemName = getStartingPhaseItem()
        print ("In NewEvalViewController self.startingPhaseitemName \(self.startingPhaseItemName)")
        self.createNewEvalScoreSession()
    }
    
    func createNewEvalScoreSession()
    {
        let noScore = ""
        let scoreSession = Score(/*scoreIdInit: noScore, */sitInit: noScore, reverseSitUpInit: noScore, sitUpInit: noScore, trunkExtensionInSittingInit: noScore, overheadPressInit: noScore, forwardReachAndGraspInit: noScore, doorPullAndOpenInit: noScore, canOpenAndManipulationInit: noScore, sitToStandInit: noScore, standInit: noScore, walkingInit: noScore, standAdaptabilityInit: noScore, stepRetrainingInit: noScore, stepAdaptabilityInit: noScore, versionInit: self.selectedVersionAfterDoneButtonClick)
        
        self.newEvalScoreSessionPfObject = scoreSession.toPfObject()
        self.newEvalScoreSessionPfObject!.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
            if (error == nil)
            {
                print ("BEGIN generate object id")
                print("New Score with session saved: \(self.newEvalScoreSessionPfObject?.objectId as String!)")
                
                //using singleton to use in subphase detail view controller because I cannot pass the
                //object id through the segue AFTER this code block completes. 
                NewEvalSessionId.sharedInstance.sessionId = self.newEvalScoreSessionPfObject?.objectId as String!
                
                
                print ("END generate object id")
                
            }
            else
            {
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        })
    }
    
    func tempCreateNewEvalScoreSession()
    {
        
        let noScore = ""
        let scoreSession = Score(/*scoreIdInit: noScore, */sitInit: noScore, reverseSitUpInit: noScore, sitUpInit: noScore, trunkExtensionInSittingInit: noScore, overheadPressInit: noScore, forwardReachAndGraspInit: noScore, doorPullAndOpenInit: noScore, canOpenAndManipulationInit: noScore, sitToStandInit: noScore, standInit: noScore, walkingInit: noScore, standAdaptabilityInit: noScore, stepRetrainingInit: noScore, stepAdaptabilityInit: noScore, versionInit: self.selectedVersionAfterDoneButtonClick)
        
        self.newEvalScoreSessionPfObject = scoreSession.toPfObject()
        
        
    }

    
    
    //to fix the label size use label.adjustsFontSizeToFitWidth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllVersionsFromParse()
        loadPhaseItemsFromParse()

        self.currentVersionLabel.text = self.currentVersion
//        getCurrentVersionFromArray()
//        self.currentVersionLabel.text = self.currentVersionArray[0].version
        
        self.versionPicker.delegate = self
        self.versionPicker.dataSource = self
        
        self.versionSegmentedControl.selectedSegmentIndex = -1
        self.versionPicker.hidden = true
        self.currentVersionLabel.adjustsFontSizeToFitWidth = true
        self.newEvalDoneButton.hidden = true
    }
    
    
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

    func getPreviousVersionsFromArray()
    {
        previousVersionArray.removeAll()
        let filteredArray = self.versionsArray.filter({$0.isCurrentVersion == false})
        for element in filteredArray
        {
            previousVersionArray.append(element)
        }
    }
    
    //returns the phase item that has a phaseOrder of 1. This will be the default phase item for any new evaluation
    func getStartingPhaseItemFromArray() -> String
    {
        let filteredArray = self.phaseItemArray.filter({$0.phaseOrder == 1})
        return filteredArray[0].phaseDatabaseName
    }
    
    func getStartingPhaseItem() -> (databaseName: String, regularName: String)
    {
        let filteredArray = self.phaseItemArray.filter({$0.phaseOrder == 1})
        return (filteredArray[0].phaseDatabaseName, filteredArray[0].phaseItem)
    }
    
    func AddAndSubtractTenFromNumber(number: Int) -> (small: Int, large: Int)
    {
        let smallResult = (number - 10)
        let largeResult = (number + 10)
        
        return (smallResult, largeResult)
    }
    
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
//                        print(versionObject.version)
//                        print(versionObject.startDate)
//                        print(versionObject.endDate)
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
    
    func loadPhaseItemsFromParse()
    {
        let query = PFQuery(className: "Phase_Items")
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            if error ==  nil
            {
                if let objects = objects
                {
                    for object in objects
                    {
                        let phaseItemObject = PhaseItem(pfObject: object)
                        self.phaseItemArray.append(phaseItemObject)
                    }
                }
                else
                {
                    print ("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
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
        for element in self.previousVersionsArrayString
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
        return self.previousVersionArray.count
    }

    /* better memory management version
     change attributes of the text in the picker */
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()}
        let formattedDate = formatDates(self.previousVersionArray[row].startDate, endDate:self.previousVersionArray[row].endDate)
        
        let titleData = "\(self.previousVersionArray[row].version): \(formattedDate.startDateString)-\(formattedDate.endDateString)"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 16.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
        
    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPreviousVersion = self.previousVersionArray[self.versionPicker.selectedRowInComponent(0)].version
    }
    
    // to be used in the Done button
    func getSelectedVersion() -> String
    {
        var selectedVersion = ""
        
        switch (self.versionSegmentedControl.selectedSegmentIndex)
        {
        case 0:
//            selectedVersion = self.currentVersionLabel.text!
            selectedVersion = self.currentVersionArray[0].version
        case 1: //self.selectedPrevious version comes from pickerView didSelectRow delegate
            selectedVersion = self.selectedPreviousVersion!
        default:
            break
        }
        return selectedVersion
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "showNewEvalSubphases"
        {
            let destinationController = segue.destinationViewController as! SubphaseViewController
            destinationController.navigationItem.title = "\(self.startingPhaseItemName.regularName)"
            //TODO: self.startingPhaseItem should be the database name
            destinationController.phaseNameFromSegue = self.startingPhaseItemName.databaseName
            //destinationController.sessionIdFromSegue = self.newEvalScoreSessionPfObject?.objectId as String!
            
            
            
            
        }
    }
}
