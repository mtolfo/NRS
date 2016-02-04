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
    var scoreId: String?
    var sit: String?
    var reverseSitUp: String?
    var sitUp: String?
    var trunkExtensionInSitting: String?
    var overheadPress: String?
    var forwardReachAndGrasp: String?
    var doorPullAndOpen: String?
    var canOpenAndManipulation: String?
    var sitToStand: String?
    var stand: String?
    var walking: String?
    var standAdaptability: String?
    var stepRetraining: String?
    var stepAdaptability: String?
//    var noScore = "No score"
//    
//    override init()
//    {
//        self.scoreId = noScore
//        self.sit = noScore
//        self.reverseSitUp = noScore
//        self.sitUp = noScore
//        self.trunkExtensionInSitting = noScore
//        self.overheadPress = noScore
//        self.forwardReachAndGrasp = noScore
//        self.doorPullAndOpen = noScore
//        self.canOpenAndManipulation = noScore
//        self.sitToStand = noScore
//        self.stand = noScore
//        self.walking = noScore
//        self.standAdaptability = noScore
//        self.stepRetraining = noScore
//        self.stepAdaptability = noScore
//        super.init()
//    }
    
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
    
//    init(scoreIdInit: String, sitInit: String, reverseSitUpInit: String, sitUpInit: String, trunkExtensionInSittingInit: String, overheadPressInit: String, forwardReachAndGraspInit: String, doorPullAndOpenInit: String, canOpenAndManipulationInit:String, sitToStandInit: String, standInit: String, walkingInit: String, standAdaptabilityInit: String, stepRetrainingInit: String, stepAdaptabilityInit: String)
//    {
//        self.scoreId = noScore
//        self.sit = noScore
//        self.reverseSitUp = noScore
//        self.sitUp = noScore
//        self.trunkExtensionInSitting = noScore
//        self.overheadPress = noScore
//        self.forwardReachAndGrasp = noScore
//        self.doorPullAndOpen = noScore
//        self.canOpenAndManipulation = noScore
//        self.sitToStand = noScore
//        self.stand = noScore
//        self.walking = noScore
//        self.standAdaptability = noScore
//        self.stepRetraining = noScore
//        self.stepAdaptability = noScore
//        super.init()
//    }

    
    init (pfObject:PFObject)
    {
        self.scoreId = pfObject.objectId!
        self.sit = pfObject["sit"] as? String
        self.reverseSitUp = pfObject["reverseSitUp"] as? String
        self.sitUp = pfObject["sitUp"] as? String
        self.trunkExtensionInSitting = pfObject["trunkExtensionInSitting"] as? String
        self.overheadPress = pfObject["overheadPress"] as? String
        self.forwardReachAndGrasp = pfObject["forwardReachAndGrasp"] as? String
        self.doorPullAndOpen = pfObject["doorPullAndOpen"] as? String
        self.canOpenAndManipulation = pfObject["canOpenAndManipulation"] as? String
        self.sitToStand = pfObject["sitToStand"] as? String
        self.stand = pfObject["stand"] as? String
        self.walking = pfObject["walking"] as? String
        self.standAdaptability = pfObject["standAdaptability"] as? String
        self.stepRetraining = pfObject["stepRetraining"] as? String
        self.stepAdaptability = pfObject["stepAdaptability"] as? String
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
