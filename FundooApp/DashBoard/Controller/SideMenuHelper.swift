//
//  SideMenuHelper.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/13/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class SideMenuHelper{
    
    public static func getSideMenu(_ controller: UIViewController, identifier : String) -> SJSwiftSideMenuController {
        let storyBoard = UIStoryboard(name: "DashBoard", bundle: nil)
        let mainVC = SJSwiftSideMenuController()
        if let rootVC = storyBoard.instantiateViewController(withIdentifier: identifier) as? UIViewController  {
                     if let sideVC_L = (storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuVC) {
                SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: nil, leftMenuType: .SlideOver, rightMenuType: .SlideView)
            }
        }
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 280
        return mainVC
    }
    
   
}
