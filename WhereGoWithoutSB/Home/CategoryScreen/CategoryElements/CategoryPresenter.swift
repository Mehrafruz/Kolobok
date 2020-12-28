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
    func tableView(filter: String) {
        interactor.loadCurrentCategoryElements(with: filter, with: 1)
    }
    
        
    func didSelect(at index: Int) {
        if !categoryElements.isEmpty{
            let element = categoryElements[index]
            router.show(element)
        }else{
            return
        }
    }
    
    func didSelectFilter(){
        router.showFilter()
    }
    
    func item(at index: Int) -> CategoryTableViewCellModel {
        if !categoryElements.isEmpty{
            let categoryElement = categoryElements[index]
            return CategoryTableViewCellModel(imageURL: categoryElement.imageURL,title: categoryElement.short_title, adress: categoryElement.address, timeString: categoryElement.timetable, subway: categoryElement.subway)
        } else {
            interactor.loadCurrentCategoryElements(with: "", with: 1) //MARK: тут заглушка
        }
        return CategoryTableViewCellModel(imageURL: nil, title: "someTitle", adress: "", timeString: "", subway: "")
    }
    
    var itemsCount: Int {
        return categoryElements.count
       }
    
//    func isLoadingCell(for indexPath: IndexPath) -> Bool {
//      return indexPath.row >= itemsCount
//    }
    
    
}

extension CategoryPresenter: CategoryInteractorOutput {
    func didLoadCurrentCategoryElements(currentCategoryElements: CategoryElements?) {
        categoryElements.append(contentsOf: currentCategoryElements!.results)
        if !categoryElements.isEmpty{
            view?.update()
        }
    }
    
    
    func didFail(with error: Error) {
    //MARK: кидает ошибку, разобраться
       // router.show(error)
    }
    
    }

