//
//  Database.swift
//  NRS
//
//  Created by Michael Tolfo on 2/27/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation

class Database:NSObject
{
    
    func markScoreObjectFromDatabase(descriptionIdInput:String, sessionDatabaseName: String, sessionId: String, verbalInstructionObject: VerbalInstruction)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: sessionId)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            }
            else
            {
                // The find succeeded.
                print("Successfully retrieved the object.")
                object![verbalInstructionObject.phaseDatabaseName] = descriptionIdInput
                object!.saveInBackground()
                //self.scoreObjectFromDatabase = Score(pfObject: object!)
                //object![self.verbalInstructionObjectFromSegue.phaseDatabaseName] = descriptionIdInput
                //print ("scoreObject.scoreId from getScoreObjectFromDatabase \(self.scoreObjectFromDatabase.scoreId)")
                print ("Marked \(sessionDatabaseName) as \(object![verbalInstructionObject.phaseDatabaseName])")
            }
        }
    }

}

