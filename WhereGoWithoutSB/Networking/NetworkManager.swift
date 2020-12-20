//
//  ParksNetworkManager.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 18.11.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case emptyData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "invalid url!!"
        case .emptyData:
            return "no data!!"
        }
    }
}

protocol NetworkManagerDescription: AnyObject {
    func categoryElements(category: String, filter: String, completion: @escaping (Result<CategoryElements, Error>) -> Void)
}

final class NetworkManager: NetworkManagerDescription {
    static let shared: NetworkManagerDescription = NetworkManager()

    
    func categoryElements(category: String, filter: String, completion: @escaping (Result<CategoryElements, Error>) -> Void) {
        let urlString = "https://kudago.com/public-api/v1.4/places/?lang=&fields=title,address,images,description,foreign_url,subway,timetable,favorites_count,phone,coords,short_title,body_text&expand=&order_by=\(filter)&text_format=text&ids=&location=msk&has_showings=&showing_since&showing_until&categories=\(category)&lon=&lat=&radius=&page=1&page_size=8"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let categoryElements = try decoder.decode(CategoryElements.self, from: data)
                completion(.success(categoryElements))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
}

