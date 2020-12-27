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
    
    private var currentPlacesById: [Int: CategoryElements.Results] = [:]

    init(router: MeRouterInput, interactor: MeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MePresenter: MeModuleInput {
}

extension MePresenter: MeViewOutput {
    func didSelect(at id: Int) {
        guard let currentPlace = currentPlacesById[id] else {
            return
        }
        router.show(currentPlace)
       
    }
    
    func itemsCount (arr: [Int]) -> Int {
        return arr.count
    }
    
    func item(at index: Int, at arr: [Int]) -> FavoretiPlaceViewCellModel {
        let currentId = arr[index]
        if let currentElement = currentPlacesById[currentId] {
            return FavoretiPlaceViewCellModel(imageURL: currentElement.imageURL, title: currentElement.short_title)
        } else {
            interactor.loadCurrentCategoryElements(with: currentId, with: arr)
        }
        
        return FavoretiPlaceViewCellModel(imageURL: nil, title: "")
    }
    
}

extension MePresenter: MeInteractorOutput {
    func didLoadCurrentElement( for id: Int, for arr: [Int], element: CategoryElements?) {
        currentPlacesById[id] = element!.results[0]
        if let index = arr.firstIndex(of: id){
            view?.update(at: index)
        }
    }
    
    func didFail(with error: Error) {
        
    }
    
}
