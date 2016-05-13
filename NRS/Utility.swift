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
        laggingPhasesArray = allPhasesWithScores.filter({$0.phaseName == lowestScore})
        
        return laggingPhasesArray
    }
}
