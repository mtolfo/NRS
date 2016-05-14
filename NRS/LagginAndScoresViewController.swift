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
    var overallPhaseValue: String?
    
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var gradientLayerView: GradientView!

    @IBAction func backToPhasesButtonClicked(sender: AnyObject)
    {
        self.performSegueWithIdentifier("unwindToPhaseTableView", sender: self)
    }
    
    @IBOutlet weak var testTextLabel: UILabel!
    @IBOutlet weak var scoreAndLagLabel: UILabel!
    
    override func viewDidLayoutSubviews()
    {
        
        let rect = CGRect.zero
        self.gradientLayerView.drawRect(rect)

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        testTextLabel.text = self.scoreIdLagAndScore
        self.laggingPhasesFinalArray = self.getLaggingItems(phaseStructArray)
        print ("\nFINAL LAGGING: \(self.laggingPhasesFinalArray)")

        self.scoreAndLagLabel.text = self.printLaggingItems(self.laggingPhasesFinalArray)
        self.overallScoreLabel.text = self.overallPhaseValue

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func printLaggingItems (finalLaggingItemsArray: [PhaseViewController.Phase]) -> String
    {
        var laggingItemsString: String = ""
        var finalLaggingItemsString: String = ""
        
        for element in finalLaggingItemsArray
        {
            laggingItemsString = element.phaseName! + " " + element.phaseScore! + "\n"
            print ("IN LOOP: \(laggingItemsString)")
            finalLaggingItemsString.appendContentsOf(laggingItemsString)
        }
        print ("FINAL IN FUNC: \(finalLaggingItemsString)")
        return finalLaggingItemsString
    }
    
    func getLaggingItems (phaseStructArray: [PhaseViewController.Phase]) -> [PhaseViewController.Phase]
    {
        let allPhasesWithScores = phaseStructArray.filter({$0.phaseScore != ""})
        var minPhaseScore: String = ""
        var allAppendedLaggingPhasesArray: [PhaseViewController.Phase] = []
        var lowestScoresArray: [String] = []
        var mutablePhaseStructArray:[PhaseViewController.Phase] = []
        
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
            
        
        mutablePhaseStructArray = allPhasesWithScores
        //TODO: Create condition when are no more items in mutable array
        for count in 0...2
        {
            if (mutablePhaseStructArray.isEmpty)
            {
                return allPhasesWithScores
            }
            else
            {
                minPhaseScore = Utility().getMinPhaseScore(mutablePhaseStructArray)
                lowestScoresArray.append(minPhaseScore) //place all of the lowest scores in the array
                
                allAppendedLaggingPhasesArray += Utility().getLaggingPhasesArray(mutablePhaseStructArray, lowestScore: minPhaseScore)
                
                mutablePhaseStructArray = Utility().filterOutLowestScoreArray(mutablePhaseStructArray, lowestScore: minPhaseScore)
            }
            
            print ("COUNT: \(count)")
        }
        }
        
        //print ("\nFINAL LAGGING: \(allAppendedLaggingPhasesArray)")
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


}
