//
//  GradientView.swift
//  NRS
//
//  Created by Michael Tolfo on 4/6/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class GradientView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
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
    
    
    override func drawRect(rect: CGRect) {
        // 1
        let currentContext = UIGraphicsGetCurrentContext()
        
        // 2
        //CGContextSaveGState(currentContext);
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let startColor = UIColorFromRGB(0x9F041B).CGColor as CGColorRef
        let startColorComponents = CGColorGetComponents(startColor)
        let endColor = UIColorFromRGB(0xF09937).CGColor as CGColorRef
        let endColorComponents = CGColorGetComponents(endColor)
        
        // 5
        var colorComponents = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        //var colorComponents = [startColorComponents[0], startColorComponents[1], startColorComponents[2],endColorComponents[0],endColorComponents[1],endColorComponents[2]]
        
        // 6
        var locations:[CGFloat] = [0.0, 1.0]
        
        // 7
        let gradient = CGGradientCreateWithColorComponents(colorSpace,&colorComponents,&locations,2)
        
        
//        let startPoint = CGPointMake(self.bounds.height,0)
        let startPoint = CGPointMake(self.bounds.width, 0)
        let endPoint = CGPointMake(self.bounds.width, self.bounds.height)

        
        // 8
//        CGContextDrawLinearGradient(currentContext,gradient,startPoint,endPoint, 0)
        CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        //// Swift 2 update:
//        let context = UIGraphicsGetCurrentContext() // <-- and you missed the context
//        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions(rawValue: 0))
        
        // 9
        //CGContextRestoreGState(currentContext);
        print("rect")
    }

    
    func gradientWithHexColor()
    {
        //let deviceScale = UIScreen.mainScreen().scale
        
//        let gradientLayer = CAGradientLayer().orangeRedGradient()
        //let gradientLayer = CAGradientLayer().purpleBlueGradientLayer()
        //gradientLayer.frame = CGRectMake(0.0, 0.0, self.frame.size.width * deviceScale, self.frame.size.height * deviceScale)
        
//        gradientLayer.startPoint = CGPointMake(self.bounds.height, 0)
//        gradientLayer.endPoint = CGPointMake(self.bounds.width, self.bounds.height)
        //gradientLayer.frame = CGRectMake(0, 0, self.bounds.width , self.bounds.height)
        //gradientLayer.bounds = CGRectMake(0, 0, 200, 300)
        //self.layer.insertSublayer(gradientLayer, atIndex: 0)
        
//        print (deviceScale)
//        print(self.frame.size.width)
//        print(self.frame.size.width * deviceScale)
//        print (self.frame.size.height)
//        print(self.frame.size.height * deviceScale)
        
//        print(self.bounds.width)
//        print(self.bounds.height)
        print("gradientWithHexColor")

    }

    
//    func orangeRedGradient() -> CAGradientLayer
//    {
//        let gradientLayer:CAGradientLayer = CAGradientLayer()
//        
//        // SETS THE COLORS YOU WANT TO USE IN THE GRADIENT
//        let color1 = UIColorFromRGB(0x9F041B).CGColor as CGColorRef
//        let color2 = UIColorFromRGB(0xF09937).CGColor as CGColorRef
//        
//        // ADDS THE COLORS TO THE ARRAY
//        gradientLayer.colors = [color1, color2]
//        
//        // SETS THE LOCATION OF THE RESPECTIVE COLORS
//        gradientLayer.locations = [0.0,1]
//        
//        return gradientLayer
//        
//    }
    
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
