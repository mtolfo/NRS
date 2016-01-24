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
    var startDate = NSDate()
    var endDate = NSDate()
    
    init (versionId: String, version: String, isCurrentVersion: Bool, startDate: NSDate, endDate: NSDate)
    {
        self.versionId = versionId
        self.version = version
        self.isCurrentVersion = isCurrentVersion
        self.startDate = startDate
        self.endDate = endDate
        super.init()
    }
    
    init(pfObject: PFObject)
    {
        self.versionId = pfObject.objectId!
        self.version = pfObject["version"] as! String
        self.isCurrentVersion = pfObject["isCurrentVersion"] as! Bool
        self.startDate = pfObject["startDate"] as! NSDate
        self.endDate = pfObject["endDate"] as! NSDate
    }
    
    func toPFObject() -> PFObject
    {
        let versionObject = PFObject(className: "Version")
        versionObject.objectId = versionId
        versionObject["version"] = version
        versionObject["isCurrentVersion"] = isCurrentVersion
        versionObject["startDate"] = startDate
        versionObject["endDate"] = endDate
        return versionObject
    }
}

