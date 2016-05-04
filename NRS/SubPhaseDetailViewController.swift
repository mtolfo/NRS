//
//  SubPhaseDetailViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/8/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit



class SubPhaseDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate//, DataEnteredFromInstructionManualVcDelegate
{
    var subPhaseFromSegue:Subphase!
    var scoreObjectFromDatabase:Score!
    var phaseDatabaseNameFromSegue:String?
    var verbalInstructionArray = [VerbalInstruction]()
    var sessionIdFromSegue:String?
    var verbalInstructionObjectFromSegue:VerbalInstruction!
    var subPhaseArray = [Subphase]()
    var subPhaseArrayIndex:Int = 0
    var phaseInstruction = ""
    
    @IBOutlet weak var gradientLayerView: GradientView!
    @IBOutlet weak var verbalInstructionLabel: UILabel!
    @IBOutlet weak var subPhaseDescriptionLabel: UILabel!
    @IBOutlet weak var phaseName: UILabel!
    @IBOutlet weak var subPhaseId: UILabel!

    //keep this
    @IBAction func ableCheckClicked(sender: AnyObject)
    {
        //TODO: Create check to not go beyond array
        if self.subPhaseArrayIndex < self.subPhaseArray.count - 1
        {
            self.subPhaseArrayIndex += 1
            self.subPhaseDescriptionLabel.text = self.subPhaseArray[self.subPhaseArrayIndex].description
            self.subPhaseId.text = self.subPhaseArray[self.subPhaseArrayIndex].descriptionId
            self.navigationItem.title = self.subPhaseArray[self.subPhaseArrayIndex].descriptionId
            print (self.subPhaseId.text)
        }

    }

    //keep this
//    @IBAction func infoButtonClicked(sender: AnyObject)
//    {
//       performSegueWithIdentifier("showInstructionManualVc", sender: self)
//    }
    
    
    
    //keep this
    @IBAction func scoresButtonClicked(sender: AnyObject)
    {
        performSegueWithIdentifier("showScoresTableView", sender: self)
    }
    
    @IBAction func backButtonClicked(sender: AnyObject)
    {
        performSegueWithIdentifier("showSubphaseCollectionView", sender: self)
    }
    
    @IBAction func unableButtonClicked(sender: AnyObject)
    {
        // shouldPerform is a validation check
        if (shouldPerformSegueWithIdentifier("showConfirmView", sender: self))
        {
//            let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//            let blurView = UIVisualEffectView(effect: darkBlur)
//            blurView.frame = gradientLayerView.bounds
//            gradientLayerView.addSubview(blurView)
            performSegueWithIdentifier("showConfirmView", sender: self)
        }
    }
    
    @IBAction func manualButonClicked(sender: AnyObject)
    {
        performSegueWithIdentifier("showManualVc", sender: self)
    }
    
    //new delegate stuff
//    func userDidEnterInformation(phaseDatabaseName: String) {
//        self.phaseDatabaseNameFromSegue = phaseDatabaseName
//    }
    
