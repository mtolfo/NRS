//
//  PhaseViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/2/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//
// This has a table view. Launched with user puts in a session number. 

import UIKit

class PhaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var phaseScore:Score! //Score object from segue goes here
    var phaseScoreArray:[String]?
    var phaseStructArray:[Phase] = []
    var phaseStruct:Phase!
    var phaseNameToPass:String?
    var phaseScoreToPass:String?
    
    @IBOutlet weak var tableView: UITableView!
    
    // FIXME: Phase Item names should be pulled from database
    //The names of the Phases need to be pulled from the database to prevent future refactorings in the event the name of the phase changes. In which case, a simple change to the database will make all of the changes.
    // TODO: Need to use underscore here and need a new piece in the array that shows the name for the tableView. Reverse_Sit_up databaseName, Reverse Sit Up tableViewName
    enum PhaseDatabaseName: String
    {
        case scoreId
        case sit = "Sit"
        case reverseSitUp = "Reverse_Sit_up"
        case sitUp = "Sit_up"
        case trunkExtensionInSitting = "Trunk_Extension_in_Sitting"
        case overheadPress = "Overhead_Press"
        case forwardReachAndGrasp = "Forward_Reach_and_Grasp"
        case doorAndPull = "Door_Pull_and_Open"
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
        case trunkExtensionInSitting = "Trunk_Extension in Sitting"
        case overheadPress = "Overhead Press"
        case forwardReachAndGrasp = "Forward Reach and Grasp"
        case doorAndPull = "Door Pull and Open"
        case canOpenAndManipulate = "Can Open and Manipulation"
        case sitToStand = "Sit to Stand"
        case stand = "Stand"
        case walking = "Walking"
        case standAdaptability = "Stand Adaptability"
        case stepRetraining = "Step Retraining"
        case stepAdaptability = "Step Adaptability"
    }
    
    //FIXME: -Will need this if pulling phase item names from database
//    func loadPhaseItemsFromDatabase()
//    {
//        print ("Loading phase items from database")
//        let query = PFQuery(className: "Phase_Items")
//        query.orderByAscending("phaseOrder")
//        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
//            if error ==  nil
//            {
//                if let objects = objects
//                {
//                    for object in objects
//                    {
//                        let phaseItemObject = PhaseItem(pfObject: object)
//                        self.phaseItemArray.append(phaseItemObject)
//                        print(phaseItemObject.phaseItem)
//                    }
//                }
//                else
//                {
//                    print ("Error: \(error!) \(error!.userInfo)")
//                }
//            }
//        }
//    }
    
    struct Phase
    {
        var phaseName:String?
        var phaseScore:String?
        var phaseDatabaseName:String?
        
        init(phaseDatabaseNameInput: String?, phaseScoreInput: String?, phaseNameInput: String?)
        {
            phaseName = phaseNameInput
            phaseScore = phaseScoreInput
            phaseDatabaseName = phaseDatabaseNameInput
        }
    }
    
    func createArrayOfPhases()
    {
            phaseStructArray = [Phase(phaseDatabaseNameInput: PhaseDatabaseName.sit.rawValue, phaseScoreInput: phaseScore.sit, phaseNameInput: PhaseName.sit.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.reverseSitUp.rawValue, phaseScoreInput: phaseScore.reverseSitUp, phaseNameInput: PhaseName.reverseSitUp.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.trunkExtensionInSitting.rawValue, phaseScoreInput: phaseScore.trunkExtensionInSitting, phaseNameInput: PhaseName.trunkExtensionInSitting.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.overheadPress.rawValue, phaseScoreInput: phaseScore.overheadPress, phaseNameInput: PhaseName.overheadPress.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.forwardReachAndGrasp.rawValue, phaseScoreInput: phaseScore.forwardReachAndGrasp, phaseNameInput: PhaseName.forwardReachAndGrasp.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.doorAndPull.rawValue, phaseScoreInput: phaseScore.doorPullAndOpen, phaseNameInput: PhaseName.doorAndPull.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.canOpenAndManipulate.rawValue, phaseScoreInput: phaseScore.canOpenAndManipulation, phaseNameInput: PhaseName.canOpenAndManipulate.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.sitToStand.rawValue, phaseScoreInput: phaseScore.sitToStand, phaseNameInput: PhaseName.sitToStand.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.stand.rawValue, phaseScoreInput: phaseScore.stand, phaseNameInput: PhaseName.stand.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.walking.rawValue, phaseScoreInput: phaseScore.walking, phaseNameInput: PhaseName.walking.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.standAdaptability.rawValue, phaseScoreInput: phaseScore.standAdaptability, phaseNameInput: PhaseName.standAdaptability.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.stepRetraining.rawValue, phaseScoreInput: phaseScore.stepRetraining, phaseNameInput: PhaseName.stepRetraining.rawValue),
            Phase(phaseDatabaseNameInput: PhaseDatabaseName.stepAdaptability.rawValue, phaseScoreInput: phaseScore.stepAdaptability, phaseNameInput: PhaseName.stepAdaptability.rawValue)]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createArrayOfPhases()

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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhaseTableViewCell
      
        let phaseScore = self.phaseStructArray[indexPath.row].phaseScore
        if (phaseScore == "")
        {
            cell.phaseName.textColor = UIColor.redColor()
        }
        else
        {
            cell.phaseName.textColor = UIColor.blueColor()
            cell.phaseScore.textColor = UIColor.blueColor()
        }
        cell.phaseName?.text = self.phaseStructArray[indexPath.row].phaseName
        cell.phaseScore?.text = self.phaseStructArray[indexPath.row].phaseScore
        
        return cell
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
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
//                destinationController.phaseStructFromSegue.phaseName = self.phaseStructArray[indexpath.row].phaseName
//                destinationController.phaseStructFromSegue.phaseScore = self.phaseStructArray[indexpath.row].phaseScore
            }
        }
        
        
//        if segue.identifier == "showRestaurantDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//            let destinationController = segue.destinationViewController as!
//            RestaurantDetailViewController
//            destinationController.restaurantImage =
//            restaurantImages[indexPath.row]
//            }
//        }
    }
    

}
