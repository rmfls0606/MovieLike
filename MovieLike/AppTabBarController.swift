//
//  AppTabBarController.swift
//  MovieLike
//
//  Created by 이상민 on 1/31/25.
//

import UIKit

final class AppTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    private func configureTabBar() {
        self.view.backgroundColor = .black
        let firstVC = UINavigationController(rootViewController: MainViewController())
        
        // TODO: 뷰컨 하나 만들어야 함
        let secondVC = UINavigationController(rootViewController: ViewController())
        let thirdVC = UINavigationController(rootViewController: SetProfileViewController())
        
        firstVC.tabBarItem = UITabBarItem(title: "CENEMA", image: UIImage(systemName: "popcorn"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "UPCOMING", image: UIImage(systemName: "film.stack"), tag: 1)
        thirdVC.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.circle"), tag: 2)
        
        self.setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        
        self.tabBar.tintColor = UIColor(named: "blueColor")
        self.tabBar.backgroundColor = .black
        self.tabBar.unselectedItemTintColor = UIColor(named: "lightGrayColor")
    }
}
