//
//  SubphaseViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/16/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class SubphaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
//    var descriptionId = "" //1A, 1B, 2B...
//    var description = "" //Unable to maintain proper posture...
//    var subphaseName = "" //Sit, Reverse Sit-Up, Trunk Extension In Sitting...
//    var isDefaultSelection = false //Is this the default subphase description
//    var isAble = false //Can the patient execute this description
    
    @IBOutlet weak var subphaseCollectionView: UICollectionView!
    private var subphaseArray = [Subphase]()
    private var subphases =
        [Subphase(subphaseName: "Sit", descriptionId: "1A", description: "Unable to maintain proper posture of trunk.", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "1B", description: "Able to both attain sitting with appropraite posture of trunk and postion of trunk and position of pelvis & maintain this for approx. one min.", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "1C", description: "Unable to attain. Able to maintain sitting with appropriate posture of trunk.", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "2A", description: "Able to both attain sitting with appropriate posture of trunk and position of pelvis & maintain this for approx. one minute.", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "2B", description: "Able to both attain sitting with appropriate posture of trunk and position of pelvis & maintain this indefinitely.", isDefaultSelection: true, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "3A", description: "Able to both attain sitting with appropriate posture of trunk and position of pelvis with arms parallel to the legs for 30 sec with inappropriate kinematics of the full UE.)", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "3B", description: "Same as 2C and forward and lateral reach/lean 5-10 inches & return to proper sitting posture with inappropriate kinematics of the scapula, shoulder, elbow, wrist and fingers (full UE).", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "3C", description: "Same as 2C and able to forward & lateral reach/lean >10 inches & return to proper sitting posture with inappropriate kinematics of the scapula, shoulder, elbow, wrist and fingers (full UE).", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "4A", description: "Able to attain & maintain appropriate sitting posture indefinitely. Able to forward & lateral reach/lean >10 inches & return to appropriate sitting posture appropriate kinematics of the elbow, inappropriate kinematics of the scalpula, shoulder, wrist and fingers.", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "4B", description: "Able to attain & maintain appropriate sitting posture indefinitely. Able to forward & lateral with 90 degrees of shoulder flexion & forward & lateral reach/lean >10 inches & return to appropriate sitting posture appropriate kinematics of the scapula, shoulder, and elbow inappropriate kinematics of the wrist and fingers.", isDefaultSelection: false, isAble: false),
        Subphase(subphaseName: "Sit", descriptionId: "4C", description: "Able to attain & maintain appropriate sitting posture indefinitely. Able to elevate arms outstretched parallel to legs & forward and lateral with 90 degrees of shoulder flexion & forward & lateral reach/lean > 10 inches & return to appropraite sitting posture with appropriate kinematics of the scapulae, shoulder, elbows, wrist, and fingers.", isDefaultSelection: false, isAble: false)]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subphases.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SubPhaseCollectionViewCell
        
        //configure cell
        cell.descriptionLabel.text = subphases[indexPath.row].description
        
        //apply round corner
        cell.layer.cornerRadius = 4.0
        return cell
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
