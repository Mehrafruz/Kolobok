//
//  SearchElements.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 15.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

struct SearchElements: Codable {
    struct Results: Codable {
        let id: Int
        let title: String
        let address: String
        let phone: String
        let description: String
        let favorites_count: Int
        let coords: Coords

        struct Coords: Codable{
            let lat: Double
            let lon: Double
        }
    }
    
    let results: [Results]
}


