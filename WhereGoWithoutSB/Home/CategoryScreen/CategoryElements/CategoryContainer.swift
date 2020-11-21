//
//  ParksContainer.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 17.11.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

final class CategoryContainer {
    let input: CategoryModuleInput
    let viewController: UIViewController
    private(set) weak var router: CategoryRouterInput!

    class func assemble(with category: String, with context: CategoryContext) -> CategoryContainer {
        let router = CategoryRouter()
        let interactor = CategoryInteractor (category: category, networkManager: NetworkManager.shared)
        let presenter = CategoryPresenter(router: router, interactor: interactor)
        let viewController = CategoryViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter
        
        
        router.viewController = viewController

        return CategoryContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: CategoryModuleInput, router: CategoryRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct CategoryContext {
    weak var moduleOutput: CategoryModuleOutput?
}
