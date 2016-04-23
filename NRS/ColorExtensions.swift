//
//  ColorExtensions.swift
//  NRS
//
//  Created by Michael Tolfo on 4/22/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

extension UIColor
{
    
    // RGB COLOR FUNCTION
    func UIColorFromRGB(rgbValue: UInt) -> UIColor
    {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
