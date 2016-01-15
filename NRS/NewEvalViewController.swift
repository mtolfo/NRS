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
    
    var blurEffectView:UIVisualEffectView?
    
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
            print ("From segmented control")
            versionPicker.hidden = false
            currentVersionLabel.hidden = true
            loadVersionsFromParse()
            versionArrayCheck()
            //versionPicker.reloadAllComponents()
        default:
            break
        }
    }
    
    
    
    //to fix the label size use label.adjustsFontSizeToFitWidth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.versionPicker.delegate = self
        self.versionPicker.dataSource = self
        
        backgroundImageView.image = UIImage(named: "cloudNRSred")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)//       
        
        self.versionSegmentedControl.selectedSegmentIndex = 0
        self.versionPicker.hidden = true
        
        self.currentVersionLabel.text = "I am the current version"
        self.currentVersionLabel.adjustsFontSizeToFitWidth = true
        
        print("In viewDidLoad")
        //loadVersionsFromParse()
        //versionArrayCheck()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //picker delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        return self.versionsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.versionsArray[row].version
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = self.versionsArray[row].version
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return myTitle
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
