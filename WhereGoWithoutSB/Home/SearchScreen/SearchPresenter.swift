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
    func didLoadCurrentSearchElement(searchElement: CategoryElements?) {
        globalSearchElement = searchElement!.results
        if !globalSearchElement.isEmpty{
            router.show(globalSearchElement[0])
        }
     
    }
    
    func didLoadSearchElements(searchElements: SearchElements?) {
        globalSearchElements = searchElements!.results
        view?.update()
    }

    
    func didFail(with error: Error) {
        print ("did fail when load searchElements")
    }
    
    func didSelect(with index: Int) {
        if !globalSearchElements.isEmpty{
            interactor.loadCurrentSearchElement(with: globalSearchElements[index].id)
        }
    }
    
}
