//
//  ParkTableViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 23.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import Kingfisher
import PinLayout

struct CategoryTableViewCellModel {
    let imageURL: URL?
    let title: String
    let adress: String
    let timeString: String?
    let subway: String?
}

class CategoryTableViewCell: UITableViewCell {
    
    private let categoryImageView = UIImageView()
    private let adressImageView = UIImageView()
    private let timeTableImageView = UIImageView()
    private let subwayImageView = UIImageView()
    private let titleLabel = UILabel()
    private let adressLabel = UILabel()
    private let timeLabel = UILabel()
    private let subwayLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        adressImageView.image = UIImage(named: "adress")
        timeTableImageView.image = UIImage(named: "timeTable")
        subwayImageView.image = UIImage(named: "subway")
        titleLabel.font = UIFont(name: "NaturalMono-Regular", size: 23)
        adressLabel.font = UIFont(name: "NaturalMono-Regular", size: 14)
        subwayLabel.font = UIFont(name: "NaturalMono-Regular", size: 14)
        timeLabel.font = UIFont(name: "NaturalMono-Regular", size: 14)
        subwayLabel.textColor = .darkGray
        backgroundColor = .white
        
        [categoryImageView, adressImageView, timeTableImageView, subwayImageView, adressLabel, titleLabel, timeLabel, subwayLabel].forEach { contentView.addSubview($0) }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImageView.layer.cornerRadius = 10
        categoryImageView.clipsToBounds = true
        
        categoryImageView.pin
            .size(90)
            .left(12)
            .height(92)
        
        titleLabel.pin
            .left(112)
            .top(12)
            .height(25)
            .sizeToFit(.height)
        
        adressLabel.pin
            .below(of: titleLabel)
            .left(139)
            .top(12)
            .height(15)
            .sizeToFit(.height)
        
        adressImageView.pin
            .below(of: titleLabel)
            .left(112)
            .top(12)
            .size(15)
            .height(15)
        
        timeLabel.pin
            .below(of: adressLabel)
            .left(139)
            .height(15)
            .sizeToFit(.height)
        
        timeTableImageView.pin
            .below(of: adressLabel)
            .left(112)
            .top(12)
            .size(15)
            .height(15)
        
        subwayLabel.pin
            .below(of: timeLabel)
            .left(139)
            .height(15)
            .sizeToFit(.height)
        
        subwayImageView.pin
            .below(of: timeLabel)
            .left(112)
            .top(12)
            .size(15)
            .height(15)
    }
    
    func configure(with model: CategoryTableViewCellModel) {
        categoryImageView.kf.setImage(with: model.imageURL)
        titleLabel.text = model.title
        adressLabel.text = model.adress
        timeLabel.text = model.timeString
        subwayLabel.text = model.subway
        setNeedsLayout()
    }

}
