//
//  PhaseViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/2/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

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
    enum PhaseName: String
    {
        case scoreId
        case sit = "Sit"
        case reverseSitUp = "Reverse_Sit_up"
        case sitUp = "Sit_up"
        case trunkExtensionInSitting = "Trunk_Extension_in_Sitting"
        case overheadPress = "Overhead_Press"
        case forwardReachAndGrasp = "Forward Reach and Grasp"
        case doorAndPull = "Door_Pull_and_Open"
        case canOpenAndManipulate = "Can_Open_and_Manipulation"
        case sitToStand = "Sit_to_Stand"
        case stand = "Stand"
        case walking = "Walking"
        case standAdaptability = "Stand_Adaptability"
        case stepRetraining = "Step_Retraining"
        case stepAdaptability = "Step_Adaptability"
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
        
        init(phaseNameInput: String?, phaseScoreInput: String?)
        {
            phaseName = phaseNameInput
            phaseScore = phaseScoreInput
        }
    }
    
    func createArrayOfPhases()
    {
            phaseStructArray = [Phase(phaseNameInput: PhaseName.sit.rawValue, phaseScoreInput: phaseScore.sit),
            Phase(phaseNameInput: PhaseName.reverseSitUp.rawValue, phaseScoreInput: phaseScore.reverseSitUp),
            Phase(phaseNameInput: PhaseName.trunkExtensionInSitting.rawValue, phaseScoreInput: phaseScore.trunkExtensionInSitting),
            Phase(phaseNameInput: PhaseName.overheadPress.rawValue, phaseScoreInput: phaseScore.overheadPress),
            Phase(phaseNameInput: PhaseName.forwardReachAndGrasp.rawValue, phaseScoreInput: phaseScore.overheadPress),
            Phase(phaseNameInput: PhaseName.doorAndPull.rawValue, phaseScoreInput: phaseScore.doorPullAndOpen),
            Phase(phaseNameInput: PhaseName.canOpenAndManipulate.rawValue, phaseScoreInput: phaseScore.canOpenAndManipulation),
            Phase(phaseNameInput: PhaseName.sitToStand.rawValue, phaseScoreInput: phaseScore.sitToStand),
            Phase(phaseNameInput: PhaseName.stand.rawValue, phaseScoreInput: phaseScore.stand),
            Phase(phaseNameInput: PhaseName.walking.rawValue, phaseScoreInput: phaseScore.walking),
            Phase(phaseNameInput: PhaseName.standAdaptability.rawValue, phaseScoreInput: phaseScore.standAdaptability),
            Phase(phaseNameInput: PhaseName.stepRetraining.rawValue, phaseScoreInput: phaseScore.stepRetraining),
            Phase(phaseNameInput: PhaseName.stepAdaptability.rawValue, phaseScoreInput: phaseScore.stepAdaptability)]
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
                destinationController.phaseNameFromSegue = self.phaseStructArray[indexpath.row].phaseName
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
