//
//  NewEvalSessionId.swift
//  NRS
//
//  Created by Michael Tolfo on 2/21/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

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

//class TheOneAndOnlyKraken {
//    static let sharedInstance = TheOneAndOnlyKraken()
//    private init() {} //This prevents others from using the default '()' initializer for this class.
//}

//class Example {
//    class var sharedInstance : Example
//    {
//        struct Singleton
//        {
//            static let instance = Example()
//        }
//        return Singleton.instance
//    }
//    
//    var number = 0
//}
//
