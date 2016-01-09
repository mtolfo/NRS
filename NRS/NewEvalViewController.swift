//
//  NewEvalViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/5/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class NewEvalViewController: UIViewController, UIPickerViewDataSource ,UIPickerViewDelegate {

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
        default:
            break
        }
    }
    //using the Version.swift class to populate the array. Probably
    //should create a property for this class
    let versionPickerData = [Version(versionId: "14V3", version: "2014 V3"),
        Version(versionId: "15V1", version: "2015 V1"),
        Version (versionId: "15V2", version: "2015 V2")]
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
        
        
    
        
    }
    
    //picker delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return versionPickerData.count
        //return newEvalVersionDataStore.allVersions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return versionPickerData[row].version
        //return newEvalVersionDataStore.allVersions[row].version
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        
        let titleData = versionPickerData[row].version
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return myTitle

        
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
