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
    
    init(scoreIdInit: String, sitInit: String, reversSitUpInit: String, sitUpInit: String, trunkExtensionInSittingInit: String, overheadPressInit: String, forwardReachAndGraspInit: String, doorPullAndOpenInit: String, canOpenAndManipulationInit:String, sitToStandInit: String, standInit: String, walkingInit: String, standAdaptabilityInit: String, stepRetrainingInit: String, stepAdaptabilityInit: String)
    {
        self.scoreId = scoreIdInit
        
    }
}
