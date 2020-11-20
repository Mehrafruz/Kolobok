//
//  WhereGoPark.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 23.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

struct CategoryElements: Codable {
    struct Results: Codable {
        let title: String
        let address: String
        let timetable: String
        let phone: String
        let description: String
        let subway: String
        let favorites_count: Int
        let images: [Images]
        
        struct Images: Codable{
            let image: String
        }
        
        var imageURL: URL? {
            URL(string: images[0].image)
        }
    }
    
    let results: [Results]
}


