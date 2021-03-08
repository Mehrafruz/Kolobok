//
//  FavoritesPresenter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

final class FavoritesPresenter {
	weak var view: FavoritesViewInput?
    weak var moduleOutput: FavoritesModuleOutput?

	private let router: FavoritesRouterInput
	private let interactor: FavoritesInteractorInput
    
    private var currentPlacesById: [Int: CategoryElements.Results] = [:]

    init(router: FavoritesRouterInput, interactor: FavoritesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavoritesPresenter: FavoritesModuleInput {
}

extension FavoritesPresenter: FavoritesViewOutput {
    func didTapProfileButton() {
        
    }
    
    func itemsCount(arr: [Int]) -> Int {
        return arr.count
    }
    
    func item(at index: Int, at arr: [Int]) -> FavoritesTableViewCellModel {
        if index < arr.count{
            let currentId = arr.reversed()[index]
            if let currentElement = currentPlacesById[currentId] {
                var title = currentElement.short_title
                if currentElement.short_title.isEmpty{
                    title = currentElement.title
                }
                return FavoritesTableViewCellModel(imageURL: currentElement.imageURL, title: title, subway: currentElement.subway, iconName: "")
            } else {
                interactor.loadCurrentFavoriteElements(with: currentId, with: arr)
            }
        }
        return FavoritesTableViewCellModel(imageURL: nil, title: "", subway: " ", iconName: "")
    }
    
    
    func didSelect(at id: Int) {
        guard let currentPlace = currentPlacesById[id] else {
            return
        }
        router.show(currentPlace)
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput {
    func didLoadCurrentElement(for id: Int, for arr: [Int], element: CategoryElements?) {
        guard let elem = element else {
            return
        }
        currentPlacesById[id] = elem.results[0]
        let revArr: [Int] = arr.reversed()
        if let index = revArr.firstIndex(of: id){
            view?.updateCell(at: index)
        }
    }
    
    func didFail(with error: Error) {
        //print("did fail in favoritesPresenter")
    }
    
}
