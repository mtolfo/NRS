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
        scoreObjectFromDatabase = getScoreObectFromDatabase(self.sessionIdFromSegue!)
        print ("Score object from database: \(scoreObjectFromDatabase.stand)") //gettin nil here for same reason as before, block not executed yet
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = subPhaseFromSegue.descriptionId
        self.verbalInstructionLabel.text = verbalInstructionFromSegue
        self.subPhaseDescriptionLabel.text = subPhaseFromSegue.description
        
        // if the session id is not coming from the in progress screen the use the singleton for the session id
        if (self.sessionIdFromSegue ==  nil)
        {
            self.sessionIdFromSegue = NewEvalSessionId.sharedInstance.sessionId
        }
        
        
    
    }
    
    func getScoreObectFromDatabase(sessionIdInput:String) -> Score!
    {
        var scoreObject:Score!
        
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: sessionIdInput)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                scoreObject = Score(pfObject: object!)
                print ("scoreObject.scoreId from getScoreObjectFromDatabase \(scoreObject.scoreId)")
            }
        }
        return scoreObject
    }
    
   
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
