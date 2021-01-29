//
//  FavoritesTableViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit
import Kingfisher

struct FavoritesTableViewCellModel{
    let imageURL: URL?
    let title: String
    let subway: String?
    var iconName: String
}

class FavoritesTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let subwayLabel = UILabel()
    private let placeImageView = UIImageView()
    private let favoriteIconImageView = UIImageView()
    private let subwayIconImageView = UIImageView()
    private var indicatorView = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupViews(){
        titleLabel.font = UIFont(name: "POEVeticaVanta", size: 20)
        indicatorView.color = ColorPalette.black
        indicatorView.startAnimating()
        [subwayLabel, titleLabel].forEach{
            ($0).numberOfLines = 2
            ($0).lineBreakMode = .byClipping
        }
       
        [subwayLabel].forEach{
            ($0).font = UIFont(name: "POEVeticaVanta", size: 12)
        }
        subwayLabel.textColor = ColorPalette.black
        backgroundColor = .white
        
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.layer.cornerRadius = 8
        placeImageView.clipsToBounds = true
        
        favoriteIconImageView.image = UIImage(systemName: "heart.fill")
        favoriteIconImageView.tintColor = ColorPalette.black//yellow
        
        
        
        [indicatorView, placeImageView, titleLabel, subwayLabel, favoriteIconImageView, subwayIconImageView].forEach {
            contentView.addSubview($0)
           // ($0).backgroundColor = .black
        }
    }
    
    func addConstraints(){
        [indicatorView, placeImageView, titleLabel, subwayLabel, favoriteIconImageView, subwayIconImageView].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 40),
            indicatorView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            placeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            placeImageView.widthAnchor.constraint(equalToConstant: 120),
            placeImageView.heightAnchor.constraint(equalToConstant: 90),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: placeImageView.rightAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -55),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        NSLayoutConstraint.activate([
            subwayIconImageView.topAnchor.constraint(equalTo: favoriteIconImageView.bottomAnchor, constant: 25),
            subwayIconImageView.leftAnchor.constraint(equalTo: placeImageView.rightAnchor, constant: 15),
            subwayIconImageView.widthAnchor.constraint(equalToConstant: 15),
            subwayIconImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        NSLayoutConstraint.activate([
            subwayLabel.topAnchor.constraint(equalTo: favoriteIconImageView.bottomAnchor, constant: 15),
            subwayLabel.leftAnchor.constraint(equalTo: subwayIconImageView.rightAnchor, constant: 5),
            subwayLabel.widthAnchor.constraint(equalToConstant: 90),
            subwayLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            favoriteIconImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 18),
            favoriteIconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            favoriteIconImageView.widthAnchor.constraint(equalToConstant: 30),
            favoriteIconImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        
    }
    
    func configure(with model: FavoritesTableViewCellModel) {
        placeImageView.kf.setImage(with: model.imageURL)
        if model.title.isEmpty{
            subwayIconImageView.isHidden = true
            favoriteIconImageView.isHidden = true
            indicatorView.startAnimating()
        }
        titleLabel.text = model.title
        if !model.title.isEmpty{
            favoriteIconImageView.image = UIImage(systemName: model.iconName)
            subwayIconImageView.image = UIImage(named: "subway")
            indicatorView.stopAnimating()
            subwayIconImageView.isHidden = false
            favoriteIconImageView.isHidden = false
        }
        if !model.subway!.isEmpty{
            subwayLabel.text = model.subway
        } else {
            subwayLabel.text = "далеко от метро"
        }
        
    }
    
}
