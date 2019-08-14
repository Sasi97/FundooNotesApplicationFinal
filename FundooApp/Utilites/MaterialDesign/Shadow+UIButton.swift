//
//  ShadowButton.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/15/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//



import UIKit
import MaterialComponents

class ShadowedButton: UIButton {
    
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
