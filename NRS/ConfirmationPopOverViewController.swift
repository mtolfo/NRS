//
//  ConfirmationPopOverViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/27/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

var verbalInstructionObject:VerbalInstruction!
var database:Database!

class ConfirmationPopOverViewController: UIViewController
{

    @IBOutlet
    weak var subphaseDescriptionLabel: UILabel!
    
    @IBAction func confirmButtonClicked(sender: AnyObject)
    {
        
    }
    
    @IBAction func rejectButtonClicked(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
