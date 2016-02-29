//
//  SubPhaseDetailViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/8/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class SubPhaseDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    var subPhaseFromSegue:Subphase!
    var scoreObjectFromDatabase:Score!
    var phaseDatabaseNameFromSegue:String?
    var verbalInstructionArray = [VerbalInstruction]()
    //var verbalInstructionFromSegue:String?
    var sessionIdFromSegue:String?
    var verbalInstructionObjectFromSegue:VerbalInstruction!
    var subPhaseArray = [Subphase]()
    var subPhaseArrayIndex:Int = 0
   
    
    @IBOutlet weak var verbalInstructionLabel: UILabel!
    @IBOutlet weak var subPhaseDescriptionLabel: UILabel!
    @IBOutlet weak var unableButton: UIButton!
    @IBOutlet weak var ableButton: UIButton!
    @IBOutlet weak var manualButton: UIButton!
    @IBOutlet weak var playVideoButton: UIButton!

    @IBAction func manualButtonPressed(sender: AnyObject)
    {
        print("HELLO MANUAL BUTTON")
        
        print("Session Id: \(self.sessionIdFromSegue)")
        //scoreObjectFromDatabase = getScoreObectFromDatabase(self.sessionIdFromSegue!)
        //print ("Score object from database: \
        //(scoreObjectFromDatabase.stand)") //gettin nil here for same reason as before, block not executed yet
        //self.scoreObjectFromDatabase = getScoreObectFromDatabase(self.sessionIdFromSegue!)

        //print(scoreObjectFromDatabase)
        print ("Verbal instruction object: \(self.verbalInstructionObjectFromSegue.phaseDatabaseName)")
        self.markScoreObjectFromDatabase(self.subPhaseFromSegue.descriptionId, sessionDatabaseName: self.verbalInstructionObjectFromSegue.phaseDatabaseName)
        print ("END DONE BUTTON")
    }

    // TODO: Problem with Stand_Adaptability in Model
    @IBAction func ableButtonClicked(sender: AnyObject)
    {
        self.subPhaseArrayIndex += 1
        self.subPhaseDescriptionLabel.text = self.subPhaseArray[self.subPhaseArrayIndex].description
        self.navigationItem.title = self.subPhaseArray[self.subPhaseArrayIndex].descriptionId
    }
    
    func getStartingIndex(subphaseDescriptionIdInput: String, subPhaseArrayInput: [Subphase]) -> Int?
    {
        
        return subPhaseArrayInput.indexOf({$0.descriptionId == subphaseDescriptionIdInput})!
    }
    
    @IBAction func unableButtonClicked(sender: AnyObject)
    {
        self.shouldPerformSegueWithIdentifier("showConfirmationPopOver", sender: self)
        //self.performSegueWithIdentifier("showConfirmationPopOver", sender: self)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = subPhaseFromSegue.descriptionId
        //self.verbalInstructionLabel.text = verbalInstructionFromSegue
        self.verbalInstructionLabel.text = self.verbalInstructionObjectFromSegue.verbalInstruction
        self.subPhaseDescriptionLabel.text = subPhaseFromSegue.description
        
        // if the session id is not coming from the in progress screen the use the singleton for the session id
        if (self.sessionIdFromSegue ==  nil)
        {
            self.sessionIdFromSegue = NewEvalSessionId.sharedInstance.sessionId
        }
        //self.scoreObjectFromDatabase = getScoreObectFromDatabase(self.sessionIdFromSegue!)
        //self.getScoreObectFromDatabase(self.sessionIdFromSegue!)
        //self.getScoreObjectFromDatabase(self.sessionIdFromSegue!)
        //print(self.scoreObject˚FromDatabase)
        self.subPhaseArrayIndex = getStartingIndex(self.subPhaseFromSegue.descriptionId, subPhaseArrayInput: self.subPhaseArray)!
        self.getScoreObject(self.sessionIdFromSegue!)
        print ("END VIEW DID LOAD")
        
    }
    
    
//    func getScoreObjectFromDatabase(sessionIdInput:String)
//    {
//        let query = PFQuery(className: "Scores")
//        query.whereKey("objectId", equalTo: sessionIdInput)
//        query.getFirstObjectInBackgroundWithBlock {
//            (object: PFObject?, error: NSError?) -> Void in
//            if error != nil || object == nil {
//                print("The getFirstObject request failed.")
//            } else {
//                // The find succeeded.
//                print("Successfully retrieved the object.")
//                self.scoreObjectFromDatabase = Score(pfObject: object!)
//                print ("scoreObject.scoreId from getScoreObjectFromDatabase \(self.scoreObjectFromDatabase.scoreId)")
//            }
//        }
//
//    }
    
    func markScoreObjectFromDatabase(descriptionIdInput:String, sessionDatabaseName: String)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: self.sessionIdFromSegue!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            }
            else
            {
                // The find succeeded.
                print("Successfully retrieved the object.")
                object![self.verbalInstructionObjectFromSegue.phaseDatabaseName] = descriptionIdInput
                object!.saveInBackground()
                //self.scoreObjectFromDatabase = Score(pfObject: object!)
                //object![self.verbalInstructionObjectFromSegue.phaseDatabaseName] = descriptionIdInput
                //print ("scoreObject.scoreId from getScoreObjectFromDatabase \(self.scoreObjectFromDatabase.scoreId)")
                print ("Marked \(sessionDatabaseName) as \(object![self.verbalInstructionObjectFromSegue.phaseDatabaseName])")
            }
        }
        
    }
    
    func getScoreObject(sessionIdInput: String)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: self.sessionIdFromSegue!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getScoreObject request failed.")
            }
            else
            {
                self.scoreObjectFromDatabase = Score(pfObject: object!)
            }
        }
        
    }
    
    
   
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //validation to prevent segue
//    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool
//    {
//        if identifier == "showInProgressPhases"
//        {
//            //use "sessionTextField.text!" instead of backing variable "sessionIdText" for validation
//            if (sessionTextField.text!.isEmpty || !scoreArray.contains({$0.scoreId == sessionTextField.text!}))
//            {
//                let alertController = UIAlertController(title: "Session Does Not Exist", message:
//                    "The session id you have entered does not exist in the database.", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
//                self.presentViewController(alertController, animated: true, completion: nil)
//                return false
//            }
//            else
//            {
//                return true
//            }
//        }
//        
//        //by default, do the transition
//        return true
//    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "showConfirmationPopOver"
        {
            // if any of the subphases have been scored as unable, send a warning that cannot 
            if (self.scoreObjectFromDatabase.scoreId != "")
            {
                print ("Score id exists.")
                return false
            }
        }
        return false
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier ==  "showConfirmationPopOver"
        {
            let destinationVc = segue.destinationViewController as! ConfirmationPopOverViewController
            
            let controller = destinationVc.popoverPresentationController
            if controller != nil
            {
                controller?.delegate = self
            }
            
            //Popover only shows during confirmation that a subPhase is UNABLE so
            //we need the index before the one that is in the SubPhaseDetailVC
            destinationVc.subPhaseObject = self.subPhaseArray[subPhaseArrayIndex - 1]
            destinationVc.verbalInstructionObject = self.verbalInstructionObjectFromSegue
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
    }
    
    
    }
