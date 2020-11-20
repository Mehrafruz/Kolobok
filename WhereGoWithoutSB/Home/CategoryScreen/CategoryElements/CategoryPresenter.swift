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

    private var parks: [Category.Results] = []
    
    init(router: CategoryRouterInput, interactor: CategoryInteractorInput) {
           self.router = router
           self.interactor = interactor
       }
}

extension CategoryPresenter: CategoryModuleInput {
}

extension CategoryPresenter: CategoryViewOutput {
   
    
    func item(at category: String, at index: Int) -> CategoryTableViewCellModel {
        if !parks.isEmpty{
            let park = parks[index]
            return CategoryTableViewCellModel(imageURL: park.imageURL,title: park.title, adress: park.address, timeString: park.timetable, subway: park.subway)
        } else {
            interactor.loadCurrentParks(for: "some", for: index)
        }
        return CategoryTableViewCellModel(imageURL: nil, title: "someTitle", adress: "", timeString: "", subway: "")
    }
    
    
    var itemsCount: Int {
        return 20
       }
    
    
}

extension CategoryPresenter: CategoryInteractorOutput {
    func didLoadCurrentParks(for index: Int, currentParks: Category?) {
        parks = currentParks!.results
        if !parks.isEmpty{
            view?.update(at: index)
        }
    }
    
    func didFail(with error: Error) {
    //MARK: кидает ошибку, разобраться
       // router.show(error)
    }
    
    }

