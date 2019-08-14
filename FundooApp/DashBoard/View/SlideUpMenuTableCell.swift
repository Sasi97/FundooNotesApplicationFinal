//
//  SlideUpMenuTableCell.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/16/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class SlideUpMenuTableCell: UITableViewCell {

    
    
   // @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lbl: ShadowedLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl.setDefaultElevation()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
