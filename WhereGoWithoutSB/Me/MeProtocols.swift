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
    var itemsCount: Int { get }
    func item(at index: Int) -> FavoretiPlaceViewCellModel
}

protocol MeInteractorInput: class {
    func loadCurrentCategoryElements(with id: Int)
}

protocol MeInteractorOutput: class {
    func didLoadCurrentElement (for id: Int, favoriteElement: CategoryElements?)
    func didFail(with error: Error)
}

protocol MeRouterInput: class {
    func show(_ currentElements: CategoryElements.Results)
    func show(_ error: Error)
}
