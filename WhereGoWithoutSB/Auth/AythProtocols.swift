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
