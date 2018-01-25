//
//  CustomTabBarController.swift
//  FBMessengerClone
//
//  Created by MacBookPro on 1/25/18.
//  Copyright © 2018 basicdas. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "icon_recent")
        
        viewControllers = [recentMessagesNavController, createDummyNavControllerWithTitle(title: "Calls", imageName: "icon_call"), createDummyNavControllerWithTitle(title: "Groups", imageName: "icon_group"), createDummyNavControllerWithTitle(title: "People", imageName: "icon_people"), createDummyNavControllerWithTitle(title: "Settings", imageName: "icon_settings")]
        
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
