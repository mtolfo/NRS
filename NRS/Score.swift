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
    
    init(scoreIdInit: String, sitInit: String, reverseSitUpInit: String, sitUpInit: String, trunkExtensionInSittingInit: String, overheadPressInit: String, forwardReachAndGraspInit: String, doorPullAndOpenInit: String, canOpenAndManipulationInit:String, sitToStandInit: String, standInit: String, walkingInit: String, standAdaptabilityInit: String, stepRetrainingInit: String, stepAdaptabilityInit: String)
    {
        self.scoreId = scoreIdInit
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
        super.init()
    }
    
    init (pfObject:PFObject)
    {
        self.scoreId = pfObject.objectId!
        self.sit = pfObject["sit"] as! String
        self.reverseSitUp = pfObject["reverseSitUp"] as! String
        self.sitUp = pfObject["sitUp"] as! String
        self.trunkExtensionInSitting = pfObject["trunkExtensionInSitting"] as! String
        self.overheadPress = pfObject["overheadPress"] as! String
        self.forwardReachAndGrasp = pfObject["forwardReachAndGrasp"] as! String
        self.doorPullAndOpen = pfObject["doorPullAndOpen"] as! String
        self.canOpenAndManipulation = pfObject["canOpenAndManipulation"] as! String
        self.sitToStand = pfObject["sitToStand"] as! String
        self.stand = pfObject["stand"] as! String
        self.walking = pfObject["walking"] as! String
        self.standAdaptability = pfObject["standAdaptability"] as! String
        self.stepRetraining = pfObject["stepRetraining"] as! String
        self.stepAdaptability = pfObject["stepAdaptability"] as! String
    }
    
    func toPfObject() -> PFObject
    {
        let scoreObject = PFObject(className: "Scores")
        scoreObject["scoreId"] = scoreId
        scoreObject["sit"] = sit
        scoreObject["reverseSitUp"] = reverseSitUp
        scoreObject["sitUp"] = sitUp
        scoreObject["trunkExtensionInSitting"] = trunkExtensionInSitting
        scoreObject["overheadPress"] = overheadPress
        scoreObject["forwardReachAndGrasp"] = forwardReachAndGrasp
        scoreObject["doorPullAndOpen"] = doorPullAndOpen
        scoreObject["canOpenAndManipulation"] = canOpenAndManipulation
        scoreObject["sitToStand"] = sitToStand
        scoreObject["stand"] = stand
        scoreObject["walking"] = walking
        scoreObject["standAdaptability"] = standAdaptability
        scoreObject["stepRetraining"] = stepRetraining
        scoreObject["stepAdaptability"] = stepAdaptability
        return scoreObject
    }
    
    
}
