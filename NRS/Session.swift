//
//  Session.swift
//  NRS
//
//  Created by Michael Tolfo on 1/25/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class Session:NSObject
{
    var sessionId = ""
    var sessionVersion = ""
    
    init (sessionId: String, sessionVersion: String)
    {
        self.sessionId = sessionId
        self.sessionVersion = sessionVersion
        super.init()
    }
    
    init (pfObject:PFObject)
    {
        self.sessionId = pfObject.objectId!
        self.sessionVersion = pfObject["version"] as! String
    }
    
    func toPFObject() -> PFObject
    {
        let sessionObject = PFObject(className: "Session")
        sessionObject.objectId = sessionId
        sessionObject["version"] = sessionVersion
        
        return sessionObject
    }
}
