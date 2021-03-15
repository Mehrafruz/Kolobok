//
//  FavoritesRouter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

final class FavoritesRouter {
    weak var viewController: UIViewController?
}

extension FavoritesRouter: FavoritesRouterInput {
    func showProfile() {
        let meViewController = MeViewController()
        viewController?.present(meViewController, animated: true, completion: nil)
        meViewController.favoritesDelegate = viewController as? EditFavoritesViewController
    }
    
 
    func show(_ currentElements: CategoryElements.Results) {
        let placeViewController = PlaceViewController()
        placeViewController.currentElement = currentElements
        viewController?.present(placeViewController, animated: true, completion: nil)
    }
    
    func show(_ error: Error) {
        let message: String = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
}
