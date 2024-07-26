//
//  MainTabBarController.swift
//  Photo search
//
//  Created by Василий Тихонов on 26.07.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
       
       let photoVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

        viewControllers = [
            generateNavigationController(rootViewController: photoVC,
                                                            title: "Photos",
                                                            imageSystemName: "photo.on.rectangle"),
            generateNavigationController(rootViewController: ViewController(),
                                                            title: "Favourites",
                                                            imageSystemName: "heart.fill"),
        
        ]
        
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String,imageSystemName: String ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageSystemName)
        return navController
    }
}
