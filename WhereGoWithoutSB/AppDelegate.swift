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
var favoritesViewNavigationController: UINavigationController?
var authNavigationViewController: UINavigationController?
var welcomeNavigationViewController: UINavigationController?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let tabBarController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey("3ed69a38-a2d6-43ec-ac3e-a79da5bd277d")
         tabBarController.delegate = self
       
        categoriesNavigationViewController = UINavigationController(rootViewController: CategoriesViewController())
        
        let mapContext = MapContext()
        let mapContainer = MapContainer.assemble(with: "park,questroom,art-space,museums,bar,clubs,attractions", with: mapContext)
        
        let favoritesContext = FavoritesContext()
        let favoritesContainer = FavoritesContainer.assemble(with: favoritesContext)
        
        
        mapViewNavigationController =  UINavigationController(rootViewController: mapContainer.viewController)
        favoritesViewNavigationController = UINavigationController(rootViewController: favoritesContainer.viewController)
        welcomeNavigationViewController = UINavigationController(rootViewController: WelcomeViewController())
        delegate = self
        FirebaseApp.configure()
        
        // MARK: Содержимое кномки выйти из аккаунта, пока не решено куда ее лепить
        if UserSettings.rememberUser != nil {
            if UserSettings.rememberUser{
                globalAppUser.id = UserSettings.id
                globalAppUser.name = UserSettings.userName
                globalAppUser.email = UserSettings.email
                globalAppUser.avatarURL = UserSettings.imageData
                self.loadFavoritePlaces(currentUserId: UserSettings.id)
                self.loadViewedPlaces(currentUserId: UserSettings.id)
            }
            if !UserSettings.rememberUser{
                do{
                    try Auth.auth().signOut()
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                    
                } catch {
                    print ("не удалось выйти из аккаунта")
                }
            }
        } else if UserSettings.userName == nil {
            do{
                try Auth.auth().signOut()
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                
            } catch {
                print ("не удалось выйти из аккаунта")
            }
        }

        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil{
                self.window?.rootViewController?.present(welcomeNavigationViewController!, animated: true)
            }
        }
        
        
        
        //MARK: исправить force unwrapping
        tabBarController.viewControllers = [categoriesNavigationViewController!, mapViewNavigationController!, favoritesViewNavigationController!]
        
        let item1 = UITabBarItem(title: "", image: UIImage(named:"house"), tag: 0)
        let item2 = UITabBarItem(title: "", image:  UIImage(named: "map"), tag: 1)//"mappin.circle.fill"
        let item3 = UITabBarItem(title: "", image:  UIImage(named: "favorite"), tag: 2)
        
//
//        let item1 = UITabBarItem(title: "", image: UIImage(systemName: "house.fill"), tag: 0)//"homeBar"
//        let item2 = UITabBarItem(title: "", image:  UIImage(systemName: "map.fill"), tag: 1)//"mappin.circle.fill"
//        let item3 = UITabBarItem(title: "", image: UIImage(systemName: "person.fill"), tag: 2)//"person.fill"
        
        
        tabBarController.tabBar.barTintColor = UIColor(red: 255/255, green: 206/255, blue: 59/255, alpha: 1)
        tabBarController.tabBar.tintColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
        tabBarController.tabBar.alpha = 0.9
        
        categoriesNavigationViewController?.tabBarItem = item1
        mapViewNavigationController?.tabBarItem = item2
        favoritesViewNavigationController?.tabBarItem = item3
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
}

extension AppDelegate: UITabBarControllerDelegate, UITabBarDelegate{
    
    private func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let tabBarIndex = tabBarController.tabBarItem.tag
        if tabBarIndex == 2{
            if globalAppUser.name.isEmpty{
                delegate?.dismissMeView()
                delegate?.openSignIn()
            }
        }
    }
    

}


extension AppDelegate: FireStoreFavoritePlacesOutput{
    func loadViewedPlaces(currentUserId: String) {
        self.getArrayInfo(id: currentUserId, key: "viewedPlaces") { resultString in
            globalAppUser.viewedPlaces = resultString
        }
    }
    
    
    func loadFavoritePlaces(currentUserId: String) {
        self.getArrayInfo(id: currentUserId, key: "favoritePlaces") { resultString in
            globalAppUser.favoritePlaces = resultString
        }
    }
    
    func getArrayInfo(id: String, key: String, completion: @escaping ([Int]) -> Void) {
        var result: [Int] = []
        let rootReference = Database.database().reference()
        let nameReference = rootReference.child("users").child(id).child(key)
        nameReference.observeSingleEvent(of: .value) { (DataSnapshot) in
            result = DataSnapshot.value as? [Int] ?? []
            completion(result)
        }
    }
    
    
    
}

extension AppDelegate: MainViewDelegate{
    func openSignIn() {
        categoriesNavigationViewController?.present(WelcomeViewController(), animated: true)
    }
    
    func dismissMeView() {
        tabBarController.selectedIndex = 0
    }
    
    
}


