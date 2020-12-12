//
//  AppDelegate.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import YandexMapsMobile
import Firebase

var categoriesNavigationViewController : UINavigationController?
var mapViewNavigationController: UINavigationController?
var meNavigationViewController: UINavigationController?
var authNavigationViewController: UINavigationController?
var welcomeNavigationViewController: UINavigationController?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let tabBarController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey("3ed69a38-a2d6-43ec-ac3e-a79da5bd277d")
        
        categoriesNavigationViewController = UINavigationController(rootViewController: CategoriesViewController())
        
        let context = MapContext()
        let container = MapContainer.assemble(with: "park,questroom,art-space,museums,bar,clubs,attractions", with: context)
        mapViewNavigationController =  UINavigationController(rootViewController: container.viewController)
        meNavigationViewController = UINavigationController(rootViewController: MeViewController())
        welcomeNavigationViewController = UINavigationController(rootViewController: WelcomeViewController())
    
        
        FirebaseApp.configure()
        
        // MARK: Содержимое кномки выйти из аккаунта, пока не решено куда ее лепить
        do{
            try Auth.auth().signOut()
        } catch {
            print ("не удалось выйти из аккаунта")
        }
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil{
                self.window?.rootViewController?.present(welcomeNavigationViewController!, animated: true)
            }
        }
        
        
        
        //MARK: исправить force unwrapping
        tabBarController.viewControllers = [categoriesNavigationViewController!, mapViewNavigationController!, meNavigationViewController!]
        
        let item1 = UITabBarItem(title: "", image: UIImage(named:"house"), tag: 0)
        let item2 = UITabBarItem(title: "", image:  UIImage(named: "map"), tag: 1)//"mappin.circle.fill"
        let item3 = UITabBarItem(title: "", image: UIImage(named: "person"), tag: 2)//"person.fill"
        
//
//        let item1 = UITabBarItem(title: "", image: UIImage(systemName: "house.fill"), tag: 0)//"homeBar"
//        let item2 = UITabBarItem(title: "", image:  UIImage(systemName: "map.fill"), tag: 1)//"mappin.circle.fill"
//        let item3 = UITabBarItem(title: "", image: UIImage(systemName: "person.fill"), tag: 2)//"person.fill"
        
        
        tabBarController.tabBar.barTintColor = UIColor(red: 255/255, green: 206/255, blue: 59/255, alpha: 1)//(red: 253/255, green: 247/255, blue: 152/255, alpha: 1)- беклый желтый //(red: 171/255, green: 175/255, blue: 181/255, alpha: 1) - серый
        tabBarController.tabBar.tintColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
        tabBarController.tabBar.alpha = 0.9
        
        categoriesNavigationViewController?.tabBarItem = item1
        mapViewNavigationController?.tabBarItem = item2
        meNavigationViewController?.tabBarItem = item3
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
}

