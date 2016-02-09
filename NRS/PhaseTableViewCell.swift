//
//  PhaseTableViewCell.swift
//  NRS
//
//  Created by Michael Tolfo on 2/6/16.
//  Copyright © 2016 tolfosoftware. All rights reserved.
//

import UIKit

class PhaseTableViewCell: UITableViewCell {

    @IBOutlet weak var phaseName: UILabel!
    @IBOutlet weak var phaseScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
