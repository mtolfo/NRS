//
//  NewEvalViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/5/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class NewEvalViewController: UIViewController {

    @IBOutlet var backgroundImageView:UIImageView!
    var blurEffectView:UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: "cloudNRSred")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.opaque = true
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
    
        
    }

    override func didReceiveMemoryWarning() {
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
