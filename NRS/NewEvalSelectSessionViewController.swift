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
        let background = CAGradientLayer().orangeRedGradient()
        background.frame = self.view.bounds
        
        
        // INSERT GRADIENT LAYER BEHIND OTHER ELEMENTS
        self.view.layer.insertSublayer(background, atIndex: 0)
        
    }
    
    // RGB COLOR FUNCTION
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
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
