//
//  MeProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol MeModuleInput {
    var moduleOutput: MeModuleOutput? { get }
}

protocol MeModuleOutput: class {
}

protocol MeViewInput: class {
    func update(at index: Int)
}

protocol MeViewOutput: class {
    func itemsCount (arr: [Int]) -> Int
    func item(at index: Int, at arr: [Int]) -> FavoretiPlaceViewCellModel
}

protocol MeInteractorInput: class {
    func loadCurrentCategoryElements(with id: Int, with arr: [Int])
}

protocol MeInteractorOutput: class {
    func didLoadCurrentElement (for id: Int, for arr: [Int], element: CategoryElements?)
    func didFail(with error: Error)
}

protocol MeRouterInput: class {
    func show(_ currentElements: CategoryElements.Results)
    func show(_ error: Error)
}
