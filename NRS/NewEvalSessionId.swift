//
//  NewEvalSessionId.swift
//  NRS
//
//  Created by Michael Tolfo on 2/21/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

//singletone to get a handle on the new eval session ID
import Foundation

class NewEvalSessionId
{
    private init() {}
    
    class var sharedInstance : NewEvalSessionId
    {
        struct Singleton
        {
            static let instance = NewEvalSessionId()
        }
        return Singleton.instance
    }
    
    var sessionId = ""
}


