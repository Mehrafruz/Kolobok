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
    func update()
    func upplyFilter(with filterValue: String)
}

protocol CategoryViewOutput: AnyObject {
    var itemsCount: Int { get }
    func item(at index: Int) -> CategoryTableViewCellModel
    func tableView(filter: String, pageInt: Int)
    func sortingTableView(filter: String, pageInt: Int)
    func didSelect(at index: Int)
    func didSelectFilter()
    var countElementsToPages: Int { get set}
    func removeCategoryElements()
}

protocol CategoryInteractorInput: AnyObject {
    func loadCurrentCategoryElements(with filter: String, with page: Int)
    
}

protocol CategoryInteractorOutput: AnyObject {
    func didLoadCurrentCategoryElements( currentCategoryElements: CategoryElements?)
    func didFail(with error: Error)
}

protocol CategoryRouterInput: AnyObject {
    func show(_ currentElements: CategoryElements.Results)
    func showFilter ()
    func show(_ error: Error)
}


