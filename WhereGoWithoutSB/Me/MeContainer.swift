//
//  MeContainer.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

final class MeContainer {
    let input: MeModuleInput
	let viewController: UIViewController
	private(set) weak var router: MeRouterInput!

	class func assemble(with context: MeContext) -> MeContainer {
        let router = MeRouter()
        let interactor = MeInteractor(networkManager: SearchNetworkManager.shared)
        let presenter = MePresenter(router: router, interactor: interactor)
		let viewController = MeViewController(output: presenter)

        presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return MeContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MeModuleInput, router: MeRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct MeContext {
	weak var moduleOutput: MeModuleOutput?
}
