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
    
    @IBOutlet weak var subphaseCollectionView: UICollectionView!
    private var subphaseArray = [Subphase]()
    var destinationTempString = ""
    
    func loadSubphasesFromParse()
    {
        subphaseArray.removeAll()
        subphaseCollectionView.reloadData()
        
        let query = PFQuery(className: "Sit") //or whatever is passed in segue or default from PhaseViewController
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
                    self.subphaseArray.append(subphaseObject)
                    
                    //Should I move the following two lines. This function is only to load the objects into the array
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    self.subphaseCollectionView.insertItemsAtIndexPaths([indexPath])
                }
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()

        // Do any additional setup after loading the view.
        loadSubphasesFromParse()
        print(destinationTempString)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return subphases.count
        return subphaseArray.count
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
        cell.descriptionLabel.text = subphaseArray[indexPath.row].description
        cell.descriptionIdLabel.text = subphaseArray[indexPath.row].descriptionId
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
