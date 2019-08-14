//
//  UINavigationExtension.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/27/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationController {
    func pushViewController(viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
