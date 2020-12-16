//
//  SearchTableViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 16.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import PinLayout

struct SearchTableViewCellModel {
    let title: String
}

class SearchTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let customBlackColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        titleLabel.font = UIFont(name: "POEVeticaVanta", size: 20)
        titleLabel.textColor = customBlackColor
        [titleLabel].forEach{
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.pin
            .left(12)
            .top(5)
            .height(30)
            .width(superview?.layer.bounds.width ?? 100)
        
    }
    
    func configure(with model: SearchTableViewCellModel) {
        titleLabel.text = model.title
        
        setNeedsLayout()
    }
}
