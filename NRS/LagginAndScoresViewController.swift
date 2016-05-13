//
//  LagginAndScoresViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 5/13/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class LagginAndScoresViewController: UIViewController
{
    var scoreIdLagAndScore: String?
    var phaseStructArray: [PhaseViewController.Phase] = []
//    var minPhaseElement: String?
//    var filteredPhaseStructArray: [PhaseViewController.Phase] = []
    var laggingPhasesFinalArray: [PhaseViewController.Phase] = []
    

    @IBAction func backToPhasesButtonClicked(sender: AnyObject)
    {
        self.performSegueWithIdentifier("unwindToPhaseTableView", sender: self)
    }
    
    @IBOutlet weak var testTextLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        testTextLabel.text = self.scoreIdLagAndScore
        self.laggingPhasesFinalArray = self.getLaggingItems(phaseStructArray)
        if (self.laggingPhasesFinalArray.count == 0)
        {
            print ("NO LAGGING ITEMS")
        }
        else
        {
            for element in self.laggingPhasesFinalArray
            {
                print ("PHASE NAME: \(element.phaseName) \(element.phaseScore)")
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLaggingItems(phaseStructArray: [PhaseViewController.Phase]) -> [PhaseViewController.Phase]
    {
        var minPhaseScore: String = ""
        var laggingPhaseArray: [PhaseViewController.Phase]
        var filteredPhaseArray: [PhaseViewController.Phase]
        var allAppendedLaggingPhasesArray: [PhaseViewController.Phase] = []
        var phaseStructArrayMutable = phaseStructArray //need to make mutable in order to remove elements later
        
        for count in 0...2
        {
//            if (phaseStructArrayMutable.count == 0) //make sure to check for nil when using this function
//            {
//                return allAppendedLaggingPhasesArray
//            }
            print ("COUNT: \(count)")
            minPhaseScore = Utility().getMinPhaseScore(phaseStructArrayMutable)
            laggingPhaseArray = Utility().getLaggingPhasesArray(phaseStructArrayMutable, lowestScore: minPhaseScore)
            
            allAppendedLaggingPhasesArray += laggingPhaseArray
            phaseStructArrayMutable.removeAll()
            filteredPhaseArray = Utility().filterOutLowestScoreArray(phaseStructArrayMutable, lowestScore: minPhaseScore)
            phaseStructArrayMutable = filteredPhaseArray
        }
        
        return allAppendedLaggingPhasesArray
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
