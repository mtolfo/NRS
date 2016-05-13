//
//  PhaseStruct.swift
//  NRS
//
//  Created by Michael Tolfo on 5/13/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

//this struct does not communicate with the database
import Foundation

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