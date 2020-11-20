//
//  ParksPresenter.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 17.11.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class CategoryPresenter {
    weak var view: CategoryViewInput?
    weak var moduleOutput: CategoryModuleOutput?
    
    private let router: CategoryRouterInput
    private let interactor: CategoryInteractorInput

    private var categoryElements: [CategoryElements.Results] = []
    
    init(router: CategoryRouterInput, interactor: CategoryInteractorInput) {
           self.router = router
           self.interactor = interactor
       }
}

extension CategoryPresenter: CategoryModuleInput {
}

extension CategoryPresenter: CategoryViewOutput {
   
    
    func item(at category: String, at index: Int) -> CategoryTableViewCellModel {
        if !categoryElements.isEmpty{
            let categoryElement = categoryElements[index]
            return CategoryTableViewCellModel(imageURL: categoryElement.imageURL,title: categoryElement.title, adress: categoryElement.address, timeString: categoryElement.timetable, subway: categoryElement.subway)
        } else {
            interactor.loadCurrentCategoryElements(for: "some", for: index)
        }
        return CategoryTableViewCellModel(imageURL: nil, title: "someTitle", adress: "", timeString: "", subway: "")
    }
    
    
    var itemsCount: Int {
        return 20
       }
    
    
}

extension CategoryPresenter: CategoryInteractorOutput {
    func didLoadCurrentCategoryElements(for index: Int, currentCategoryElements: CategoryElements?) {
        categoryElements = currentCategoryElements!.results
        if !categoryElements.isEmpty{
            view?.update(at: index)
        }
    }
    
    func didFail(with error: Error) {
    //MARK: кидает ошибку, разобраться
       // router.show(error)
    }
    
    }

