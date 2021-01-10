//
//  Observable.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 10.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

class Observable {
    var state: Bool = {
        return false
    }()
    
    private lazy var observers = [Observer]()
    
    func subscribe (_ observer: Observer){
        observers.append(observer)
    }
    
    func unsubsribe (_ observer: Observer){
        if let index = observers.firstIndex(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }
    
    func notify() {
        observers.forEach( {$0.update(subject: self)} )
    }
    
    func didChooseItem (at index: Int) {
        notify()
    }
}
