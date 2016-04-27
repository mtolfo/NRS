//
//  InstructionManualViewController.swift
//  NRS
//
//  Created by Michael Tolfo on 3/2/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class InstructionManualViewController: UIViewController
{
    @IBOutlet weak var instructionManualTextView: UITextView!

    @IBOutlet weak var gradientLayerView: GradientView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.instructionManualTextView.text = "Starting Position: Sitting at edge of mat without back support with hips and knees at 90 degrees.\n\nOptimal Client Position Sitting at the edge of the mat, feet flat on the floor, no upper extremity support, all with proper posture of head, shoulders, and trunk and positioning of pelvis.\n\nTrainer Instructions The goal is to objectively assess the level of functional recovery of sitting. With a highlow mat at a height in which the client’s feet are flat on the floor, ask client to sit up tall with their best attainable posture without using their hands for balance. If client is unable to attain appropriate posture of the trunk, trainer can then assist the client to the appropriate posture then remove assistance to assess whether client can maintain appropriate posture. If the client can maintain appropriate posture of trunk, next assess whether the client can attain appropriate posture of trunk and positioning of pelvis. If client can indefinitely hold position, ask client to sit with appropriate posture and positioning of pelvis with arms outstretched parallel to legs, and time how long the client can maintain this position. If client maintains this position for at least 30 seconds thenrequest her/him to reach forward laterally assess both right and left separately as far as possible while maintaining a steady balance. Assess the length of the forward and lateral moves. The client must be able to reach with appropriate posture and steadiness in the forward direction and on both sides. Assess whether the reaches are <10 or >10 inches. If the arms cannot reach out because of musculoskeletal dysfunction or central cord syndrome for SCI measure the length of movement disregarding the inability to stretch the arm out laterally. If the client is able to reach >10 inches, the kinematics of the upper extremity should be noted for appropriateness."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews()
    {
        let rect = CGRect.zero
        self.gradientLayerView.drawRect(rect)
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
