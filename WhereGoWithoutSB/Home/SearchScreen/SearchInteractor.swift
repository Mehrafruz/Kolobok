//
//  SearchInteractor.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 15.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class SearchInteractor {
    private let networkManager: SearchNetworkManagerDescription
    
    weak var output: SearchInteractorOutput?
    
    init(networkManager: SearchNetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension SearchInteractor: SearchInteractorInput {

    func loadSearchElements(with keyword: String) {
        networkManager.searchElements(keyword: keyword) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchElements):
                    self?.output?.didLoadSearchElements(searchElements: searchElements)
                    print ("searchElements is____________ \(searchElements)")
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
}
