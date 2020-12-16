//
//  SearchPresenter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 15.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class SearchPresenter {
	weak var view: SearchViewInput?
    weak var moduleOutput: SearchModuleOutput?

	private let router: SearchRouterInput
	private let interactor: SearchInteractorInput

    init(router: SearchRouterInput, interactor: SearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchModuleInput {
}

extension SearchPresenter: SearchViewOutput {
    var itemsCount: Int {
        globalSearchElements.count
    }
    
    func item(at index: Int) -> SearchTableViewCellModel {
        let searchPlace = globalSearchElements[index]
        return SearchTableViewCellModel(title: searchPlace.title)
    }
    
    func makeLoadSearchElements(with keyword: String) {
        interactor.loadSearchElements(with: keyword)
    }
    
}

extension SearchPresenter: SearchInteractorOutput {
    func didLoadSearchElements(searchElements: SearchElements?) {
        globalSearchElements = searchElements!.results
        if !globalSearchElements.isEmpty{
            view?.update()
        }
    }
    
    func didFail(with error: Error) {
        
    }
    
    
}
