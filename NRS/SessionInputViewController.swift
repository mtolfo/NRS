//
//  SessionInputViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 1/15/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class SessionInputViewController: UIViewController
{
    private var sessionArray = [Session]()
    private var scoreArray = [Score]()
    private var sessionIdText:String?
    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet weak var sessionTextField: UITextField!

    @IBOutlet weak var sessionUsedLabel: UILabel!
   
    var blurEffectView:UIVisualEffectView!
    
    
    @IBAction func sessionEnteredButtonClick(sender: AnyObject)
    {
        //print("Did click button")
        sessionIdText = sessionTextField.text
        //printScores()
    }
    
    //place all of the scores into an array
    //Should we filter first? Then function is less general.
    //Loading scores now in order to have a validation for user input
    func loadScoresFromDatabase()
    {
        print ("in loadScoresFromDatabase()")
        let query = PFQuery(className: "Scores")
        //query.whereKey("objectId", equalTo: "PjotGycNtZ")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil
            {
                if let objects = objects
                {
                    for object in objects
                    {
                        let scoreObject = Score(pfObject: object)
                        self.scoreArray.append(scoreObject)
                    }
                }
            }
            else
            {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func printScores()
    {
        for element in self.scoreArray
        {
            print("Score Array check: \(element.scoreId) \(element.sit) \(element.reverseSitUp)")
        }
    }
    
    
    // loads the session from user input into an array
    // This must be called from the button click, and not for view did load because it needs the text from the user input. 
    //TODO: This function must be refactored to have an input paramter of String:SessionID to filter the database call.
    func loadSessionFromParse() -> Bool
    {
        var sessionDidLoad = false
        let query = PFQuery(className: "Session")
        query.whereKey("objectId", equalTo: sessionTextField.text!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil
            {
                if let objects = objects
                {
                    if (objects.isEmpty)
                    {
                        print ("No session found")
                        sessionDidLoad = false
                    }
                    else
                    {
                        for object in objects
                        {
                            let sessionObject = Session(pfObject: object)
                            print("Printing session ID: \(sessionObject.sessionId)")
                            self.sessionArray.append(sessionObject)
                        }
                        sessionDidLoad = true
                    }
                }
            }
            else
            {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        return sessionDidLoad
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //loadSessionFromParse()
        loadScoresFromDatabase()

        // Do any additional setup after loading the view.
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
        if segue.identifier == "showInProgressPhases"
        {
            let destinationController = segue.destinationViewController as! PhaseViewController
            let filteredScoreArray = scoreArray.filter({$0.scoreId == sessionTextField.text})
            destinationController.phaseScore = filteredScoreArray.first!
            destinationController.navigationItem.title = "Session: \(destinationController.phaseScore.scoreId)"
        }
    }
    
    //validation to prevent segue
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool
    {
        if identifier == "showInProgressPhases"
        {
            //use "sessionTextField.text!" instead of backing variable "sessionIdText" for validation
            if (sessionTextField.text!.isEmpty || !scoreArray.contains({$0.scoreId == sessionTextField.text!}))
            {
                let alertController = UIAlertController(title: "Session Does Not Exist", message:
                                "The session id you have entered does not exist in the database.", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)
                return false
            }
            else
            {
                return true
            }
        }
        
        //by default, do the transition
        return true
    }
    

}
