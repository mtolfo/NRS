//
//  LagginAndScoresViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 5/13/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit
import MessageUI

class LagginAndScoresViewController: UIViewController, MFMailComposeViewControllerDelegate
{
    var scoreIdLagAndScore: String?
    var phaseStructArray: [PhaseViewController.Phase] = []
    var minPhaseElement: String?
    var filteredPhaseStructArray: [PhaseViewController.Phase] = []
    var laggingPhasesFinalArray: [PhaseViewController.Phase] = []
    var overallPhaseValue: String?
    var grandTotal: String? //the conversion from double to a string with two decimal points has been made in previous screen
    
    
    @IBOutlet weak var gradientLayerView: GradientView!
    @IBOutlet weak var overallPhaseScoreTextView: UITextView!
    
    
    @IBOutlet weak var scoreAndLagTextView: UITextView!
    @IBOutlet weak var evaluationIdTextView: UITextView!
    
    @IBAction func backToPhasesButtonClicked(sender: AnyObject)
    {
        self.performSegueWithIdentifier("unwindToPhaseTableView", sender: self)
    }
    
    
    @IBAction func emailLagAndScoresClicked(sender: AnyObject)
    {
        let allPhasesWithScores = phaseStructArray.filter({$0.phaseScore != ""})
            if MFMailComposeViewController.canSendMail()
            {
            print("Can send email")
        
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
        
            mailComposer.setSubject("NRS Score and Lagging Items")
            mailComposer.setMessageBody("Evaluation Identifier: \(self.scoreIdLagAndScore!)\n" + "\nOverall score: \(self.overallPhaseValue!) (raw score \(self.grandTotal!))\n" + Utility().printScores(allPhasesWithScores) + "\n" + Utility().printLaggingItems(self.laggingPhasesFinalArray), isHTML: false)
        
            self.presentViewController(mailComposer, animated: true, completion: nil)
            
            }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLayoutSubviews()
    {
        
        let rect = CGRect.zero
        self.gradientLayerView.drawRect(rect)

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let allPhasesWithScores = phaseStructArray.filter({$0.phaseScore != ""})
        var laggingScoresString: String = "There are no lagging scores."
        var phaseScoresString: String = "There are no phase scores."
        
        if (allPhasesWithScores.isEmpty)
        {
            //TODO: Unwind with message here.
            print("THERE ARE NO LAGGING ITEMS")
            //put alert code here and return false
            let alertController = UIAlertController(title: "Lagging Items", message:
                "There are no lagging items because no phases have been scored.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            self.laggingPhasesFinalArray = Utility().getLaggingItems(phaseStructArray)
            laggingScoresString = Utility().printLaggingItems(self.laggingPhasesFinalArray)
            phaseScoresString = Utility().printScores(allPhasesWithScores)
        }
        
        self.evaluationIdTextView.text = self.scoreIdLagAndScore
        self.overallPhaseScoreTextView.text = self.overallPhaseValue! + " (\(self.grandTotal!))"
        self.scoreAndLagTextView.text = phaseScoresString + "\n" + laggingScoresString

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Unwind to Phase Table View
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   

}
