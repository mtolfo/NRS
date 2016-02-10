//
//  PhaseItem.swift
//  NRS
//
//  Created by Michael Tolfo on 1/26/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

//this pulls from database object named "Phase_Items". 
//TODO: Maybe rename the database object to "Phases"
import Foundation
import UIKit

class PhaseItem:NSObject
{
    var phaseItem = ""
    var phaseOrder:Int = 0
    var phaseDatabaseName = ""
    
    init (phaseItemInit: String, phaseOrderInit: Int, phaseDatabaseNameInit: String)
    {
        self.phaseItem = phaseItemInit
        self.phaseOrder = phaseOrderInit
        self.phaseDatabaseName = phaseDatabaseNameInit
        super.init()
    }
    
    init (pfObject: PFObject)
    {
        self.phaseItem = pfObject["phaseItem"] as! String
        self.phaseOrder = pfObject["phaseOrder"] as! Int
        self.phaseDatabaseName = pfObject["phaseDatabaseName"] as! String
    }
    
    func toPFObject() -> PFObject
    {
        let phaseItemObject = PFObject(className: "Phase_Items")
        phaseItemObject["phaseItem"] = phaseItem
        phaseItemObject["phaseOrder"] = phaseOrder
        phaseItemObject["phaseDatabasename"] = phaseDatabaseName
        return phaseItemObject
    }
}


