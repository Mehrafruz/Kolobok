//
//  MeInteractor.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class MeInteractor {
    private let networkManager: SearchNetworkManagerDescription
    
	weak var output: MeInteractorOutput?
    
    init(networkManager: SearchNetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension MeInteractor: MeInteractorInput {
    func loadCurrentCategoryElements(with id: Int) {
        networkManager.searchElement(id: id) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchElement):
                    self?.output?.didLoadCurrentElement(for: id, favoriteElement: searchElement)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
}
