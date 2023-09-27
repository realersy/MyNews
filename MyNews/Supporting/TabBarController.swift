//
//  TabBarController.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation
import UIKit
final class TabBarController: UITabBarController {
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        self.setupTabs()
    }
}

extension TabBarController {
    //Setting Up Tabs
    private func setupTabs(){
        let newsController = createNav(title:  "Fresh News", image: UIImage(systemName: "newspaper"), vc: NewsController())
        let favouritesController = createNav(title:  "Favourites", image: UIImage(systemName: "bookmark.circle"), vc: FavouritesController())
        
        self.setViewControllers([newsController, favouritesController], animated: true)
        self.selectedIndex = 0
    }
    
    //Creating Navigator for each VC
    private func createNav(title: String, image: UIImage?, vc: UIViewController & ProfileServiceSubscriber) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationBar.isTranslucent = true
        nav.viewControllers.first?.navigationItem.title = title
        nav.navigationBar.tintColor = .blue
        
        ProfileService.shared.subscribe(subscriber: vc)
        return nav
        
    }
}
