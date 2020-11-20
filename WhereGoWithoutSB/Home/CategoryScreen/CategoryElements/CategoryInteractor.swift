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
    func loadCurrentCategoryElements(for category: String, for index: Int) {
        networkManager.categoryElements(category: category) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let categoryElements):
                    self?.output?.didLoadCurrentCategoryElements(for: index, currentCategoryElements: categoryElements)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
    
}
