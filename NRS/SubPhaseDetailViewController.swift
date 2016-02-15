//
//  SubPhaseDetailViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 2/8/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class SubPhaseDetailViewController: UIViewController
{
    //var phaseStructFromSegue:PhaseFromSegue!
    var subPhaseFromSegue:Subphase!
    var phaseDatabaseNameFromSegue:String?
    var verbalInstructionArray = [VerbalInstruction]()
   
    
    @IBOutlet weak var verbalInstructionLabel: UILabel!
    @IBOutlet weak var subPhaseDescriptionLabel: UILabel!
    @IBOutlet weak var unableButton: UIButton!
    @IBOutlet weak var ableButton: UIButton!
    @IBOutlet weak var manualButton: UIButton!
    @IBOutlet weak var playVideoButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadVerbalInstructionsFromDatabase()
        self.verbalInstructionLabel.text = getVerbalInstructionFromArray()
        
        self.navigationItem.title = subPhaseFromSegue.descriptionId
        self.subPhaseDescriptionLabel.text = subPhaseFromSegue.description
    }
    
    func checkVerbalInstructionArray()
    {
        print ("In check verbal instruction array")
        for element in self.verbalInstructionArray
        {
            print (element.verbalInstruction)
        }
    }
    
    func getVerbalInstructionFromArray() -> String
    {
        let filteredArray = self.verbalInstructionArray.filter({$0.phaseDatabaseName == self.phaseDatabaseNameFromSegue})
        return filteredArray[0].verbalInstruction
    }
    
    func loadVerbalInstructionsFromDatabase()
    {
        let query = PFQuery(className: "PhaseItem_Verbal_Instructions")
        query.whereKey("phaseDatabaseName", equalTo:self.phaseDatabaseNameFromSegue!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil
            {
                if let objects = objects
                {
                    for object in objects
                    {
                        let verbalInstructionObject = VerbalInstruction(pfObject: object)
                        self.verbalInstructionArray.append(verbalInstructionObject)
                    }
                }
            }
            else
            {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
