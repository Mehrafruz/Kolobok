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
        case id
        case userName
        case imageData
        case rememberUser
    }
    
    static var id: String!{
        get{
            return UserDefaults.standard.string(forKey: SettingsKeys.id.rawValue)
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingsKeys.id.rawValue
            if let id = newValue {
                print ("value \(id) was added to \(key)")
                defaults.set(id, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
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
    
    static var imageData: String!{
        get{
            return UserDefaults.standard.string(forKey: SettingsKeys.imageData.rawValue)
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingsKeys.imageData.rawValue
            if let imageData = newValue {
                print ("value \(imageData) was added to \(key)")
                defaults.set(imageData, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var rememberUser: Bool!{
        get{
            return UserDefaults.standard.bool(forKey: SettingsKeys.rememberUser.rawValue)
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingsKeys.rememberUser.rawValue
            if let rememberUser = newValue {
                print ("value \(rememberUser) was added to \(key)")
                defaults.set(rememberUser, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    func removeCurrentUser(){
        let defaults = UserDefaults.standard

        defaults.removeObject(forKey: SettingsKeys.id.rawValue)
        defaults.removeObject(forKey: SettingsKeys.userName.rawValue)
        defaults.removeObject(forKey: SettingsKeys.imageData.rawValue)
        defaults.removeObject(forKey: SettingsKeys.rememberUser.rawValue)
    }
}
