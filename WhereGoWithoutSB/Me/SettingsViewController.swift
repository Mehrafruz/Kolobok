//
//  SettingsViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 27.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    weak var categoryView: CategoryViewInput?
    
    private var exitButton = UIButton()
    private let contentView = UIView()
    private var popularPlacesLabel = UILabel()
    private var rankPlacesLabel = UILabel()
    private var customLine0 = UITableViewCell()
    private var customLine1 = UITableViewCell()
    
    
    private var flagPopularPlaces = false
    private var flagRankPlaces = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        contentView.backgroundColor = .white
    }
    
    func setup (){
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        setupLittleButton(button: exitButton, image: UIImage(systemName: "xmark")!, tintColor: ColorPalette.black)
        exitButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        setupLabel(label: popularPlacesLabel, text: "Тут короче можно будет", fontSize: 20)
        setupLabel(label: rankPlacesLabel, text: "поменять имя и пароль :)", fontSize: 20)
        
        [customLine0, customLine1].forEach {
            ($0).backgroundColor =  ColorPalette.gray
        }
        
        view.addSubview(contentView)
        
        [exitButton, popularPlacesLabel, rankPlacesLabel, customLine0, customLine1].forEach{
            contentView.addSubview($0)
        }
        addConstraints()
    }
    
    func addConstraints() {
        [contentView, exitButton, popularPlacesLabel, rankPlacesLabel, customLine0, customLine1].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
            
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            NSLayoutConstraint.activate([
                exitButton.widthAnchor.constraint(equalToConstant: 30),
                exitButton.heightAnchor.constraint(equalToConstant: 30),
                exitButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                exitButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
            ])
            
            
            NSLayoutConstraint.activate([
                popularPlacesLabel.widthAnchor.constraint(equalToConstant: 270),
                popularPlacesLabel.heightAnchor.constraint(equalToConstant: 40),
                popularPlacesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
                popularPlacesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120)
            ])
            
            NSLayoutConstraint.activate([
                customLine0.widthAnchor.constraint(equalToConstant: 300),
                customLine0.heightAnchor.constraint(equalToConstant: 0.5),
                customLine0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                customLine0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 155)
            ])
            
           
            NSLayoutConstraint.activate([
                rankPlacesLabel.widthAnchor.constraint(equalToConstant: 270),
                rankPlacesLabel.heightAnchor.constraint(equalToConstant: 40),
                rankPlacesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
                rankPlacesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 170)
            ])
            
            NSLayoutConstraint.activate([
                customLine1.widthAnchor.constraint(equalToConstant: 300),
                customLine1.heightAnchor.constraint(equalToConstant: 0.5),
                customLine1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                customLine1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 205)
            ])
            
        }
    }
    
    func setupLittleButton(button: UIButton, image: UIImage, tintColor: UIColor) {
        let image = image
        button.setBackgroundImage( image, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.tintColor = tintColor
    }
    
    func setupLabel(label: UILabel, text: String, fontSize: CGFloat){
        label.font = UIFont(name: "POEVeticaVanta", size: fontSize)
        label.textColor = ColorPalette.black
        label.text = text
        label.textAlignment = .center
    }
    
    @objc
    func didClickedGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}



