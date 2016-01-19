//
//  Subphase.swift
//  NRS
//
//  Created by Michael Tolfo on 1/18/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class Subphase
{
    var descriptionId = "" //1A, 1B, 2B...
    var description = "" //Unable to maintain proper posture...
    var subphaseName = "" //Sit, Reverse Sit-Up, Trunk Extension In Sitting...
    var isDefaultSelection = false //Is this the default subphase description
    var isAble = false //Can the patient execute this description
    
    init (subphaseName: String, descriptionId: String, description: String, isDefaultSelection: Bool, isAble: Bool)
    {
        self.descriptionId = descriptionId
        self.description = description
        self.subphaseName = subphaseName
        self.isDefaultSelection = isDefaultSelection
        self.isAble = isAble
    }
}
