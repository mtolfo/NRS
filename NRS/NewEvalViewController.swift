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

    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet weak var versionPicker: UIPickerView!
    @IBOutlet weak var versionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var currentVersionLabel: UILabel!
    
    @IBAction func segmentControlIndexChanged(sender: AnyObject)
    {
        switch (versionSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            versionPicker.hidden = true
            currentVersionLabel.hidden = false
        case 1:
            versionPicker.hidden = false
            currentVersionLabel.hidden = true
            loadVersionsFromParse()
        default:
            break
        }
    }
    //using the Version.swift class to populate the array. Probably
    //should create a property for this class
    /*let versionPickerData = [Version(versionId: "14V3", version: "2014 V3"),
        Version(versionId: "15V1", version: "2015 V1"),
        Version (versionId: "15V2", version: "2015 V2")]*/
    //var versionDataStoreFromVC: VersionDataStore!
    //let newEvalVersionDataStore = VersionDataStore.init()
    //let newEvalVersionDataStore = VersionDataStore()
    
    
    
    var blurEffectView:UIVisualEffectView?
    
    //to fix the label size use label.adjustsFontSizeToFitWidth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.versionPicker.delegate = self
        self.versionPicker.dataSource = self
        
        backgroundImageView.image = UIImage(named: "cloudNRSred")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.opaque = true
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
        
        self.versionSegmentedControl.selectedSegmentIndex = 0
        self.versionPicker.hidden = true
        
        self.currentVersionLabel.text = "I am the current version"
        self.currentVersionLabel.adjustsFontSizeToFitWidth = true
        
        loadVersionsFromParse()
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
                        print(object.objectId)
                        let versionObject = Version(pfObject: object)
                        print(versionObject.version)
                        print(versionObject.isCurrentVersion)
                        self.versionsArray.append(versionObject)
                    }
                }
                else
                {
                    print ("Error: \(error!) \(error!.userInfo)")
                }
                
                for versionElement in self.versionsArray
                {
                    print (versionElement.version)
                }
            }
        }
        versionPicker.reloadAllComponents()
    }
    
    /*
    //Create an empty array
    var myArray: [String] = [String]()
    
    //Get the data from the PFQuery class
    var query = PFQuery(className: "ClassName")
    query.findObjectsInBackgroundWithBlock{
    (objects: [AnyObject]?, error: NSError?) -> Void in
    if error == nil {
    if let objects = objects as? [PFObject] {
    for object in objects {
    
    //For each object in the class object, append it to myArray
    self.myArray.append(object.objectForKey("ClassNameObject") as! String)
    
    }
    
    }
    } else {
    println("\(error?.userInfo)")
    }
    }
*/

/*
//using appcoda and some blogs
    func loadVersionsFromParse()
    {
        versionsArray.removeAll(keepCapacity: true)
        let query = PFQuery(className: "Version")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let error = error
            {
                print ("Error: \(error) \(error.userInfo)")
                return
            }
            
            if error ==  nil
            {
                for object in objects!
                {
                    let version = Version(pfObject: object)
                    self.versionsArray.append(version)
                }
            }
        }
        self.versionPicker.reloadAllComponents()
        
    }
*/
        
        /*
        versionsArray.removeAll(keepCapacity: true)
        
        //pull data from Parse
        let query = PFQuery(className: "Version")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let error = error
            {
                print("Error: \(error) \(error.userInfo)")
                return
            }
            
            if let objects = objects
            {
                for object in objects.enumerate()
                {
                    let version = Version(pfObject: object)
                    self.versionsArray.append(version)
                }
            }
            return versionArray
            
        
            if let objects = objects
            {
            
                for (index, object) in objects.enumerate()
                {
                    //convert PFObject into Trip object
                    let version = Version(pfObject: object)
                    self.versionsArray.append(version)
                    
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                }
                */
                //versionsArray = [objects valueForKey:,@ "version"]
                
    

    
    //picker delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.versionsArray.count
        //return versionPickerData.count
        //return newEvalVersionDataStore.allVersions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.versionsArray[row].version
        //return versionPickerData[row].version
        //return newEvalVersionDataStore.allVersions[row].version
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = self.versionsArray[row].version
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return myTitle
        
        
        /*
        // using hard coded version array
        let titleData = versionPickerData[row].version
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return myTitle
        */

        
        /* // using class
        let titleData = newEvalVersionDataStore.allVersions[row].version
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return myTitle
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
