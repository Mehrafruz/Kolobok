//
//  SortingViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 18.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

class SortingViewController: UIViewController {
    weak var categoryView: CategoryViewInput?
    
    private let contentView = UIView()
    private var exitButton = UIButton()
    private var emplyButton = UIButton()
    private var popularPlacesButton = UIButton()
    private var rankPlacesButton = UIButton()
    private var popularPlacesLabel = UILabel()
    private var rankPlacesLabel = UILabel()
    private var customLine0 = UITableViewCell()
    private var customLine1 = UITableViewCell()
    
    private let customYellowColor = UIColor(red: 255/255, green: 206/255, blue: 59/255, alpha: 1)
    private let customBlackColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
    private let customGrayColor = UIColor(red: 177/255, green: 190/255, blue: 197/255, alpha: 1)
    
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
        
        setupLittleButton(button: popularPlacesButton, image: UIImage(systemName: "square")!, tintColor: customGrayColor)
        setupLittleButton(button: rankPlacesButton, image: UIImage(systemName: "square")!, tintColor: customGrayColor)
        setupLittleButton(button: exitButton, image: UIImage(systemName: "xmark")!, tintColor: customBlackColor)
        
        setupButton(button: emplyButton, title: "Применить", color: customYellowColor, textColor: customBlackColor)
        
        setupLabel(label: popularPlacesLabel, text: "По популярности", fontSize: 20)
        setupLabel(label: rankPlacesLabel, text: "По рангу", fontSize: 20)
        
        popularPlacesButton.addTarget(self, action: #selector(didClickedPopularPlacesButton), for: .touchUpInside)
        rankPlacesButton.addTarget(self, action: #selector(didClickedIsClosedPlacesButton), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        emplyButton.addTarget(self, action: #selector(didClickedEmplyButton), for: .touchUpInside)
        
        [customLine0, customLine1].forEach {
            ($0).backgroundColor =  customGrayColor
        }
        
        view.addSubview(contentView)
        
        [exitButton, popularPlacesLabel, popularPlacesButton, rankPlacesLabel, rankPlacesButton, customLine0, customLine1, emplyButton].forEach{
            contentView.addSubview($0)
        }
        addConstraints()
    }
    
    func addConstraints() {
        [contentView, exitButton, popularPlacesLabel, popularPlacesButton, rankPlacesLabel, rankPlacesButton, customLine0, customLine1, emplyButton].forEach{
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
                popularPlacesButton.widthAnchor.constraint(equalToConstant: 35),
                popularPlacesButton.heightAnchor.constraint(equalToConstant: 35),
                popularPlacesButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -100),
                popularPlacesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120)
            ])
            
            NSLayoutConstraint.activate([
                popularPlacesLabel.widthAnchor.constraint(equalToConstant: 170),
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
                rankPlacesButton.widthAnchor.constraint(equalToConstant: 35),
                rankPlacesButton.heightAnchor.constraint(equalToConstant: 35),
                rankPlacesButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -100),
                rankPlacesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 170)
            ])
            
            NSLayoutConstraint.activate([
                rankPlacesLabel.widthAnchor.constraint(equalToConstant: 170),
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
            
            NSLayoutConstraint.activate([
                emplyButton.widthAnchor.constraint(equalToConstant: 150),
                emplyButton.heightAnchor.constraint(equalToConstant: 50),
                emplyButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                emplyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
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
        label.textColor = customBlackColor
        label.text = text
        label.textAlignment = .center
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 20)
        button.backgroundColor = color
        button.layer.zPosition = 1.5
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.6
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    @objc
    func didClickedPopularPlacesButton(){
        if !flagPopularPlaces {
            popularPlacesButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagPopularPlaces = true
        } else {
            popularPlacesButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagPopularPlaces = false
        }
    }
    
    @objc
    func didClickedIsClosedPlacesButton(){
        if !flagRankPlaces {
            rankPlacesButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagRankPlaces = true
        } else {
            rankPlacesButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagRankPlaces = false
        }
    }
    
    @objc
    func didClickedGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didClickedEmplyButton() {
        self.dismiss(animated: true, completion: nil)
        if !flagRankPlaces && flagPopularPlaces{
            categoryView?.upplyFilter(with: "-favorites_count")
            categoryView?.update()
        }
        if flagRankPlaces && !flagPopularPlaces{
            categoryView?.upplyFilter(with: "-rank")
            categoryView?.update()
        }
        if flagRankPlaces && flagPopularPlaces{
            categoryView?.upplyFilter(with: "-favorites_count,rank")
            categoryView?.update()
        }
    }
}


