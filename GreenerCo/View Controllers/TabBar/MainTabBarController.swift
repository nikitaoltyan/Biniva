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
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let tabOne = RecyclingController()
        let tabOneBarItem = UITabBarItem(title: "Переработка", image: UIImage(systemName: "arrow.up.bin"), selectedImage: UIImage(systemName: "arrow.up.bin.fill"))
        tabOne.tabBarItem = tabOneBarItem
        let vc1 = UINavigationController(rootViewController: tabOne)
            
            
            // Create Tab two
        let tabTwo = StatsController()
        let tabTwoBarItem = UITabBarItem(title: "Статистика", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        tabTwo.tabBarItem = tabTwoBarItem
        let vc2 = UINavigationController(rootViewController: tabTwo)
            
            
//        let tabThree = MeetingsController()
//        let tabThreeBarItem = UITabBarItem(title: "Встречи", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
//        tabThree.tabBarItem = tabThreeBarItem
//        let vc3 = UINavigationController(rootViewController: tabThree)
//            
//        let tabFour = UserProfileController()
//        tabFour.userId = UserDefaults.standard.string(forKey: "uid")
//        let tabFourBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
//        tabFour.tabBarItem = tabFourBarItem
//        let vc4 = UINavigationController(rootViewController: tabFour)
            
//        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
//        self.viewControllers = [vc1, vc2, vc3, vc4]
        self.viewControllers = [vc1, vc2]
    }

}