    func getInstructionManualFromDatabase (phaseDatabaseName: String)
    {
        let query = PFQuery(className: "Phase_Instructions")
        query.whereKey(phaseDatabaseName, equalTo: self.verbalInstructionObjectFromSegue.phaseDatabaseName)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getInstructionManualFromDatabase request failed.")
            }
            else
            {
                self.phaseInstruction = object!["instruction"] as! String
            }
        }
    }
    
    func getStartingIndex(subphaseDescriptionIdInput: String, subPhaseArrayInput: [Subphase]) -> Int?
    {
        
        return subPhaseArrayInput.indexOf({$0.descriptionId == subphaseDescriptionIdInput})!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = subPhaseFromSegue.descriptionId
        self.subPhaseDescriptionLabel.sizeToFit() //don't know if this works
        self.verbalInstructionLabel.text = self.verbalInstructionObjectFromSegue.verbalInstruction
        self.subPhaseDescriptionLabel.text = subPhaseFromSegue.description
        self.phaseName.text = self.verbalInstructionObjectFromSegue.phaseItem
        self.subPhaseId.text = self.subPhaseFromSegue.descriptionId
        
        // if the session id is not coming from the in progress screen the use the singleton for the session id
        if (self.sessionIdFromSegue ==  nil)
        {
            self.sessionIdFromSegue = NewEvalSessionId.sharedInstance.sessionId
        }

        self.subPhaseArrayIndex = getStartingIndex(self.subPhaseFromSegue.descriptionId, subPhaseArrayInput: self.subPhaseArray)!
        self.getScoreObject(self.sessionIdFromSegue!)
        
        //getInstructionManualFromdatabase now working correctly
        self.getInstructionManualFromDatabase("Sit")
        self.getInstructionManualFromDatabase("Reverse_Sit_up")
        
    }
    
    override func viewDidLayoutSubviews()
    {
        let rect = CGRect.zero
        self.gradientLayerView.drawRect(rect)
    }
    
    func markScoreObjectFromDatabase(descriptionIdInput:String, sessionDatabaseName: String)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: self.sessionIdFromSegue!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            }
            else
            {
                // The find succeeded.
                print("Successfully retrieved the object.")
                object![self.verbalInstructionObjectFromSegue.phaseDatabaseName] = descriptionIdInput
                object!.saveInBackground()
                print ("Marked \(sessionDatabaseName) as \(object![self.verbalInstructionObjectFromSegue.phaseDatabaseName])")
            }
        }
        
    }
    
    func getScoreObject(sessionIdInput: String)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: self.sessionIdFromSegue!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getScoreObject request failed.")
            }
            else
            {
                self.scoreObjectFromDatabase = Score(pfObject: object!)
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doesPhaseHaveScore(phaseDatabaseName: String) -> Bool
    {
        let scoreMirror = _reflect(self.scoreObjectFromDatabase)
        
        for i in 0..<scoreMirror.count
        {
            let (phase, score) = scoreMirror[i]
            let value = score.value
            print("\(i): \(phase) = \(value)")
            if phase == phaseDatabaseName
            {
                print("In the if: \(phaseDatabaseName) \(score.value)")
                if score.summary.isEmpty
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    //provides validation before the segue
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool
    {
        // If the phase does not have a score, then move on to the confirm screen
        if identifier ==  "showConfirmView"
        {
            if !(self.doesPhaseHaveScore(self.verbalInstructionObjectFromSegue.phaseDatabaseName))
            {
                return true
            }
            else
            {
                //put alert code here and return false
                let alertController = UIAlertController(title: "Phase already scored", message:
                    "If you want to score this subphase, you must clear the scores for the \(self.verbalInstructionObjectFromSegue.phaseItem) phase", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return false
            }
        }
        
        
        return false
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier ==  "showConfirmView"
        {
            let destinationVc = segue.destinationViewController as! ConfirmViewController
            
            let controller = destinationVc.popoverPresentationController
            if controller != nil
            {
                controller?.delegate = self
            }
            
            //Popover only shows during confirmation that a subPhase is UNABLE so
            //we need the index before the one that is in the SubPhaseDetailVC
            if self.subPhaseArrayIndex > 0
            {
                subPhaseArrayIndex -= 1
            }
            destinationVc.subPhaseObject = self.subPhaseArray[subPhaseArrayIndex]
            destinationVc.verbalInstructionObject = self.verbalInstructionObjectFromSegue
            destinationVc.sessionId = self.sessionIdFromSegue
            
        }

        
        //this goes back to table view and refreshes the scores
        if segue.identifier ==  "showScoresTableView"
        {
            let targetVc = segue.destinationViewController as! PhaseViewController
            targetVc.phaseScore = self.scoreObjectFromDatabase
        }
        
        if segue.identifier == "showSubphaseCollectionView"
        {
            let targetVc = segue.destinationViewController as! SubphaseViewController
            targetVc.phaseNameFromSegue = self.phaseDatabaseNameFromSegue
        }
        
        if segue.identifier == "showManualVc"
        {
            print("Hello Manual Vc")
            let targetVc = segue.destinationViewController as! InstructionManualViewController
            targetVc.verbalInstructionObject = self.verbalInstructionObjectFromSegue
            //must pass the state of the subphase object as well.
            //updated description ID and description based off of the 
            //check marking. So we need to set a new Subphase object
            subPhaseFromSegue.descriptionId = self.subPhaseId.text!
            subPhaseFromSegue.description = self.subPhaseDescriptionLabel.text!
            targetVc.subPhaseObject = self.subPhaseFromSegue
            targetVc.sessionId = self.sessionIdFromSegue
            targetVc.subPhaseArray = self.subPhaseArray
            targetVc.phaseDatabaseName = self.phaseDatabaseNameFromSegue
            
            //new delegate stuff
            //targetVc.delegate = self
            
            print(subPhaseFromSegue.descriptionId)
            print (subPhaseFromSegue.description)
            print (subPhaseFromSegue.isDefaultSelection)
            print (self.sessionIdFromSegue)
    
        }
        }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
    }
    
    
    }
