//
//  AythProtocols.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 11.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

protocol Observer: class {
  
    func update(subject: Observable)
    
}

//weak var objects: [NSObjectProtocol] { set }
//var objects: NSArray <NSObject> {get set}
//var objects: [Object] {get set}
//var objects: [NSObjectProtocol]? {get set}
//let objects: [NSObject]? {get}
//var objects: Array <NSObjectProtocol>? {get set}



//@property (nonatomic, readwrite, nullable, copy)
//NSArray <id<NSObject>> *object;
