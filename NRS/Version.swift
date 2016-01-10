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
    
    /*
    convenience init(random: Bool = false)
    {
        let versionsCI = ["2014 Version 3", "2015 Version 1", "2015 Version 2"]
        let versionIdCI = ["14V3", "15V1", "14V2"]

        if random
        {
            
            var idx = arc4random_uniform(UInt32(versionsCI.count))
            let randomVersion = versionsCI[Int(idx)]
            
            idx = arc4random_uniform(UInt32(versionIdCI.count))
            let randomVersionId = versionIdCI[Int(idx)]
            
            self.init(versionId:randomVersionId, version: randomVersion)
        }
        else
        {
            
            self.init(versionId: "Hello ID", version:"Hello version")
            //self.init(versionId: versionId, version: versions)
            //self.init(versionId:versionIdCI, version: versionsCI)
            
        }
    }
*/
}

