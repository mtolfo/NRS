//
//  VersionDataStore.swift
//  NRS
//
//  Created by Michael Tolfo on 1/8/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation
import UIKit

class VersionDataStore
{
    var allVersions = [Version]()
    
    func  createVersion() -> Version
    {
        let newVersion = Version(random: false)
        allVersions.append(newVersion)
        return newVersion
    }
    
    
    init()
    {
        for _ in 0..<4
        {
            createVersion()
        }
    }
}
