//
//  MapContainer.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 12.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

final class MapContainer {
    let input: MapModuleInput
	let viewController: UIViewController
	private(set) weak var router: MapRouterInput!

    class func assemble(with categories: String, with context: MapContext) -> MapContainer {
        let router = MapRouter()
        let interactor = MapInteractor(categories: categories, networkManager: NetworkManager.shared)
        let presenter = MapPresenter(router: router, interactor: interactor)
		let viewController = MapViewController(output: presenter)

        presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return MapContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MapModuleInput, router: MapRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct MapContext {
	weak var moduleOutput: MapModuleOutput?
}
