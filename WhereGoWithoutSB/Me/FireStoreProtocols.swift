//
//  FireStoreInput.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//
import UIKit
import Foundation

protocol FireStoreInput{
    func uploadAvatarImage(currentUserId: String, photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void)
    func uploadAvatarURL (currentUserId: String)
    func loadAvatarURL (avatarURL: String)
}

