//
//  SideMenuTableCell.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/13/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class SideMenuTableCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cellLabel: ShadowedLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellLabel.shadowLayer.elevation = .cardPickedUp
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
