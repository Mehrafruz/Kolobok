//
//  MeCollectionViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 24.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

struct FavoretiPlaceViewCellModel {
    let imageURL: URL?
    let title: String
}

protocol ReusableViewCell: AnyObject {
    static var identifier: String { get }
}

class MeCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private let titleLabel = UILabel()
    private let favoritePlaceImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
        setupLabel(label: titleLabel, text: "", fontSize: 14)
    }
    
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
        contentView.backgroundColor = ColorPalette.gray
        contentView.addSubview(favoritePlaceImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLabel(label: UILabel, text: String, fontSize: CGFloat){
        label.font = UIFont(name: "POEVeticaVanta", size: fontSize)
        label.textColor = ColorPalette.black
        label.text = text
        label.textAlignment = .center
    }
    
    private func setupLayouts() {
        [favoritePlaceImageView, titleLabel].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
    
        NSLayoutConstraint.activate([
            favoritePlaceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoritePlaceImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoritePlaceImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoritePlaceImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            titleLabel.topAnchor.constraint(equalTo: favoritePlaceImageView.bottomAnchor),
            //titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with categoryItem: CategoriesItem) {
        favoritePlaceImageView.image = UIImage(named: categoryItem.imageName)
    }
    
    func configure(with model: FavoretiPlaceViewCellModel) {
        favoritePlaceImageView.kf.setImage(with: model.imageURL)
        titleLabel.text = model.title
    }

}

extension MeCollectionViewCell: ReusableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}


