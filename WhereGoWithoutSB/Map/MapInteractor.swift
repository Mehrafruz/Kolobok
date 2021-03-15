//
//  MapInteractor.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 12.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class MapInteractor {
    private let networkManager: NetworkManagerDescription
    
    weak var output: MapInteractorOutput?
    let category: String
    
    init(categories: String, networkManager: NetworkManagerDescription) {
        self.networkManager = networkManager
        self.category = categories
    }
}

extension MapInteractor: MapInteractorInput {
    func loadCategoriesElements(categories: String, pageInt: Int, pageSize: Int) {
        networkManager.categoryElements(category: categories, filter: "", pageInt: pageInt, pageSize: pageSize) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let categoryElements):
                    self?.output?.didLoadCategoriesElements(categoriesElements: categoryElements)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
        }

}
