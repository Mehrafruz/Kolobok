//
//  User.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 20.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation


struct User {
    var id: String
    var name: String
    var email: String
    var avatarURL: String
    var favoritePlaces: [Int]
    var viewedPlaces:[Int]
    
    
    init(id: String, name: String, email: String, avatarURL: String, favoritePlaces: [Int], viewedPlaces: [Int]) {
        self.id = id
        self.name = name
        self.email = email
        self.avatarURL = avatarURL
        self.favoritePlaces = favoritePlaces
        self.viewedPlaces = viewedPlaces
    }
    
}



