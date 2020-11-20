//
//  CategoryCollectionViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 22.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
protocol ReusableView: AnyObject {
    static var identifier: String { get }
}


final class CategoryCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    private let categoryImageView: UIImageView = {
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
        
        contentView.addSubview(categoryImageView)
        
    }
    
    private func setupLayouts() {
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with categoryItem: CategoriesItem) {
        categoryImageView.image = UIImage(named: categoryItem.imageName)
    }
    
}

extension CategoryCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
