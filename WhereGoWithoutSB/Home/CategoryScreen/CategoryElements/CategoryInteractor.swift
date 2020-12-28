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
    let category: String
    
    init(category: String, networkManager: NetworkManagerDescription) {
        self.networkManager = networkManager
        self.category = category
    }
}

extension CategoryInteractor: CategoryInteractorInput{
    func loadCurrentCategoryElements(with filter: String, with page: Int) {
        networkManager.categoryElements(category: self.category, filter: filter, pageInt: page) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let categoryElements):
                    print (categoryElements)
                    self?.output?.didLoadCurrentCategoryElements(currentCategoryElements: categoryElements)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
    
}
