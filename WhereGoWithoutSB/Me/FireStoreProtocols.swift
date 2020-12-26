//
//  FireStoreInput.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//
import UIKit
import Foundation

protocol FireStoreAvatarInput{
    func uploadAvatarImage(currentUserId: String, photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void)
    func uploadAvatarURL (currentUserId: String)
}

protocol FireStoreAvatarOutput{
    func loadAvatarURL (avatarURL: String)
}

protocol FireStoreFavoritePlacesInput{
    func uploadFavoritePlaces (currentUserId: String)
    func uploadViewedPlaces (currentUserId: String)
}

protocol FireStoreFavoritePlacesOutput{
    func loadFavoritePlaces (currentUserId: String)
    func loadViewedPlaces (currentUserId: String)
    func getArrayInfo (id: String, key: String, completion: @escaping ([Int]) -> Void)
}


