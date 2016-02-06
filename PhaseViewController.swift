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
    
    var phaseScore:Score!
    var phaseScoreArray:[String]?
    //var phaseScoreDictionary:[Dictionary<String, String>]()
    var phaseStructArray:[Phase] = []
    
    enum PhaseName: String
    {
        case scoreId = "Score Id"
        case sit = "Sit"
        case reverseSitUp = "Reverse Sit Up"
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
    
    func createPhaseScoreArray ()
    {
        //create array of dictionary and initialize with "Sit" and phaseScore.sit
        phaseScoreArray = [phaseScore.scoreId, phaseScore.sit, phaseScore.reverseSitUp]
        //print("Printing elements in phaseScore object: \(phaseScore.scoreId) \(phaseScore.sit) \(phaseScore.reverseSitUp)")
        print("Printing elements in phaseScore object: \(phaseScore.scoreId) \(phaseScore.sit) \(phaseScore.reverseSitUp)")
        
    }
    
    func createArrayOfPhases()
    {
        phaseStructArray = [Phase(phaseNameInput: "Phase Score Id", phaseScoreInput: phaseScore.scoreId),Phase(phaseNameInput: "Sit", phaseScoreInput: phaseScore.sit),Phase(phaseNameInput: "Reverse Sit Up", phaseScoreInput: phaseScore.reverseSitUp)]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createPhaseScoreArray()
//        createPhaseScoreArray()
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        //Configure the cell
        //cell.textLabel?.text = restaurantName[indexPath.row]
        //cell.textLabel?.text = self.phaseScoreArray![indexPath.row]
        //cell.textLabel?.text = self.phaseScoreDictionary[indexPath.row]
        cell.textLabel?.text = "\(self.phaseStructArray[indexPath.row].phaseName!) \(self.phaseStructArray[indexPath.row].phaseScore!)"
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
