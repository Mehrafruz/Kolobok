//
//  MeTableViewCollectionCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 25.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

struct CollectionViewCellModel {
    var color: UIColor
    var name: String
}

class MeTableViewCell: UITableViewCell {

    var row: [CollectionViewCellModel]?
    var rowWithColors: [CollectionViewCellModel]?
    
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(elementsArray: [Int]){
       // self.elementsArray = elementsArray
    }
    
    func addConstraints() {
//        NSLayoutConstraint.activate([
//            .topAnchor.constraint(equalTo: contentView.topAnchor),
//            .bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            .leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            .rightAnchor.constraint(equalTo: contentView.rightAnchor)
//        ])
    }
}

