//
//  SubPhaseDetailViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/8/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class SubPhaseDetailViewController: UIViewController
{
    var subPhaseFromSegue:Subphase!
    var scoreObjectFromDatabase:Score!
    var phaseDatabaseNameFromSegue:String?
    var verbalInstructionArray = [VerbalInstruction]()
    var verbalInstructionFromSegue:String?
    var sessionIdFromSegue:String?
    var verbalInstructionObjectFromSegue:VerbalInstruction!
   
    
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
        self.getScoreObjectFromDatabase(self.sessionIdFromSegue!)
        //print(self.scoreObjectFromDatabase)
        print ("END VIEW DID LOAD")
    }
    
//    func getScoreObectFromDatabase(sessionIdInput:String) -> Score!
//    {
//        var scoreObject:Score!
//        
//        let query = PFQuery(className: "Scores")
//        query.whereKey("objectId", equalTo: sessionIdInput)
//        query.getFirstObjectInBackgroundWithBlock {
//            (object: PFObject?, error: NSError?) -> Void in
//            if error != nil || object == nil {
//                print("The getFirstObject request failed.")
//            } else {
//                // The find succeeded.
//                print("Successfully retrieved the object.")
//                scoreObject = Score(pfObject: object!)
//                print ("scoreObject.scoreId from getScoreObjectFromDatabase \(scoreObject.scoreId)")
//            }
//        }
//        return scoreObject
//    }
    
    
    func getScoreObjectFromDatabase(sessionIdInput:String)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: sessionIdInput)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                self.scoreObjectFromDatabase = Score(pfObject: object!)
                print ("scoreObject.scoreId from getScoreObjectFromDatabase \(self.scoreObjectFromDatabase.scoreId)")
            }
        }

    }
    
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
    
    
    //save where object id
    func scoreSubphaseDescriptionId(scorePfObject: PFObject, descriptionIdInput: String)
    {
        //var pointer = PFObject .objectForKey(<#T##PFObject#>)
        
//        // Create a pointer to an object of class Point with id dlkj83d
//        PFObject *point = [PFObject objectWithoutDataWithClassName:@"Point" objectId:@"dlkj83d"];
//        
//        // Set a new value on quantity
//        [point setObject:@6 forKey:@"quantity"];
//        
//        // Save
//        [point save];
        
    }
    
    
//    func scoreSubphaseDescriptionId(scoreObject: Score, sessionIdInput: String, subphaseDescriptionId: String, sessionDatabaseName: String)
//    {
//        //score the subphase within the session with the subphaseDescriptionId
//        //scoreObject.["sessionDatabaseName"] = sessionIdInput
//        let query = PFQuery(className: "Scores")
//        query.whereKey(scoreObject.scoreId, equalTo: sessionIdInput)
//        
//        scoreObjectFromDatabase.toPfObject().saveInBackgroundWithBlock ({ (success, error) -> Void in
//            if (success)
//            {
//                print ("Successfully updated the trip")
//            }
//            else
//            {
//                print("Error: \(error?.description)")
//            }
//        })
//        
//    }

    
    //        trips[indexPath.row].toPFObject().saveInBackgroundWithBlock({ (success,
    //            error) -> Void in
    //            if (success) {
    //            print("Successfully updated the trip")
    //        } else {
    //            print("Error: \(error?.description)")
    //            } })
    
//    func getDatabaseNameFromSubPhaseNameFromDatabase()
//    {
//        //maybe use VerbalInstruction model
//        let query = PFQuery(className: String)
//    }
    
   
    override func didReceiveMemoryWarning()
    {
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
