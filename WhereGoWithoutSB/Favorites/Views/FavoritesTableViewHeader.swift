//
//  FavoritesTableViewHeader.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

 
protocol TableViewHeader: AnyObject {
    func didChangeSegment()
    func didTapProfileButton()
    func currentSegment(currentSegment: String)
}

class FavoritesTableViewHeader: UITableViewHeaderFooterView {
    
    weak var delegate: TableViewHeader?
    let titleLabel = UILabel()
    private let profileButton = UIButton()
    private var segmentedControl = UISegmentedControl()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSegmentedControll()
        setupLibel(label: titleLabel)
        setupLittleButton(button: profileButton, image: UIImage(named: "appIcon")!, tintColor: ColorPalette.black)//person.crop.circle
        profileButton.addTarget(self, action: #selector(didTabProfileButton), for: .touchUpInside)
        contentView.backgroundColor = .white
        [titleLabel, profileButton, segmentedControl].forEach {
            contentView.addSubview($0)
        }
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLibel(label: UILabel) {
        label.backgroundColor = .white
        label.text = "Избранное"
        label.font = UIFont(name: "POEVeticaVanta", size: 25)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
    }
    
    func setupSegmentedControll(){
        let items = ["Избранное" , "Просмотренное"]
        segmentedControl = UISegmentedControl(items : items)
        segmentedControl.center = self.contentView.center
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 3.0
        segmentedControl.backgroundColor = ColorPalette.gray
        //segmentedControl.tintColor = .yellow
    }
    
    func addConstraints(){
        [titleLabel, segmentedControl, profileButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            segmentedControl.widthAnchor.constraint(equalToConstant: 100),
            segmentedControl.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            segmentedControl.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    
        NSLayoutConstraint.activate([
            profileButton.widthAnchor.constraint(equalToConstant: 50),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
            profileButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            profileButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
        
        
    }
    
    func setupLittleButton(button: UIButton, image: UIImage, tintColor: UIColor) {
        button.setBackgroundImage( image, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.tintColor = tintColor
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFill
    }
    
    @objc
    func indexChanged(){
        if segmentedControl.selectedSegmentIndex == 1{
            self.delegate?.currentSegment(currentSegment: "Visited")
        }
        else if segmentedControl.selectedSegmentIndex == 0{
            self.delegate?.currentSegment(currentSegment: "Favorites")
        }
          self.delegate?.didChangeSegment()
    }
    
    @objc
    func didTabProfileButton(){
        delegate?.didTapProfileButton()
    }
    
    func configure(titleText: String, image: UIImage){
        titleLabel.text = titleText
        profileButton.setBackgroundImage(image, for: UIControl.State.normal)
    }

    
}
