//
//  MainTabBarController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 05.02.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = MainConstants.orange
        print("Tab bar controller was load")
    }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create Tab one
            let tabOne = RecyclingController()
            let tabOneBarItem = UITabBarItem(title: "Переработка", image: UIImage(systemName: "arrow.up.bin"), selectedImage: UIImage(systemName: "arrow.up.bin.fill"))
            tabOne.tabBarItem = tabOneBarItem
            
            
            // Create Tab two
            let tabTwo = StatsController()
            let tabTwoBarItem = UITabBarItem(title: "Результаты", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
            tabTwo.tabBarItem = tabTwoBarItem
            
            
            let tabThree = MeetingsController()
            let tabThreeBarItem = UITabBarItem(title: "Встречи", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
            tabThree.tabBarItem = tabThreeBarItem
            
            let tabFour = UserProfileController()
            let tabFourBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
            tabFour.tabBarItem = tabFourBarItem
            
            self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
        }

}
