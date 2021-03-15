//
//  MapProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 12.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol MapModuleInput {
	var moduleOutput: MapModuleOutput? { get }
}

protocol MapModuleOutput: class {
}

protocol MapViewInput: class {
     func update()
}

protocol MapViewOutput: class {
    func categoriesElementsIsLoad(categories: String, page: Int, pageSize: Int)
    func didSelect(at index: Int)
    func didSelectFilter()
}

protocol MapInteractorInput: class {
    func loadCategoriesElements(categories: String, pageInt: Int, pageSize: Int)
}

protocol MapInteractorOutput: class {
    func didLoadCategoriesElements( categoriesElements: CategoryElements?)
    func didFail(with error: Error)
}

protocol MapRouterInput: class {
    func showFilter()
    func show(_ currentElements: CategoryElements.Results)
    func show(_ error: Error)
}
