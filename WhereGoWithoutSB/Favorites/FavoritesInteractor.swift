//
//  FavoritesInteractor.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

final class FavoritesInteractor {
    private let networkManager: SearchNetworkManagerDescription
    
	weak var output: FavoritesInteractorOutput?
    
    init(networkManager: SearchNetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension FavoritesInteractor: FavoritesInteractorInput {
    func loadCurrentFavoriteElements(with id: Int, with arr: [Int]) {
        networkManager.searchElement(id: id) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchElement):
                    self?.output?.didLoadCurrentElement(for: id, for: arr, element: searchElement)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
}
