//
//  InstructionalVideoViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 5/18/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class InstructionalVideoViewController: UIViewController {

    @IBOutlet weak var gradientLayerView: GradientView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews()
    {
        
        let rect = CGRect.zero
        self.gradientLayerView.drawRect(rect)
        
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
