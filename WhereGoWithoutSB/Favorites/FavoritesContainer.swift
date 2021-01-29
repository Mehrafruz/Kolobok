//
//  FavoritesContainer.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

final class FavoritesContainer {
    let input: FavoritesModuleInput
	let viewController: UIViewController
	private(set) weak var router: FavoritesRouterInput!

	class func assemble(with context: FavoritesContext) -> FavoritesContainer {
        let router = FavoritesRouter()
        let interactor = FavoritesInteractor(networkManager: SearchNetworkManager.shared)
        let presenter = FavoritesPresenter(router: router, interactor: interactor)
		let viewController = FavoritesViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        router.viewController = viewController
        
        return FavoritesContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FavoritesModuleInput, router: FavoritesRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FavoritesContext {
	weak var moduleOutput: FavoritesModuleOutput?
}
