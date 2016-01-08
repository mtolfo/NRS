//
//  Version.swift
//  NRS
//
//  Created by Michael Tolfo on 1/8/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class Version
{
    var versionId = ""
    var version = ""
    
    init (versionId: String, version: String)
    {
        self.versionId = versionId
        self.version = version
    }
    
    convenience init()
    {
        self.init(versionId: "", version:"")
    }
  
    
       /*
    func getVersions() -> Dictionary<String, String>
    {
        let versionsDictionary = [Version(versionId: "14V3", version: "2014 V3"),
        Version(versionId: "15V1", version: "2015 V1"),
        Version(versionId: "15V2", version: "2015 V2")]
    
        
    }
    

let versionPickerData = [Version(versionId: "14V3", version: "2014 V3"),
Version(versionId: "15V1", version: "2015 V1"),
Version (versionId: "15V2", version: "2015 V2")]
*/
}

