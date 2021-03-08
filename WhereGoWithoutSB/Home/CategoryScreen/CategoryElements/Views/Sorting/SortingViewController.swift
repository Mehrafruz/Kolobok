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
    private var scrollView = UIScrollView()

    private let contentView = UIView()
    private var exitButton = UIButton()
    private var emplyButton = UIButton()
    private var popularPlacesButton = UIButton()
    private var rankPlacesButton = UIButton()
    private var popularPlacesLabel = UILabel()
    private var rankPlacesLabel = UILabel()
    private var customLine0 = UITableViewCell()
    private var customLine1 = UITableViewCell()
    
   
    private var flagPopularPlaces = false
    private var flagRankPlaces = false
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 600)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        contentView.backgroundColor = .white
    }
    
    func setup (){
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        setupLittleButton(button: popularPlacesButton, image: UIImage(systemName: "square")!, tintColor: ColorPalette.gray)
        setupLittleButton(button: rankPlacesButton, image: UIImage(systemName: "square")!, tintColor: ColorPalette.gray)
        setupLittleButton(button: exitButton, image: UIImage(systemName: "xmark")!, tintColor: ColorPalette.black)
        
        setupButton(button: emplyButton, title: "Применить", color: ColorPalette.yellow, textColor: ColorPalette.black)
        
        setupLabel(label: popularPlacesLabel, text: "По популярности", fontSize: 20)
        setupLabel(label: rankPlacesLabel, text: "По рейтингу", fontSize: 20)
        
        popularPlacesButton.addTarget(self, action: #selector(didClickedPopularPlacesButton), for: .touchUpInside)
        rankPlacesButton.addTarget(self, action: #selector(didClickedIsClosedPlacesButton), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        emplyButton.addTarget(self, action: #selector(didClickedEmplyButton), for: .touchUpInside)
        
        [customLine0, customLine1].forEach {
            ($0).backgroundColor =  ColorPalette.gray
        }
        
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        
        [exitButton, popularPlacesLabel, popularPlacesButton, rankPlacesLabel, rankPlacesButton, customLine0, customLine1, emplyButton].forEach{
            scrollView.addSubview($0)
        }
        addConstraints()
    }
    
    func addConstraints() {
        [contentView, scrollView, exitButton, popularPlacesLabel, popularPlacesButton, rankPlacesLabel, rankPlacesButton, customLine0, customLine1, emplyButton].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
            
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
            
            NSLayoutConstraint.activate([
                exitButton.widthAnchor.constraint(equalToConstant: 30),
                exitButton.heightAnchor.constraint(equalToConstant: 30),
                exitButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
                exitButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
            ])
            
            NSLayoutConstraint.activate([
                popularPlacesButton.widthAnchor.constraint(equalToConstant: 35),
                popularPlacesButton.heightAnchor.constraint(equalToConstant: 35),
                popularPlacesButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                popularPlacesButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120)
            ])
            
            NSLayoutConstraint.activate([
                popularPlacesLabel.widthAnchor.constraint(equalToConstant: 170),
                popularPlacesLabel.heightAnchor.constraint(equalToConstant: 40),
                popularPlacesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
                popularPlacesLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120)
            ])
            
            NSLayoutConstraint.activate([
                customLine0.widthAnchor.constraint(equalToConstant: 300),
                customLine0.heightAnchor.constraint(equalToConstant: 0.5),
                customLine0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine0.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 155)
            ])
            
            NSLayoutConstraint.activate([
                rankPlacesButton.widthAnchor.constraint(equalToConstant: 35),
                rankPlacesButton.heightAnchor.constraint(equalToConstant: 35),
                rankPlacesButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                rankPlacesButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 170)
            ])
            
            NSLayoutConstraint.activate([
                rankPlacesLabel.widthAnchor.constraint(equalToConstant: 170),
                rankPlacesLabel.heightAnchor.constraint(equalToConstant: 40),
                rankPlacesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
                rankPlacesLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 170)
            ])
            
            NSLayoutConstraint.activate([
                customLine1.widthAnchor.constraint(equalToConstant: 300),
                customLine1.heightAnchor.constraint(equalToConstant: 0.5),
                customLine1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 205)
            ])
            
            NSLayoutConstraint.activate([
                emplyButton.widthAnchor.constraint(equalToConstant: 150),
                emplyButton.heightAnchor.constraint(equalToConstant: 50),
                emplyButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                emplyButton.topAnchor.constraint(equalTo: customLine1.bottomAnchor, constant: 30)
               // emplyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
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
        if !flagRankPlaces && flagPopularPlaces{
            categoryView?.upplyFilter(with: "-favorites_count")
           // categoryView?.update()
        }
        if flagRankPlaces && !flagPopularPlaces{
            categoryView?.upplyFilter(with: "-rank")
          //  categoryView?.update()
        }
        if flagRankPlaces && flagPopularPlaces{
            categoryView?.upplyFilter(with: "-favorites_count,rank")
         //   categoryView?.update()
        }
         self.dismiss(animated: true, completion: nil)
    }
    
}



