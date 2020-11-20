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
    func item(at category: String, at index: Int) -> CategoryTableViewCellModel
}

protocol CategoryInteractorInput: AnyObject {
    func loadCurrentParks(for category: String, for index: Int)
}

protocol CategoryInteractorOutput: AnyObject {
    func didLoadCurrentParks(for index: Int, currentParks: Category?)
    func didFail(with error: Error)
}

protocol CategoryRouterInput: AnyObject {
    func show(_ currentParks: Category)
    func show(_ error: Error)
}

