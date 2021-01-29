//
//  UserSettingsProtocol.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 20.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol UserSettingsInput {
    func addUserData(id: String, name: String, email: String, imageData: String, rememberUser: Bool)
}

extension UserSettingsInput{
    func addUserData(id: String, name: String, email: String, imageData: String, rememberUser: Bool){
        UserSettings.id = id
        UserSettings.userName = name
        UserSettings.email = email
        UserSettings.imageData = imageData
        UserSettings.rememberUser = rememberUser
    }
    
}
