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
    var phaseStructFromSegue:PhaseFromSegue!
    var subPhaseFromSegue:Subphase!
    
    @IBOutlet weak var verbalInstructionLabel: UILabel!
    @IBOutlet weak var subPhaseDescriptionLabel: UILabel!
    @IBOutlet weak var unableButton: UIButton!
    @IBOutlet weak var ableButton: UIButton!
    @IBOutlet weak var manualButton: UIButton!
    @IBOutlet weak var playVideoButton: UIButton!
    
    
    struct PhaseFromSegue
    {
        var phaseName:String?
        var phaseScore:String?
        
        init(phaseNameInput: String?, phaseScoreInput: String?)
        {
            phaseName = phaseNameInput
            phaseScore = phaseScoreInput
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("From table view segue")
        //print("\(phaseStructFromSegue.phaseName) \(phaseStructFromSegue.phaseScore)")
        print("Subphase Description \(subPhaseFromSegue.description)")
        self.navigationItem.title = subPhaseFromSegue.descriptionId
        self.subPhaseDescriptionLabel.text = subPhaseFromSegue.description
    }
    
//    func loadScoresFromDatabase()
//    {
//        print ("in loadScoresFromDatabase()")
//        let query = PFQuery(className: "Scores")
//        //query.whereKey("objectId", equalTo: "PjotGycNtZ")
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if error == nil
//            {
//                if let objects = objects
//                {
//                    for object in objects
//                    {
//                        let scoreObject = Score(pfObject: object)
//                        self.scoreArray.append(scoreObject)
//                        print(scoreObject.reverseSitUp)
//                    }
//                }
//            }
//            else
//            {
//                print("Error: \(error!) \(error!.userInfo)")
//            }
//        }
//    }
    
    func loadVerbalInstructionsFromDatabase()
    {
        let query = PFQuery(className: "PhaseItem_Verbal_Instructions")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil
            {
                if let objects = objects
                {
                    for object in objects
                    {
                        
                    }
                }
            }
        }
    }

    
    

    override func didReceiveMemoryWarning() {
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
