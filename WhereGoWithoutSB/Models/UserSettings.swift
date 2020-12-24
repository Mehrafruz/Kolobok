//
//  UserSettings.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 20.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation

final class UserSettings{
    
    private enum SettingsKeys: String{
        case userName
    }
    
    static var userName: String!{
        get{
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
                if let name = newValue {
                    print ("value \(name) was added to \(key)")
                    defaults.set(name, forKey: key)
                } else {
                    defaults.removeObject(forKey: key)
            }
        }
    }
      //MARK: пока непонятно нужно ли хранить email
}
