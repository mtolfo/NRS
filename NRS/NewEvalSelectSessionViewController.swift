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
    
  
        
    override func viewDidLoad()
       {
        super.viewDidLoad()
        
        // TODO - Delete this blur effect stuff if we don't need it
        // Do any additional setup after loading the view.
//        backgroundImagView.image = UIImage(named: "cloudNRSred")
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView?.frame = view.bounds
//        backgroundImagView.addSubview(blurEffectView!)
        
//        // to handle iPhone 4s screen size
//        if UIScreen.mainScreen().bounds.size.height == 480.0
//        {
//            let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//            flowLayout.itemSize = CGSizeMake(250.0, 300.0)
//        }
        
        // we created a CAGradientExtension here
//        let background = CAGradientLayer().orangeRedGradient()
//        background.frame = self.view.bounds
        
        
        // INSERT GRADIENT LAYER BEHIND OTHER ELEMENTS
        //self.view.layer.insertSublayer(background, atIndex: 0)
        
        
        
        //font attributes
//        labelRecoveryScale.backgroundColor = UIColor.redColor()
//        labelNeuroMuscular.font = UIFont(name: "AvenirNext-UltraLight", size: 32)
//        labelRecoveryScale.font = UIFont(name: "AvenirNext-UltraLight", size: 32)
        
//        
//        let myTitle = NSAttributedString(string: "NeuroRecovery", attributes: [NSFontAttributeName:UIFont(name: "AvenirNext-UltraLight", size: 32.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
//        labelNeuroMuscular.attributedText = myTitle
//        pickerLabel!.attributedText = myTitle
//        pickerLabel!.textAlignment = .Center
//        

        
//        for family: String in UIFont.familyNames()
//        {
//            print("\(family)")
//                for names: String in UIFont.fontNamesForFamilyName(family)
//                {
//                    print("==\(names)")
//                }
//        }
        
    }
    
//    override func viewDidLayoutSubviews()
//    {
//        //self.myGradientView.gradientWithColors(UIColor.whiteColor(), UIColor.blueColor())
//    
//    }
    
    override func viewWillLayoutSubviews() {
        let background = CAGradientLayer().orangeRedGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        //self.backgroundImageView.layer.sublayers?.first?.frame = self.view.bounds
        self.view.layer.sublayers?.first?.frame = self.view.bounds
        
    }
//
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
//    {
//        if (UIDevice.currentDevice().orientation.isLandscape)
//        {
//            // we created a CAGradientExtension here
//            let background = CAGradientLayer().orangeRedGradient()
//            background.frame = self.view.bounds
//            
//            
//            // INSERT GRADIENT LAYER BEHIND OTHER ELEMENTS
//            self.view.layer.insertSublayer(background, atIndex: 0)
//        }
//        
//
//    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?)
    {
        blurEffectView?.frame = view.bounds
    }

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
