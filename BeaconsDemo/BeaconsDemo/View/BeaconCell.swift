//
//  BeaconCell.swift
//  BeaconsDemo
//
//  Created by Admin on 4/11/19.
//  Copyright © 2019 Sure. All rights reserved.
//

import UIKit

class BeaconCell: UITableViewCell {
    @IBOutlet weak var beaconName: UILabel!
    @IBOutlet weak var beaconUUID: UILabel!
    @IBOutlet weak var beaconMinorAndMajor: UILabel!
    @IBOutlet weak var otherInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
