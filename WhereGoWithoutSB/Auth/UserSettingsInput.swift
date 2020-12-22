//
//  UserSettingsProtocol.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 20.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

protocol UserSettingsInput {
    func addUserData(name: String, email: String)
}

extension UserSettingsInput{
    func addUserData(name: String, email: String){
        UserSettings.userName = name
        //MARK: пока непонятно нужно ли хранить email
    }
}
