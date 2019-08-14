//
//  CustomCollectionFlowLayout.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 6/19/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

enum CollectionDisplay {
    case list
    case grid
}

class CustomCollectionFlowLayout : UICollectionViewFlowLayout {
    
    var display : CollectionDisplay = .list {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    convenience init(display: CollectionDisplay) {
        self.init()
        
        self.display = display
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.configLayout()
    }
    
    func configLayout() {
        switch display {
        case .grid:
            
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width) / 2
                self.estimatedItemSize = CGSize(width: optimisedWidth, height: 150) // keep as square
            }
            
        case .list:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width - 15, height:
                150)
            }
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
