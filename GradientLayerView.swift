//
//  GradientLayer.swift
//  NRS
//
//  Created by Michael Tolfo on 4/5/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class GradientLayerView: UIView
{
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    func gradientWithColors(firstColor : UIColor, _ secondColor : UIColor) {
        
        let deviceScale = UIScreen.mainScreen().scale
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRectMake(0.0, 0.0, self.frame.size.width * deviceScale, self.frame.size.height * deviceScale)
        gradientLayer.colors = [ firstColor.CGColor, secondColor.CGColor ]
        
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    //////////////
    
    func orangeRedGradient() -> CAGradientLayer
    {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        
        // SETS THE COLORS YOU WANT TO USE IN THE GRADIENT
        let color1 = UIColorFromRGB(0x9F041B).CGColor as CGColorRef
        let color2 = UIColorFromRGB(0xF09937).CGColor as CGColorRef
        
        // ADDS THE COLORS TO THE ARRAY
        gradientLayer.colors = [color1, color2]
        
        // SETS THE LOCATION OF THE RESPECTIVE COLORS
        gradientLayer.locations = [0.0,1]
        
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
