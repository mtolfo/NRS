//
//  PhaseViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/2/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//
// This has a table view. Launched with user puts in a session number. 

import UIKit
import MessageUI

class PhaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate
{
    var phaseScore:Score! //Score object from segue goes here
    var phaseScoreArray:[String]?
    var phaseStructArray:[Phase] = []
    var phaseStruct:Phase!
    var phaseNameToPass:String?
    var phaseScoreToPass:String?
    var verbalInstructionArray = [VerbalInstruction]()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: UIView!
    
    // TODO: Phase Item names should be pulled from database
    //The names of the Phases need to be pulled from the database to prevent future refactorings in the event the name of the phase changes. In which case, a simple change to the database will make all of the changes.
    // TODO: Need to use underscore here and need a new piece in the array that shows the name for the tableView. Reverse_Sit_up databaseName, Reverse Sit Up tableViewName
    enum PhaseDatabaseName: String
    {
        case scoreId
        case sit = "Sit"
        case reverseSitUp = "Reverse_Sit_up"
        case sitUp = "Sit_up"
        case trunkExtensionInSitting = "Trunk_Extension_in_Sitting"
        case overheadPressRight = "Overhead_Press_Right"
        case overheadPressLeft = "Overhead_Press_Left"
        case forwardReachAndGraspRight = "Forward_Reach_and_Grasp_Right"
        case forwardReachAndGraspLeft = "Forward_Reach_and_Grasp_Left"
        case forwardReachAndGrasp = "Forward_Reach_and_Grasp"
        case doorAndPullRight = "Door_Pull_and_Open_Right"
        case doorAndPullLeft = "Door_Pull_and_Open_Left"
        case doorAndPull = "Door_Pull_and_Open"
        case canOpenAndManipulatRight = "Can_Open_and_Manipulation_Right"
        case canOpenAndManipulatLeft = "Can_Open_and_Manipulation_Left"
        case canOpenAndManipulate = "Can_Open_and_Manipulation"
        case sitToStand = "Sit_to_Stand"
        case stand = "Stand"
        case walking = "Walking"
        case standAdaptability = "Stand_Adaptability"
        case stepRetraining = "Step_Retraining"
        case stepAdaptability = "Step_Adaptability"
    }
    
    enum PhaseName: String
    {
        case scoreId
        case sit = "Sit"
        case reverseSitUp = "Reverse Sit up"
        case sitUp = "Sit up"
        case trunkExtensionInSitting = "Trunk Extension in Sitting"
        case overheadPressRight = "Overhead Press Right"
        case overheadPressLeft = "Overhead Press Left"
        case forwardReachAndGraspRight = "Forward Reach and Grasp Right"
        case forwardReachAndGraspLeft = "Forward Reach and Grasp Left"
        case forwardReachAndGrasp = "Forward Reach and Grasp"
        case doorAndPullRight = "Door Pull and Open Right"
        case doorAndPullLeft = "Door Pull and Open Left"
        case doorAndPull = "Door Pull and Open"
        case canOpenAndManipulatRight = "Can Open and Manipulation Right"
        case canOpenAndManipulatLeft = "Can Open and Manipulation Left"
        case canOpenAndManipulate = "Can Open and Manipulation"
        case sitToStand = "Sit to Stand"
        case stand = "Stand"
        case walking = "Walking"
        case standAdaptability = "Stand Adaptability"
        case stepRetraining = "Step Retraining"
        case stepAdaptability = "Step Adaptability"
        
    }
    
    struct Phase
    {
        var phaseName:String?
        var phaseScore:String?
        var phaseDatabaseName:String?
        var phaseScoreId:String?
        
        init(phaseDatabaseNameInput: String?, phaseScoreInput: String?, phaseNameInput: String?, phaseScoreIdInput:String?)
        {
            phaseName = phaseNameInput
            phaseScore = phaseScoreInput
            phaseDatabaseName = phaseDatabaseNameInput
            phaseScoreId = phaseScoreIdInput
        }
    }
    
