//
//  Shadow+UILabel.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/15/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class ShadowedLabel: UILabel {
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer {
        return self.layer as! MDCShadowLayer
    }
    
    func setDefaultElevation() {
        self.shadowLayer.elevation = .cardResting
    }
    
}
