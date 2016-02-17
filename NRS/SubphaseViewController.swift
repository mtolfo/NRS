//
//  SubphaseViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/16/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

//This is the collection view controller for the new eval
import UIKit

class SubphaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    //TODO: phaseNameFromSegue is the phaseDatabaseName. Should refactor to change name.
    var phaseNameFromSegue:String?
    var sessionIdFromSegue:String?
    var destinationTempString = ""
    //var sessionIdToPass:String?
    private var phaseItemArray = [Subphase]() //TODO: rename this model to PhaseItem.swift
    private var verbalInstructionArray = [VerbalInstruction]()
    private var verbalInstructionString = ""
    
    @IBOutlet weak var subphaseCollectionView: UICollectionView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        
        // Do any additional setup after loading the view.
        loadPhaseItemsFromDatabase()
        loadVerbalInstructionsFromDatabase()
        //sessionIdToPass = sessionIdFromSegue
    }

    func loadPhaseItemsFromDatabase()
    {
        phaseItemArray.removeAll()
        subphaseCollectionView.reloadData()
        
        //pass in the class name of the Phase Name object in database (Sit, Stand, Sit Up...)
        let query = PFQuery(className: phaseNameFromSegue!) //or whatever is passed in segue or default from PhaseViewController
        query.cachePolicy = PFCachePolicy.NetworkElseCache
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let error = error {
                print ("Error: \(error) \(error.userInfo)")
            }
            
            if let objects = objects
            {
                for (index, object) in objects.enumerate()
                {
                    //convert PFObject into Subphase Object
                    let subphaseObject = Subphase(pfObject: object)
                    self.phaseItemArray.append(subphaseObject)
                    
                    //Should I move the following two lines. This function is only to load the objects into the array
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    self.subphaseCollectionView.insertItemsAtIndexPaths([indexPath])
                }
            }
        }
    }
    
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
    
    func getVerbalInstructionFromArray() -> String
    {
        let filteredArray = self.verbalInstructionArray.filter({$0.phaseDatabaseName == self.phaseNameFromSegue})
        return filteredArray[0].verbalInstruction
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return subphases.count
        return phaseItemArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SubPhaseCollectionViewCell
        
        //configure text
        let paragraphStyle = NSMutableParagraphStyle()
        //let tempString = subphaseArray[indexPath.row].description
        //paragraphStyle.headIndent = 20
        paragraphStyle.firstLineHeadIndent = 20.0
        
        let attributes = [NSParagraphStyleAttributeName: paragraphStyle]
        
        //configure cell
        //cell.descriptionLabel.text = subphases[indexPath.row].description
        cell.descriptionLabel.text = phaseItemArray[indexPath.row].description
        cell.descriptionIdLabel.text = phaseItemArray[indexPath.row].descriptionId
        
        let label = NSAttributedString(string: cell.descriptionLabel.text!, attributes: attributes)
        
        cell.descriptionLabel.attributedText = label
        //cell.descriptionLabel.sizeToFit()
        
        //apply round corner
        cell.layer.cornerRadius = 4.0
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //pass the selected PhaseItemArray to a Subphase Object
        //pass the database name so we can get the verbal instructions
        
        if segue.identifier == "showSubphaseDetailFromCollectionView"
        {
            if let indexPaths = subphaseCollectionView.indexPathsForSelectedItems()
            {
                let destinationViewController = segue.destinationViewController as! SubPhaseDetailViewController
                destinationViewController.subPhaseFromSegue = phaseItemArray[indexPaths[0].row]
                destinationViewController.phaseDatabaseNameFromSegue = self.phaseNameFromSegue
                destinationViewController.verbalInstructionFromSegue = self.getVerbalInstructionFromArray()
                destinationViewController.sessionIdFromSegue = self.sessionIdFromSegue
//                print("IN COLLECTION VIEW: \(self.sessionIdToPass)")
                subphaseCollectionView.deselectItemAtIndexPath(indexPaths[0], animated: false)
            }
        }
        
        
        
    }
    

}
