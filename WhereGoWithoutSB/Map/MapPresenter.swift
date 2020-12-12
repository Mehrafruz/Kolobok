//
//  MapPresenter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 12.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class MapPresenter {
	weak var view: MapViewInput?
    weak var moduleOutput: MapModuleOutput?

	private let router: MapRouterInput
	private let interactor: MapInteractorInput
    
    private var categoryElements: [CategoryElements.Results] = []
    
    init(router: MapRouterInput, interactor: MapInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MapPresenter: MapModuleInput {
}

extension MapPresenter: MapViewOutput {
    func categoriesElementsIsLoad(){
        interactor.loadCategoriesElements()
    }
    
}




extension MapPresenter: MapInteractorOutput {
    func didLoadCategoriesElements(categoriesElements: CategoryElements?) {
        categoryElements = categoriesElements!.results
        if !categoryElements.isEmpty{
            view?.update()
        }
    }
    
    func didFail(with error: Error) {
        //router.show(error)
    }
    
}
