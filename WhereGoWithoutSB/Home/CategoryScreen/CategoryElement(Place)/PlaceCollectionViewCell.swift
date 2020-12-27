//
//  PlaceCollectionViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 04.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import Kingfisher

class PlaceCollectionViewCell: UICollectionViewCell {
    private var indicatorView = UIActivityIndicatorView(style: .large)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   private let placeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12.0
        contentView.backgroundColor = .white
        indicatorView.center = contentView.center
        indicatorView.color = ColorPalette.black
        [placeImageView, indicatorView].forEach{
            contentView.addSubview($0)
        }
        
        placeImageView.isHidden = true
        indicatorView.startAnimating()
    }
    
    private func setupLayouts(){
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage (imageURL: String){
        guard let url = URL(string: imageURL) else {
            print ("error: the image didn't load")
            return
        }
        placeImageView.kf.setImage(with: url)
        placeImageView.isHidden = false
        indicatorView.stopAnimating()
    }
    
}


