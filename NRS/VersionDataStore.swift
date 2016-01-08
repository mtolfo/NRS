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
        let newVersion = Version()
        allVersions.append(newVersion)
        return newVersion
    }
}
