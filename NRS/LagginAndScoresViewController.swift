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
    var minPhaseElement: String?
    var filteredPhaseStructArray: [PhaseViewController.Phase] = []
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
//        minPhaseElement = Utility().getMinPhaseScore(self.phaseStructArray)
//        print ("MIN :\(minPhaseElement)")
//        
//        filteredPhaseStructArray = Utility().filterOutLowestScoreArray(self.phaseStructArray, lowestScore: minPhaseElement!)
//        print ("FILTERED: \(filteredPhaseStructArray)")
//        
//        //laggingPhasesFinalArray = Utility().getLaggingPhasesArray(self.phaseStructArray, lowestScore: minPhaseElement!)
//        print ("LAGGING ITEMS: \(laggingPhasesFinalArray)")
        if (phaseStructArray.isEmpty)
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
            self.laggingPhasesFinalArray = self.getLaggingItems(phaseStructArray)
        }
        
        
//        self.laggingPhasesFinalArray = self.getLaggingItems(self.phaseStructArray)
//        if (self.laggingPhasesFinalArray.count == 0)
//        {
//            print ("\nNO LAGGING ITEMS")
//        }
//        else
//        {
//            for element in self.laggingPhasesFinalArray
//            {
//                print ("\nPHASE NAME: \(element.phaseName) \(element.phaseScore)")
//            }
//        }

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getLaggingItems(phaseStructArray: [PhaseViewController.Phase]) -> [PhaseViewController.Phase]
//    {
//        var minPhaseScore: String = ""
//        var laggingPhaseArray: [PhaseViewController.Phase]
//        var filteredPhaseArray: [PhaseViewController.Phase]
//        var allAppendedLaggingPhasesArray: [PhaseViewController.Phase] = []
//        var phaseStructArrayMutable: [PhaseViewController.Phase] = []
//        for count in 0...2
//        {
////            if (phaseStructArrayMutable.count == 0) //make sure to check for nil when using this function
////            {
////                return allAppendedLaggingPhasesArray
////            }
//          
//            print ("COUNT: \(count)")
//            minPhaseScore = Utility().getMinPhaseScore(phaseStructArray)
//            laggingPhaseArray = Utility().getLaggingPhasesArray(phaseStructArray, lowestScore: minPhaseScore)
//            
//            allAppendedLaggingPhasesArray += laggingPhaseArray
//            print ("\nALL APPENDED: \(allAppendedLaggingPhasesArray)")
//            
//            
//            filteredPhaseArray = Utility().filterOutLowestScoreArray(phaseStructArray, lowestScore: minPhaseScore)
//        }
//        
//        return allAppendedLaggingPhasesArray
//    }
    
    /*
    for element in allPhasesWithScores
    {
    if (self.rightLeftPhasesArray.contains(element.phaseName!))
    {
    numberOfPhases += 0.5
    }
    else
    {
    numberOfPhases += 1.0
    }
    }
     
     //    var a = [1, 2, 3]
     //    var b = [2, 3, 4]
     //    a.filter { element in
     //    !contains(b, element)
     //    }
 */
    func getLaggingItems (phaseStructArray: [PhaseViewController.Phase]) -> [PhaseViewController.Phase]
    {
        var minPhaseScore: String = ""
        var allAppendedLaggingPhasesArray: [PhaseViewController.Phase] = []
        var lowestScoresArray: [String] = []
        var mutablePhaseStructArray:[PhaseViewController.Phase] = []
        
                            
        mutablePhaseStructArray = phaseStructArray
        for count in 0...2
        {
            minPhaseScore = Utility().getMinPhaseScore(mutablePhaseStructArray)
            lowestScoresArray.append(minPhaseScore) //place all of the lowest scores in the array
            
            allAppendedLaggingPhasesArray += Utility().getLaggingPhasesArray(mutablePhaseStructArray, lowestScore: minPhaseScore)
        
            mutablePhaseStructArray = Utility().filterOutLowestScoreArray(mutablePhaseStructArray, lowestScore: minPhaseScore)
            print ("COUNT: \(count)")
        }
        
        print ("\nFINAL LAGGING: \(allAppendedLaggingPhasesArray)")
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
