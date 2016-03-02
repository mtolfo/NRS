//
//  ConfirmationPopOverViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/27/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit




class ConfirmationPopOverViewController: UIViewController
{

    @IBOutlet
    weak var subphaseDescriptionLabel: UILabel!
    var subPhaseObject:Subphase! //this object is the subphase before the one on the previous view controller because we are confirming that the patient is UNABLE to do this task
    var verbalInstructionObject:VerbalInstruction!
    var sessionId:String!
    
    
    
    @IBOutlet weak var confirmationMessageLabel: UILabel!
    @IBAction func confirmButtonClicked(sender: AnyObject)
    {
        self.markScoreObjectFromDatabase(self.subPhaseObject.descriptionId, sessionDatabaseName: self.verbalInstructionObject.phaseDatabaseName)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func rejectButtonClicked(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.subphaseDescriptionLabel.text = self.subPhaseObject.description
        
        if (subPhaseObject.descriptionId == "1A")
        {
            self.confirmationMessageLabel.text = "Confirm \(self.verbalInstructionObject.phaseItem) as ABLE"
        }
        else
        {
            self.confirmationMessageLabel.text = "Confirm previous task \(self.verbalInstructionObject.phaseItem) \(self.subPhaseObject.descriptionId) as ABLE."
        }
        

    }
    
    func markScoreObjectFromDatabase(descriptionIdInput:String, sessionDatabaseName: String)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: self.sessionId)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            }
            else
            {
                // The find succeeded.
                print("Successfully retrieved the object.")
                object![self.verbalInstructionObject.phaseDatabaseName] = descriptionIdInput
                object!.saveInBackground()
                //self.scoreObjectFromDatabase = Score(pfObject: object!)
                //object![self.verbalInstructionObjectFromSegue.phaseDatabaseName] = descriptionIdInput
                //print ("scoreObject.scoreId from getScoreObjectFromDatabase \(self.scoreObjectFromDatabase.scoreId)")
                print ("Marked \(sessionDatabaseName) as \(object![self.verbalInstructionObject.phaseDatabaseName])")
            }
        }
        
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showTableViewFromConfirmView"
        {
            
        }
    }
    

}
