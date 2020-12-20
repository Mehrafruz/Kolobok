//
//  User.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 20.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation


struct User {
    var name: String
    var surname: String
    var favorites: [Int]
    
    
    init(name: String, surname: String, favorites: [Int]) {
        self.name = name
        self.surname = surname
        self.favorites = favorites
    }
    
}


var appUser = User(name: "", surname: "", favorites: [])
