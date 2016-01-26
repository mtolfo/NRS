//
//  SessionInputViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/15/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class SessionInputViewController: UIViewController
{
    private var sessionArray = [Session]()
    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet weak var sessionTextField: UITextField!

    @IBOutlet weak var sessionUsedLabel: UILabel!
   
    
    var blurEffectView:UIVisualEffectView!
    
    
    @IBAction func sessionEnteredButtonClick(sender: AnyObject)
    {
        print("HELLO")
        //add session to Parse 
        loadSessionFromParse()
        
        //go to the appropriate view controller
        //sessionUsedLabel.text = "Session used: \(sessionArray[0].sessionId)"
    }
    
    // loads the session from user input into an array
    func loadSessionFromParse()
    {
        let query = PFQuery(className: "Session")
        query.whereKey("objectId", equalTo: sessionTextField.text!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil
            {
                if let objects = objects
                {
                    for object in objects
                    {
                        let sessionObject = Session(pfObject: object)
                        print("Printing session ID: \(sessionObject.sessionId)")
                        self.sessionArray.append(sessionObject)
                    }
                }
            }
            else
            {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
//        
//        if error == nil
//            {
//                print("Successfully retrieved \(objects!.count) versions.")
//                
//                if let objects = objects
//                {
//                    for object in objects
//                    {
//                        //print(object.objectId)
//                        let versionObject = Version(pfObject: object)
//                        print(versionObject.version)
//                        print(versionObject.startDate)
//                        print(versionObject.endDate)
//                        //print(versionObject.isCurrentVersion)
//                        self.versionsArray.append(versionObject)
//                    }
//                }
//                else
//                {
//                    print ("Error: \(error!) \(error!.userInfo)")
//                }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundImageView.image = UIImage(named: "cloudNRSred")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
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
