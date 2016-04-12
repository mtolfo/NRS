//
//  CAGradientExtension.swift
//  NRS
//
//  Created by Michael Tolfo on 4/3/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

extension CAGradientLayer
{
    
    func orangeRedGradient() -> CAGradientLayer
    {
        //let context = UIGraphicsGetCurrentContext()
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        
        // SETS THE COLORS YOU WANT TO USE IN THE GRADIENT
        let color1 = UIColorFromRGB(0x9F041B).CGColor as CGColorRef
        let color2 = UIColorFromRGB(0xF09937).CGColor as CGColorRef
        
        // ADDS THE COLORS TO THE ARRAY
        gradientLayer.colors = [color1, color2]
        
        // SETS THE LOCATION OF THE RESPECTIVE COLORS
        gradientLayer.locations = [0.0,1.0]
        
        return gradientLayer
        
    }
    
    func purpleBlueGradientLayer() -> CAGradientLayer
    {
        //let context = UIGraphicsGetCurrentContext()
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        
        // SETS THE COLORS YOU WANT TO USE IN THE GRADIENT
        let color1 = UIColorFromRGB(0x3023AE).CGColor as CGColorRef
        let color2 = UIColorFromRGB(0x53A0FD).CGColor as CGColorRef
        
        // ADDS THE COLORS TO THE ARRAY
        gradientLayer.colors = [color1, color2]
        
        // SETS THE LOCATION OF THE RESPECTIVE COLORS
        gradientLayer.locations = [0.0,1.0]
        
        return gradientLayer
        
    }

    
    
    
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