    func createArrayOfPhases()
    {
            self.phaseStructArray = [
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.sit.rawValue, phaseScoreInput: phaseScore.Sit, phaseNameInput: PhaseName.sit.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.reverseSitUp.rawValue, phaseScoreInput: phaseScore.Reverse_Sit_up, phaseNameInput: PhaseName.reverseSitUp.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.sitUp.rawValue, phaseScoreInput: phaseScore.Sit_up, phaseNameInput: PhaseName.sitUp.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.trunkExtensionInSitting.rawValue, phaseScoreInput: phaseScore.Trunk_Extension_in_Sitting, phaseNameInput: PhaseName.trunkExtensionInSitting.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.overheadPressRight.rawValue, phaseScoreInput: phaseScore.Overhead_Press_Right, phaseNameInput: PhaseName.overheadPressRight.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.overheadPressLeft.rawValue, phaseScoreInput: phaseScore.Overhead_Press_Left, phaseNameInput: PhaseName.overheadPressLeft.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.forwardReachAndGrasp.rawValue, phaseScoreInput: phaseScore.Forward_Reach_and_Grasp, phaseNameInput: PhaseName.forwardReachAndGrasp.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.forwardReachAndGraspRight.rawValue, phaseScoreInput: phaseScore.Forward_Reach_and_Grasp_Right, phaseNameInput: PhaseName.forwardReachAndGraspRight.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.forwardReachAndGraspLeft.rawValue, phaseScoreInput: phaseScore.Forward_Reach_and_Grasp_Left, phaseNameInput: PhaseName.forwardReachAndGraspLeft.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.doorAndPullRight.rawValue, phaseScoreInput: phaseScore.Door_Pull_and_Open_Right, phaseNameInput: PhaseName.doorAndPullRight.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.doorAndPullLeft.rawValue, phaseScoreInput: phaseScore.Door_Pull_and_Open_Left, phaseNameInput: PhaseName.doorAndPullLeft.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.doorAndPull.rawValue, phaseScoreInput: phaseScore.Door_Pull_and_Open, phaseNameInput: PhaseName.doorAndPull.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.canOpenAndManipulatRight.rawValue, phaseScoreInput: phaseScore.Can_Open_and_Manipulation_Right, phaseNameInput: PhaseName.canOpenAndManipulatRight.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.canOpenAndManipulatLeft.rawValue, phaseScoreInput: phaseScore.Can_Open_and_Manipulation_Left, phaseNameInput: PhaseName.canOpenAndManipulatLeft.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.canOpenAndManipulate.rawValue, phaseScoreInput: phaseScore.Can_Open_and_Manipulation, phaseNameInput: PhaseName.canOpenAndManipulate.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.sitToStand.rawValue, phaseScoreInput: phaseScore.Sit_to_Stand, phaseNameInput: PhaseName.sitToStand.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.stand.rawValue, phaseScoreInput: phaseScore.Stand, phaseNameInput: PhaseName.stand.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.walking.rawValue, phaseScoreInput: phaseScore.Walking, phaseNameInput: PhaseName.walking.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.standAdaptability.rawValue, phaseScoreInput: phaseScore.Stand_Adaptability, phaseNameInput: PhaseName.standAdaptability.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.stepRetraining.rawValue, phaseScoreInput: phaseScore.Step_Retraining, phaseNameInput: PhaseName.stepRetraining.rawValue, phaseScoreIdInput: phaseScore.scoreId),
                Phase(phaseDatabaseNameInput: PhaseDatabaseName.stepAdaptability.rawValue, phaseScoreInput: phaseScore.Step_Adaptability, phaseNameInput: PhaseName.stepAdaptability.rawValue, phaseScoreIdInput: phaseScore.scoreId)]
    }
    
    func getNumberOfPhasesWithScores() -> Double
    {
        let numberOfPhases = self.phaseStructArray.filter({$0.phaseScore != ""})
        for element in numberOfPhases
        {
            print ("Score: \(element.phaseScore)")
        }
        
        print ("PHASE COUNT WITH SCORES: \(numberOfPhases.count)")
        return 0.0
    }
    
    func getNumberOfTimesSubphaseValueAppears(subphaseValue: String) -> Double
    {
        /*
            If overhead press or forward reach and grasp, the Double(count * 0.5)
        */
        let value = Double(self.phaseStructArray.filter({$0.phaseScore == subphaseValue}).count)
        return value
    }
    
    
    func isRightLeftPhase(phaseName: String) -> Bool
    {
        var isRightLeftPhase: Bool = false
        switch phaseName
        {
        case "Overhead Press Right":
            isRightLeftPhase = true
        case "Overhead Press Left":
            isRightLeftPhase = true
        case "Can Open and Manipulation Right":
            isRightLeftPhase = true
        case "Can Open and Manipulation Left":
            isRightLeftPhase = true
        case "Can Open and Manipulation":
            print (phaseName)
            isRightLeftPhase = true
        case "Forward Reach and Grasp Right":
            isRightLeftPhase = true
        case "Forward Reach and Grasp":
            print (phaseName)
            isRightLeftPhase = true
        case "Forward Reach and Grasp Left":
            isRightLeftPhase = true
        case "Door Pull and Open Right":
            isRightLeftPhase = true
        case "Door Pull and Open Left":
            isRightLeftPhase = true
        case "Door Pull and Open":
            print (phaseName)
            isRightLeftPhase = true
        default:
            isRightLeftPhase = false
        }
        return isRightLeftPhase
    }

    
    func getNumberTotal() -> Double
    {
        var numberTotal: Double = 0.0
        let subphasesWithScores = self.phaseStructArray.filter({$0.phaseScore != ""})
        for element in subphasesWithScores
        {
            // has right left component
            if (isRightLeftPhase(element.phaseName!))
            {
                switch element.phaseScore!
                {
                case "1A":
                    numberTotal += 0.5 * 1.0
                case "1B":
                    numberTotal += 0.5 * 2.0
                case "1C":
                    numberTotal += 0.5 * 3.0
                case "2A":
                    numberTotal += 0.5 * 4.0
                case "2B":
                    numberTotal += 0.5 * 5.0
                case "2C":
                    numberTotal += 0.5 * 6.0
                case "3A":
                    numberTotal += 0.5 * 7.0
                case "3B":
                    numberTotal += 0.5 * 8.0
                case "3C":
                    numberTotal += 0.5 * 9.0
                case "4A":
                    numberTotal += 0.5 * 10.0
                case "4B":
                    numberTotal += 0.5 * 11.0
                case "4C":
                    numberTotal += 0.5 * 12.0
                default:
                    numberTotal = 0.0
                }

            }
            else
            {
                //does not have right left
                switch element.phaseScore!
                {
                case "1A":
                    numberTotal += 1.0
                case "1B":
                    numberTotal += 2.0
                case "1C":
                    numberTotal += 3.0
                case "2A":
                    numberTotal += 4.0
                case "2B":
                    numberTotal += 5.0
                case "2C":
                    numberTotal += 6.0
                case "3A":
                    numberTotal += 7.0
                case "3B":
                    numberTotal += 8.0
                case "3C":
                    numberTotal += 9.0
                case "4A":
                    numberTotal += 10.0
                case "4B":
                    numberTotal += 11.0
                case "4C":
                    numberTotal += 12.0
                default:
                    numberTotal = 0.0
                }

            }
            
            // if right left
        }
        return numberTotal
    }
    
    
    
    func do_table_refresh() {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.tableView.reloadData()
            return
            
        }
        
    }
    
    @IBAction func didClickRefreshButton(sender: AnyObject)
    {
        print("In refresh: \(self.phaseScore.scoreId)")
        self.getScoreObjectFromDatabase(phaseScore.scoreId) /// Do we need to createArrayOfPhases here????
        //self.createArrayOfPhases()
        //self.tableView.reloadData()
        //self.do_table_refresh()
    }
    
    //TODO: Duplicate with the db call in ConfirmationVc
    func getScoreObjectFromDatabase(sessionIdInput:String)
    {
        let query = PFQuery(className: "Scores")
        query.whereKey("objectId", equalTo: sessionIdInput)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else
            {
                // The find succeeded.
                print("Successfully retrieved the object.")
//                self.scoreObjectFromDatabase = Score(pfObject: object!)
//                print ("scoreObject.scoreId from getScoreObjectFromDatabase \(self.scoreObjectFromDatabase.scoreId)")
                self.phaseScore = Score(pfObject: object!)
                print (self.phaseScore)
                self.createArrayOfPhases()
                //self.getNumberOfPhasesWithScores()
                //print("NUMBER TOTAL: \(self.calculateNumberTotal())")
                print ("Is Overhead right left: \(self.isRightLeftPhase("Overhead Press"))")
                print ("NUMBER TOTAL: \(self.getNumberTotal())")
                self.scoreLabel.text = String(self.getNumberTotal())
                self.do_table_refresh()
            }
        }
    }
    
    //keep this for now
