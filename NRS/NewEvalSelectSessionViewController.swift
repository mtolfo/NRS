//
//  NewEvalSelectSessionViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/5/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class NewEvalSelectSessionViewController: UIViewController
{
    @IBOutlet var backgroundImagView:UIImageView!
    var blurEffectView:UIVisualEffectView?
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var gradientLayerView: UIView!
        
    override func viewDidLoad()
       {
        super.viewDidLoad()
        
        
//         //we created a CAGradientExtension here
//        let background = CAGradientLayer().orangeRedGradient()
//        background.frame = self.view.bounds
//        
//        
//        // INSERT GRADIENT LAYER BEHIND OTHER ELEMENTS
//        self.view.layer.insertSublayer(background, atIndex: 0)
        
        
        
    }
   
    
    override func viewDidLayoutSubviews()
    {
        
//        self.gradientView.gradientWithColors(UIColor(red: 159/255, green: 4/255, blue: 27/255, alpha: 1.0), UIColor(red: 240/255, green: 152/255, blue: 55/255, alpha: 1.0))
        //self.gradientView.gradientWithHexColor()
        
        let rect = CGRect.zero
        self.gradientView.drawRect(rect)
        
        //this doesn't work
        //self.gradientView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin]
        
        //this doesn't work
        //view.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight)
        
        //red 9F041B rgb  159 4 27
        //orange F09937 240 153 55
    }
    
    
    
//    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?)
//    {
//        blurEffectView?.frame = view.bounds
//    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       
        
        
    }
*/
    

}
