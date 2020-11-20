//
//  ParksInteractor.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 17.11.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class CategoryInteractor {
    private let networkManager: NetworkManagerDescription
    
    weak var output: CategoryInteractorOutput?
    
    init(networkManager: NetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension CategoryInteractor: CategoryInteractorInput{
    func loadCurrentParks(for category: String, for index: Int) {
        networkManager.parks() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let parks):
                    self?.output?.didLoadCurrentParks(for: index, currentParks: parks)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
    
}
