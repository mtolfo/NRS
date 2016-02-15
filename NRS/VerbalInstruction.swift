//
//  VerbalInstruction.swift
//  NRS
//
//  Created by Michael Tolfo on 2/15/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class VerbalInstruction: NSObject
{
    var verbalInstructionId = ""
    var phaseDatabaseName = ""
    var phaseItem = ""
    var verbalInstruction = ""
    var version = ""
    
    init(phaseDatabaseNameInit: String, phaseItemInit: String, verbalInstructionInit: String, versionInit: String)
    {
        self.phaseDatabaseName = phaseDatabaseNameInit
        self.phaseItem = phaseItemInit
        self.verbalInstruction = verbalInstructionInit
        self.version = versionInit
        super.init()
    }
    
    init(pfObject: PFObject)
    {
        self.verbalInstructionId = pfObject.objectId!
        self.phaseDatabaseName = pfObject["phaseDatabaseName"] as! String
        self.phaseItem = pfObject["phaseItem"] as! String
        self.verbalInstruction = pfObject["verbalInstruction"] as! String
        self.version = pfObject["version"] as! String
    }
    
    func toPfObject() -> PFObject
    {
        let verbalInstructionObject = PFObject(className: "PhaseItem_Verbal_Instructions")
        verbalInstructionObject["phaseDatabaseName"] = phaseDatabaseName
        verbalInstructionObject["phaseItem"] = phaseItem
        verbalInstructionObject["verbalInstruction"] = verbalInstruction
        verbalInstructionObject["version"] = version
        return verbalInstructionObject
    }
}
