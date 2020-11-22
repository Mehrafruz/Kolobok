//
//  ParksProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 17.11.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol CategoryModuleInput: AnyObject {
    var moduleOutput: CategoryModuleOutput? { get }
}

protocol CategoryModuleOutput: AnyObject {
}

protocol CategoryViewInput: AnyObject {
     func update(at index: Int)
}

protocol CategoryViewOutput: AnyObject {
    var itemsCount: Int { get }
    func item(at index: Int) -> CategoryTableViewCellModel
    
    func didSelect(at index: Int)
}

protocol CategoryInteractorInput: AnyObject {
    func loadCurrentCategoryElements(for index: Int)
}

protocol CategoryInteractorOutput: AnyObject {
    func didLoadCurrentCategoryElements(for index: Int, currentCategoryElements: CategoryElements?)
    func didFail(with error: Error)
}

protocol CategoryRouterInput: AnyObject {
    func show(_ currentElements: CategoryElements.Results)
    func show(_ error: Error)
}