//    func loadVerbalInstructionsFromDatabase()
//    {
//        let query = PFQuery(className: "PhaseItem_Verbal_Instructions")
//        
//    }
    
    func getVerbalInstructionFromArray(phaseDatabaseNameInput: String) -> String
    {
        let filteredArray = self.verbalInstructionArray.filter({$0.phaseDatabaseName == phaseDatabaseNameInput})
        return filteredArray[0].verbalInstruction
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getScoreObjectFromDatabase(self.phaseScore.scoreId)
        //createArrayOfPhases()
        //self.getNumberOfPhasesWithScores()
        
       
        //self.do_table_refresh()
        //h2C2x4Jq7A
        //7DFJDjDChM

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.phaseStructArray.count
    }
    
    
    //TODO: -Implement refresh in case there are new score.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhaseTableViewCell
      
        //table view gray if no score, yellow if there is a score
        let phaseScore = self.phaseStructArray[indexPath.row].phaseScore
        if (phaseScore == "")
        {
            cell.scoreBox.backgroundColor = UIColor().UIColorFromRGB(0xB6B6B6)
        }
        else
        {
            cell.scoreBox.backgroundColor = UIColor().UIColorFromRGB(0xFFC107)
        }
        cell.phaseName?.text = self.phaseStructArray[indexPath.row].phaseName
        cell.phaseScore?.text = self.phaseStructArray[indexPath.row].phaseScore
        //cell.verbalInstructionLabel?.text = self.getVerbalInstructionFromArray(self.phaseStructArray[indexPath.row].phaseDatabaseName!)
        //cell.verbalInstructionLabel?.text = "Hard coded. Here is where we will place some type of quick tip as reminders"
        cell.verbalInstructionLabel?.text
        
        
        return cell
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        self.navBarView.backgroundColor = UIColor().UIColorFromRGB(0xA30B1D)
    }
    
    
    @IBAction func emailButtonClicked(sender: AnyObject)
    {
        if MFMailComposeViewController.canSendMail()
        {
            print("Can send email")
        
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
        
            mailComposer.setSubject("NRS Score")
            mailComposer.setMessageBody("These are your scores", isHTML: false)
        
            self.presentViewController(mailComposer, animated: true, completion: nil)
                    
        }
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier ==  "showSubphaseDetailFromTableView"
        {
            if let indexpath = tableView.indexPathForSelectedRow
            {
                let destinationController = segue.destinationViewController as! SubphaseViewController
                destinationController.navigationItem.title = self.phaseStructArray[indexpath.row].phaseName
                destinationController.phaseNameFromSegue = self.phaseStructArray[indexpath.row].phaseDatabaseName
                destinationController.sessionIdFromSegue = self.phaseStructArray[indexpath.row].phaseScoreId
                print(self.phaseStructArray[indexpath.row].phaseName)
                
            }
        }
    }
}
