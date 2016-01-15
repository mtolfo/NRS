//
//  Version.swift
//  NRS
//
//  Created by Michael Tolfo on 1/8/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class Version:NSObject
{
    var versionId = ""
    var version = ""
    var isCurrentVersion = false
    
    init (versionId: String, version: String, isCurrentVersion: Bool)
    {
        self.versionId = versionId
        self.version = version
        self.isCurrentVersion = isCurrentVersion
        super.init()
    }
    
    init(pfObject: PFObject)
    {
        self.versionId = pfObject.objectId!
        self.version = pfObject["version"] as! String
        self.isCurrentVersion = pfObject["isCurrentVersion"] as! Bool
    }
    
    func toPFObject() -> PFObject
    {
        let versionObject = PFObject(className: "Version")
        versionObject.objectId = versionId
        versionObject["version"] = version
        versionObject["isCurrentVersion"] = isCurrentVersion
        return versionObject
    }
}

