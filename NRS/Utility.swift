//
//  Utility.swift
//  NRS
//
//  Created by Michael Tolfo on 5/13/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import Foundation

class Utility
{
    func getMinPhaseScore (phaseStructArray: [PhaseViewController.Phase]) -> String
    {
        let allPhasesWithScores = phaseStructArray.filter({$0.phaseScore != ""})
        let minPhaseElement = allPhasesWithScores.minElement({$0.phaseScore < $1.phaseScore})
        
        return (minPhaseElement!.phaseScore)!
    }
    
    func filterOutLowestScoreArray(phaseStructArray: [PhaseViewController.Phase], lowestScore: String) -> [PhaseViewController.Phase]
    {
        var filteredPhaseStructArray: [PhaseViewController.Phase] = []
        let allPhasesWithScores = phaseStructArray.filter({$0.phaseScore != ""})
        filteredPhaseStructArray = allPhasesWithScores.filter({$0.phaseScore != lowestScore})
        
        return filteredPhaseStructArray
    }
    
    func getLaggingPhasesArray (phaseStructArray: [PhaseViewController.Phase], lowestScore: String) -> [PhaseViewController.Phase]
    {
        var laggingPhasesArray: [PhaseViewController.Phase] = []
        let allPhasesWithScores = phaseStructArray.filter({$0.phaseScore != ""})
        laggingPhasesArray = allPhasesWithScores.filter({$0.phaseScore == lowestScore})
        
        return laggingPhasesArray
    }
    
    func getLaggingItems (phaseStructArray: [PhaseViewController.Phase]) -> [PhaseViewController.Phase]
    {
        let allPhasesWithScores = phaseStructArray.filter({$0.phaseScore != ""})
        var minPhaseScore: String = ""
        var allAppendedLaggingPhasesArray: [PhaseViewController.Phase] = []
        var lowestScoresArray: [String] = []
        var mutablePhaseStructArray:[PhaseViewController.Phase] = []
        
        mutablePhaseStructArray = allPhasesWithScores
        //TODO: Create condition when are no more items in mutable array
        for _ in 0...2
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
        }
        return allAppendedLaggingPhasesArray
    }
    
    func printLaggingItems (finalLaggingItemsArray: [PhaseViewController.Phase]) -> String
    {
        var laggingItemsString: String = ""
        var finalLaggingItemsString: String = ""
        
        for element in finalLaggingItemsArray
        {
            laggingItemsString = element.phaseName! + " " + element.phaseScore! + "\n"
            finalLaggingItemsString.appendContentsOf(laggingItemsString)
        }
        return "Lagging Items\n" + finalLaggingItemsString
    }
    
    func printScores(phaseStructArray: [PhaseViewController.Phase]) -> String
    {
        var phaseScoresString: String = ""
        var finalPhaseScoreString: String = ""
        
        for element in phaseStructArray
        {
            phaseScoresString = element.phaseName! + " " + element.phaseScore! + "\n"
            finalPhaseScoreString.appendContentsOf(phaseScoresString)
        }
        return "Phase Scores\n" + finalPhaseScoreString
    }

    
    
}

