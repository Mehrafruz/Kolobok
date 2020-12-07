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
    
    private let customYellowColor = UIColor(red: 255/255, green: 206/255, blue: 59/255, alpha: 1)
    private let customBlackColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
    private let customGrayColor = UIColor(red: 177/255, green: 190/255, blue: 197/255, alpha: 1)
    
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
        titleLabel.font = UIFont(name: "POEVeticaVanta", size: 20)
        
        [adressLabel,subwayLabel,timeLabel].forEach{
            ($0).font = UIFont(name: "POEVeticaVanta", size: 15)
        }
        subwayLabel.textColor = customBlackColor
        backgroundColor = .white
        
        [categoryImageView, adressImageView, timeTableImageView, subwayImageView, adressLabel, titleLabel, timeLabel, subwayLabel].forEach { contentView.addSubview($0) }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImageView.layer.cornerRadius = 10
        categoryImageView.clipsToBounds = true //без этой штуки не применится cornerRadius
        
        categoryImageView.pin
            .size(92)
            .left(12)
        
        titleLabel.pin
            .left(112)
            .right(12)
            .height(30)
         //   .sizeToFit(.height)
        
        adressLabel.pin
            .below(of: titleLabel)
            .left(139)
            .right(12)
            .height(20)
            //.sizeToFit(.height)
        
        adressImageView.pin
            .below(of: titleLabel)
            .left(112)
            .size(20)
        
        timeLabel.pin
            .below(of: adressLabel)
            .left(139)
            .right(12)
            .height(20)
       //     .sizeToFit(.height)
        
        timeTableImageView.pin
            .below(of: adressLabel)
            .left(112)
            .size(20)
        
        subwayLabel.pin
            .below(of: timeLabel)
            .left(139)
            .right(12)
            .height(20)
           // .sizeToFit(.height)
        
        subwayImageView.pin
            .below(of: timeLabel)
            .left(112)
            .size(20)
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
