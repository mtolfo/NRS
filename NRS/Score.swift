//
//  Score.swift
//  NRS
//
//  Created by Michael Tolfo on 1/26/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class Score: NSObject
{
    //change these to empty string ""
//    var scoreId: String?
//    var sit: String?
//    var reverseSitUp: String?
//    var sitUp: String?
//    var trunkExtensionInSitting: String?
//    var overheadPress: String?
//    var forwardReachAndGrasp: String?
//    var doorPullAndOpen: String?
//    var canOpenAndManipulation: String?
//    var sitToStand: String?
//    var stand: String?
//    var walking: String?
//    var standAdaptability: String?
//    var stepRetraining: String?
//    var stepAdaptability: String?
    
    var scoreId = ""
    var sit = ""
    var reverseSitUp = ""
    var sitUp = ""
    var trunkExtensionInSitting = ""
    var overheadPress = ""
    var forwardReachAndGrasp = ""
    var doorPullAndOpen = ""
    var canOpenAndManipulation = ""
    var sitToStand = ""
    var stand = ""
    var walking = ""
    var standAdaptability = ""
    var stepRetraining = ""
    var stepAdaptability = ""
    var version = ""
    
//    7DFJDjDChM
    
    init(/*scoreIdInit: String,*/ sitInit: String, reverseSitUpInit: String, sitUpInit: String, trunkExtensionInSittingInit: String, overheadPressInit: String, forwardReachAndGraspInit: String, doorPullAndOpenInit: String, canOpenAndManipulationInit:String, sitToStandInit: String, standInit: String, walkingInit: String, standAdaptabilityInit: String, stepRetrainingInit: String, stepAdaptabilityInit: String, versionInit: String)
    {
        //self.scoreId = scoreIdInit
        self.sit = sitInit
        self.reverseSitUp = reverseSitUpInit
        self.sitUp = sitUpInit
        self.trunkExtensionInSitting = trunkExtensionInSittingInit
        self.overheadPress = overheadPressInit
        self.forwardReachAndGrasp = forwardReachAndGraspInit
        self.doorPullAndOpen = doorPullAndOpenInit
        self.canOpenAndManipulation = canOpenAndManipulationInit
        self.sitToStand = sitToStandInit
        self.stand = standInit
        self.walking = walkingInit
        self.standAdaptability = standAdaptabilityInit
        self.stepRetraining = stepRetrainingInit
        self.stepAdaptability = stepAdaptabilityInit
        self.version = versionInit
        super.init()
    }
    
    init (pfObject:PFObject)
    {
        self.scoreId = pfObject.objectId! //this is the "Session Id"
        self.sit = pfObject["Sit"] as! String
        self.reverseSitUp = pfObject["Reverse_Sit_up"] as! String
        self.sitUp = pfObject["Sit_up"] as! String
        self.trunkExtensionInSitting = pfObject["Trunk_Extension_in_Sitting"] as! String
        self.overheadPress = pfObject["Overhead_Press"] as! String
        self.forwardReachAndGrasp = pfObject["Forward_Reach_and_Grasp"] as! String
        self.doorPullAndOpen = pfObject["Door_Pull_and_Open"] as! String
        self.canOpenAndManipulation = pfObject["Can_Open_and_Manipulation"] as! String
        self.sitToStand = pfObject["Sit_to_Stand"] as! String
        self.stand = pfObject["Stand"] as! String
        self.walking = pfObject["Walking"] as! String
        self.standAdaptability = pfObject["Stand_Adaptability"] as! String
        self.stepRetraining = pfObject["Step_Retraining"] as! String
        self.stepAdaptability = pfObject["Step_Adaptability"] as! String
    }
    
    //create a Score row. No need for the objectId which is alsow the sessionId
    func toPfObject() -> PFObject
    {
        let scoreObject = PFObject(className: "Scores")
        //scoreObject["scoreId"] = scoreId
        scoreObject["Sit"] = sit
        scoreObject["Reverse_Sit_up"] = reverseSitUp
        scoreObject["Sit_up"] = sitUp
        scoreObject["Trunk_Extension_in_Sitting"] = trunkExtensionInSitting
        scoreObject["Overhead_Press"] = overheadPress
        scoreObject["Forward_Reach_and_Grasp"] = forwardReachAndGrasp
        scoreObject["Door_Pull_and_Open"] = doorPullAndOpen
        scoreObject["Can_Open_and_Manipulation"] = canOpenAndManipulation
        scoreObject["Sit_to_Stand"] = sitToStand
        scoreObject["Stand"] = stand
        scoreObject["Walking"] = walking
        scoreObject["Stand_Adaptability"] = standAdaptability
        scoreObject["Step_Retraining"] = stepRetraining
        scoreObject["Step_Adaptability"] = stepAdaptability
        scoreObject["version"] = version
        return scoreObject
    }
    
    
}
