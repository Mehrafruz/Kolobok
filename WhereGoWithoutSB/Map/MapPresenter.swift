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
    
    
    
    init(router: MapRouterInput, interactor: MapInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MapPresenter: MapModuleInput {
}

extension MapPresenter: MapViewOutput {
    func didSelect(at index: Int) {
        if !globalCategoriesElements.isEmpty{
            let category = globalCategoriesElements[index]
            router.show(category)
        }else{
            return
        }
    }
    
    func categoriesElementsIsLoad(categories: String, page: Int){
        interactor.loadCategoriesElements(categories: "", pageInt: page)
    }
    
    func didSelectFilter(){
        router.showFilter()
    }
    
}


extension MapPresenter: MapInteractorOutput {
    func didLoadCategoriesElements(categoriesElements: CategoryElements?) {
        globalCategoriesElements = categoriesElements!.results
        if !globalCategoriesElements.isEmpty{
            view?.update()
        }
    }
    
    func didFail(with error: Error) {
        //router.show(error)
    }
    
}
