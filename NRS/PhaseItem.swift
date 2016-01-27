//
//  PhaseItem.swift
//  NRS
//
//  Created by Michael Tolfo on 1/26/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class PhaseItem:NSObject
{
    var phaseItem = ""
    var phaseOrder:Int = 0
    
    init (phaseItemInit: String, phaseOrderInit: Int)
    {
        self.phaseItem = phaseItemInit
        self.phaseOrder = phaseOrderInit
        super.init()
    }
    
    init (pfObject: PFObject)
    {
        self.phaseItem = pfObject["phaseItem"] as! String
        self.phaseOrder = pfObject["phaseOrder"] as! Int
    }
    
    func toPFObject() -> PFObject
    {
        let phaseItemObject = PFObject(className: "Phase_Items")
        phaseItemObject["phaseItem"] = phaseItem
        phaseItemObject["phaseOrder"] = phaseOrder
        return phaseItemObject
    }
}


