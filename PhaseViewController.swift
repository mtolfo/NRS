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
    var restaurantName = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster"]
    var phaseItemArray = [PhaseItem]()
    var phaseScore:Score!
    var phaseScoreArray:[String]?
    var phaseStructArray:[Phase] = []
    
    // FIXME: Phase Item names should be pulled from database
    //The names of the Phases need to be pulled from the database to prevent future refactorings in the event the name of the phase changes. In which case, a simple change to the database will make all of the changes.
    enum PhaseName: String
    {
        case scoreId
        case sit = "Sit"
        case reverseSitUp = "Reverse Sit Up"
        case sitUp = "Sit Up"
        case trunkExtensionInSitting = "Trunk Extension In Sitting"
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
    func loadPhaseItemsFromDatabase()
    {
        print ("Loading phase items from database")
        let query = PFQuery(className: "Phase_Items")
        query.orderByAscending("phaseOrder")
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            if error ==  nil
            {
                if let objects = objects
                {
                    for object in objects
                    {
                        let phaseItemObject = PhaseItem(pfObject: object)
                        self.phaseItemArray.append(phaseItemObject)
                        print(phaseItemObject.phaseItem)
                    }
                }
                else
                {
                    print ("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
    }
    
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
    
//    func createPhaseScoreArray ()
//    {
//        //create array of dictionary and initialize with "Sit" and phaseScore.sit
//        phaseScoreArray = [phaseScore.scoreId, phaseScore.sit, phaseScore.reverseSitUp]
//        //print("Printing elements in phaseScore object: \(phaseScore.scoreId) \(phaseScore.sit) \(phaseScore.reverseSitUp)")
//        print("Printing elements in phaseScore object: \(phaseScore.scoreId) \(phaseScore.sit) \(phaseScore.reverseSitUp)")
//        
//    }
    
    
    
    func createArrayOfPhases()
    {
        //let sit = phaseItemArray.filter({$0.phaseOrder == 1})
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
            //Phase(phaseNameInput: self.phaseItemArray[3].phaseItem,phaseScoreInput: phaseScore.trunkExtensionInSitting)]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadPhaseItemsFromDatabase()
        createArrayOfPhases()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return restaurantName.count;
        //print("Count: \(self.phaseScoreArray.count)")
        //return self.phaseScoreArray!.count
        //return self.phaseScoreDictionary.count
        return self.phaseStructArray.count
    }
    
    //TODO: -Implement refresh in case there are new score.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhaseTableViewCell
      
        
        //Configure the cell
        //cell.textLabel?.text = restaurantName[indexPath.row]
        //cell.textLabel?.text = self.phaseScoreArray![indexPath.row]
        //cell.textLabel?.text = self.phaseScoreDictionary[indexPath.row]
//        cell.textLabel?.text = "\(self.phaseStructArray[indexPath.row].phaseName!) \(self.phaseStructArray[indexPath.row].phaseScore!)"
        //let phaseName = self.phaseStructArray[indexPath.row].phaseName
        
        
//        let phaseScore = self.phaseStructArray[indexPath.row].phaseScore
//        cell.phaseName?.text = self.phaseStructArray[indexPath.row].phaseName
//        cell.phaseScore?.text = phaseScore
//        if (phaseScore == "")
//        {
//            cell.textLabel?.textColor = UIColor.redColor()
//        }
//        else
//        {
//            cell.textLabel?.textColor = UIColor.greenColor()
//        }
//        return cell
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
