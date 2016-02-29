//
//  ConfirmationPopOverViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/27/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit




class ConfirmationPopOverViewController: UIViewController
{

    @IBOutlet
    weak var subphaseDescriptionLabel: UILabel!
    var subPhaseObject:Subphase! //this object is the subphase before the one on the previous view controller because we are confirming that the patient is UNABLE to do this task
    var verbalInstructionObject:VerbalInstruction!
    
    
    
    @IBOutlet weak var confirmationMessageLabel: UILabel!
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

        self.subphaseDescriptionLabel.text = self.subPhaseObject.description
        
        self.confirmationMessageLabel.text = "Confirm previous task: \(self.verbalInstructionObject.phaseItem) \(self.subPhaseObject.descriptionId) as ABLE."

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
