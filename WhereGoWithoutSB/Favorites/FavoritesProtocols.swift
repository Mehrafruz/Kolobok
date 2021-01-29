//
//  FavoritesProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

protocol FavoritesModuleInput {
	var moduleOutput: FavoritesModuleOutput? { get }
}

protocol FavoritesModuleOutput: class {
}

protocol FavoritesViewInput: class {
    func updateCell(at index: Int) 
}

protocol FavoritesViewOutput: class {
    func itemsCount (arr: [Int]) -> Int
    func item(at index: Int, at arr: [Int]) -> FavoritesTableViewCellModel
    func didSelect(at id: Int)
    func didTapProfileButton()
}

protocol FavoritesInteractorInput: class {
    func loadCurrentFavoriteElements(with id: Int, with arr: [Int])
}
    

protocol FavoritesInteractorOutput: class {
    func didLoadCurrentElement (for id: Int, for arr: [Int], element: CategoryElements?)
    func didFail(with error: Error)
}

protocol FavoritesRouterInput: class {
    func show(_ currentElements: CategoryElements.Results)
    func showProfile()
    func show(_ error: Error)
}



