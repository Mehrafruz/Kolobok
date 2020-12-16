//
//  SearchNetworkManager.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 15.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation
import UIKit

enum SearchNetworkError: Error {
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


protocol SearchNetworkManagerDescription: AnyObject {
    func searchElements(keyword: String, completion: @escaping (Result<SearchElements, Error>) -> Void)
}


final class SearchNetworkManager: SearchNetworkManagerDescription {
    static let shared: SearchNetworkManagerDescription = SearchNetworkManager()
    
    func searchElements(keyword: String, completion: @escaping (Result<SearchElements, Error>) -> Void) {
        let urlString = "https://kudago.com/public-api/v1.4/search/?&q=\(keyword)&lang=&expand=&location=msk&ctype=place&is_free=&lat=&lon=&radius=".encodeUrl
        
        
        guard let url = URL(string: urlString) else {
            completion(.failure(SearchNetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(SearchNetworkError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let searchElements = try decoder.decode(SearchElements.self, from: data)
                completion(.success(searchElements))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    
}


extension String{
var encodeUrl : String
{
    return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
}
var decodeUrl : String
{
    return self.removingPercentEncoding!
}
}
