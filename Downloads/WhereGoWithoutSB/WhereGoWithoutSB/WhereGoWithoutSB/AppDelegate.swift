//
//  AppDelegate.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

var categoriesNavigationViewController : UINavigationController!
var mapViewNavigationController: UINavigationController!
var meNavigationViewController: UINavigationController!


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let tabBarController = UITabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        categoriesNavigationViewController = UINavigationController(rootViewController: CategoriesViewController())
        mapViewNavigationController = UINavigationController(rootViewController: MapViewController())
        meNavigationViewController = UINavigationController(rootViewController: MeViewController())
        
        tabBarController.viewControllers = [categoriesNavigationViewController, mapViewNavigationController, meNavigationViewController]
        
        let item1 = UITabBarItem(title: "", image: UIImage(systemName:"house"), tag: 0)
        let item2 = UITabBarItem(title: "", image:  UIImage(systemName: "mappin.circle.fill"), tag: 1)
        let item3 = UITabBarItem(title: "", image:  UIImage(systemName: "person.fill"), tag: 2)
        
        tabBarController.tabBar.barTintColor = UIColor(red: 1, green: 195/255, blue: 52/255, alpha: 1)
        tabBarController.tabBar.tintColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
        
        categoriesNavigationViewController.tabBarItem = item1
        mapViewNavigationController.tabBarItem = item2
        meNavigationViewController.tabBarItem = item3
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }

}

