//
//  SearchProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 15.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol SearchModuleInput {
	var moduleOutput: SearchModuleOutput? { get }
}

protocol SearchModuleOutput: class {
}

protocol SearchViewInput: class {
    func update()
}

protocol SearchViewOutput: class {
    var itemsCount: Int { get }
    func item(at index: Int) -> SearchTableViewCellModel
    func makeLoadSearchElements(with keyword: String)
}

protocol SearchInteractorInput: class {
    func loadSearchElements(with keyword: String)
}

protocol SearchInteractorOutput: class {
    func didLoadSearchElements( searchElements: SearchElements?)
    func didFail(with error: Error)
}

protocol SearchRouterInput: class {
}
