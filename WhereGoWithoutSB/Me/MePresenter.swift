//
//  MePresenter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class MePresenter {
	weak var view: MeViewInput?
    weak var moduleOutput: MeModuleOutput?

	private let router: MeRouterInput
	private let interactor: MeInteractorInput
    
    private var currentFavoritePlacesById: [Int: CategoryElements.Results] = [:]

    init(router: MeRouterInput, interactor: MeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MePresenter: MeModuleInput {
}

extension MePresenter: MeViewOutput {
    var itemsCount: Int {
        globalAppUser.favoritePlaces.count
    }
    
    func item(at index: Int) -> FavoretiPlaceViewCellModel {
        let currentId = globalAppUser.favoritePlaces[index]
        if let currentElement = currentFavoritePlacesById[currentId] {
            return FavoretiPlaceViewCellModel(imageURL: currentElement.imageURL, title: currentElement.short_title)
        } else {
            interactor.loadCurrentCategoryElements(with: currentId)
        }
        
        return FavoretiPlaceViewCellModel(imageURL: nil, title: String(currentId))
    }
    
}

extension MePresenter: MeInteractorOutput {
    func didLoadCurrentElement( for id: Int, favoriteElement: CategoryElements?) {
        currentFavoritePlacesById[id] = favoriteElement!.results[0]
        if let index = globalAppUser.favoritePlaces.firstIndex(of: id){
            view?.update(at: index)
        }
    }
    
    func didFail(with error: Error) {
        
    }
    
}
