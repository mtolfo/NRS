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
    var Sit = ""
    var Reverse_Sit_up = ""
    var Sit_up = ""
    var Trunk_Extension_in_Sitting = ""
    var Overhead_Press_Right = ""
    var Overhead_Press_Left = ""
    var Forward_Reach_and_Grasp_Right = ""
    var Forward_Reach_and_Grasp_Left = ""
    var Forward_Reach_and_Grasp = ""
    var Door_Pull_and_Open_Right = ""
    var Door_Pull_and_Open_Left = ""
    var Door_Pull_and_Open = ""
    var Can_Open_and_Manipulation_Right = ""
    var Can_Open_and_Manipulation_Left = ""
    var Can_Open_and_Manipulation = ""
    var Sit_to_Stand = ""
    var Stand = ""
    var Walking = ""
    var Stand_Adaptability = ""
    var Step_Retraining = ""
    var Step_Adaptability = ""
    var version = ""
    
    
    init(sitInit: String, reverseSitUpInit: String, sitUpInit: String, trunkExtensionInSittingInit: String, overheadPressRightInit: String, overheadPressLeftInit: String,
        forwardReachAndGraspRightInit: String,  forwardReachAndGraspLeftInit: String,forwardReachAndGraspInit: String,
        doorPullAndOpenRightInit: String, doorPullAndOpenLeftInit: String, doorPullAndOpenInit: String,
        canOpenAndManipulationRightInit: String, canOpenAndManipulationLeftInit: String, canOpenAndManipulationInit:String, sitToStandInit: String, standInit: String, walkingInit: String, standAdaptabilityInit: String, stepRetrainingInit: String, stepAdaptabilityInit: String, versionInit: String)
    {
        self.Sit = sitInit
        self.Reverse_Sit_up = reverseSitUpInit
        self.Sit_up = sitUpInit
        self.Trunk_Extension_in_Sitting = trunkExtensionInSittingInit
        self.Overhead_Press_Right = overheadPressRightInit
        self.Overhead_Press_Left = overheadPressLeftInit
        self.Forward_Reach_and_Grasp_Right = forwardReachAndGraspRightInit
        self.Forward_Reach_and_Grasp_Left = forwardReachAndGraspLeftInit
        self.Forward_Reach_and_Grasp = forwardReachAndGraspInit
        self.Door_Pull_and_Open_Right = doorPullAndOpenRightInit
        self.Door_Pull_and_Open_Left = doorPullAndOpenLeftInit
        self.Door_Pull_and_Open = doorPullAndOpenInit
        self.Can_Open_and_Manipulation_Right = canOpenAndManipulationRightInit
        self.Can_Open_and_Manipulation_Left = canOpenAndManipulationLeftInit
        self.Can_Open_and_Manipulation = canOpenAndManipulationInit
        self.Sit_to_Stand = sitToStandInit
        self.Stand = standInit
        self.Walking = walkingInit
        self.Stand_Adaptability = standAdaptabilityInit
        self.Step_Retraining = stepRetrainingInit
        self.Step_Adaptability = stepAdaptabilityInit
        self.version = versionInit
        super.init()
    }
    
    init (pfObject:PFObject)
    {
        self.scoreId = pfObject.objectId! //this is the "Session Id"
        self.Sit = pfObject["Sit"] as! String
        self.Reverse_Sit_up = pfObject["Reverse_Sit_up"] as! String
        self.Sit_up = pfObject["Sit_up"] as! String
        self.Trunk_Extension_in_Sitting = pfObject["Trunk_Extension_in_Sitting"] as! String
        self.Overhead_Press_Right = pfObject["Overhead_Press_Right"] as! String
        self.Overhead_Press_Left = pfObject["Overhead_Press_Left"] as! String
        self.Forward_Reach_and_Grasp_Right = pfObject["Forward_Reach_and_Grasp_Right"] as! String
        self.Forward_Reach_and_Grasp_Left = pfObject["Forward_Reach_and_Grasp_Left"] as! String
        self.Forward_Reach_and_Grasp = pfObject["Forward_Reach_and_Grasp"] as! String
        self.Door_Pull_and_Open_Right = pfObject["Door_Pull_and_Open_Right"] as! String
        self.Door_Pull_and_Open_Left = pfObject["Door_Pull_and_Open_Left"] as! String
        self.Door_Pull_and_Open = pfObject["Door_Pull_and_Open"] as! String
        self.Can_Open_and_Manipulation_Right = pfObject["Can_Open_and_Manipulation_Right"] as! String
        self.Can_Open_and_Manipulation_Left = pfObject["Can_Open_and_Manipulation_Left"] as! String
        self.Can_Open_and_Manipulation = pfObject["Can_Open_and_Manipulation"] as! String
        self.Sit_to_Stand = pfObject["Sit_to_Stand"] as! String
        self.Stand = pfObject["Stand"] as! String
        self.Walking = pfObject["Walking"] as! String
        self.Stand_Adaptability = pfObject["Stand_Adaptability"] as! String
        self.Step_Retraining = pfObject["Step_Retraining"] as! String
        self.Step_Adaptability = pfObject["Step_Adaptability"] as! String
    }
    
    //create a Score row. No need for the objectId which is alsow the sessionId
    func toPfObject() -> PFObject
    {
        let scoreObject = PFObject(className: "Scores")
        //scoreObject["scoreId"] = scoreId
        scoreObject["Sit"] = Sit
        scoreObject["Reverse_Sit_up"] = Reverse_Sit_up
        scoreObject["Sit_up"] = Sit_up
        scoreObject["Trunk_Extension_in_Sitting"] = Trunk_Extension_in_Sitting
        scoreObject["Overhead_Press_Right"] = Overhead_Press_Right
        scoreObject["Overhead_Press_Left"] = Overhead_Press_Left
        scoreObject["Forward_Reach_and_Grasp_Right"] = Forward_Reach_and_Grasp_Right
        scoreObject["Forward_Reach_and_Grasp_Left"] = Forward_Reach_and_Grasp_Left
        scoreObject["Forward_Reach_and_Grasp"] = Forward_Reach_and_Grasp
        scoreObject["Door_Pull_and_Open_Right"] = Door_Pull_and_Open_Right
        scoreObject["Door_Pull_and_Open_Left"] = Door_Pull_and_Open_Left
        scoreObject["Door_Pull_and_Open"] = Door_Pull_and_Open
        scoreObject["Can_Open_and_Manipulation_Right"] = Can_Open_and_Manipulation_Right
        scoreObject["Can_Open_and_Manipulation_Left"] = Can_Open_and_Manipulation_Left
        scoreObject["Can_Open_and_Manipulation"] = Can_Open_and_Manipulation
        scoreObject["Sit_to_Stand"] = Sit_to_Stand
        scoreObject["Stand"] = Stand
        scoreObject["Walking"] = Walking
        scoreObject["Stand_Adaptability"] = Stand_Adaptability
        scoreObject["Step_Retraining"] = Step_Retraining
        scoreObject["Step_Adaptability"] = Step_Adaptability
        scoreObject["version"] = version
        return scoreObject
    }
    
    
}
