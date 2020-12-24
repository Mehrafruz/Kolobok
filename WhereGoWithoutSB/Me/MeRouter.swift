//
//  MeRouter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

final class MeRouter {
    weak var viewController: UIViewController?
}

extension MeRouter: MeRouterInput {
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
