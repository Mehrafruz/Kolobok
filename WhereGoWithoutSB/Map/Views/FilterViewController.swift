//
//  FilterViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 03.03.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

protocol FilterWillApplied: AnyObject{
    func applyFilter(categories: String, page: Int)
}

class FilterViewController: UIViewController {
    
    weak var delegate: FilterWillApplied?
    
    private var scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var exitButton = UIButton()
    private var emplyButton = UIButton()
    
    private var parksButton = UIButton()
    private var questroomButton = UIButton()
    private var artplaysButton = UIButton()
    private var museumsButton = UIButton()
    private var restaurantButton = UIButton()
    private var barsButton = UIButton()
    private var attractionsButton = UIButton()
    private var clubsButton = UIButton()
    
    private var parksLabel = UILabel()
    private var questroomLabel = UILabel()
    private var artplaysLabel = UILabel()
    private var museumsLabel = UILabel()
    private var restaurantLabel = UILabel()
    private var barsLabel = UILabel()
    private var attractionsLabel = UILabel()
    private var clubsLabel = UILabel()
    
    private var customLine0 = UITableViewCell()
    private var customLine1 = UITableViewCell()
    private var customLine2 = UITableViewCell()
    private var customLine3 = UITableViewCell()
    private var customLine4 = UITableViewCell()
    private var customLine5 = UITableViewCell()
    private var customLine6 = UITableViewCell()
    private var customLine7 = UITableViewCell()
    
    private var flagParks = false
    private var flagQuestroom = false
    private var flagArtplays = false
    private var flagMuseums = false
    private var flagRestaurant = false
    private var flagBars = false
    private var flagAttractions = false
    private var flagClubs = false
    
   override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1200)
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
        
        setupLittleButton(button: exitButton, image: UIImage(systemName: "xmark")!, tintColor: ColorPalette.black)
        
         [parksButton, questroomButton, artplaysButton, museumsButton, restaurantButton, barsButton, attractionsButton, clubsButton].forEach{
            setupLittleButton(button: ($0), image: UIImage(systemName: "square")!, tintColor: ColorPalette.gray)
        }
        
        setupButton(button: emplyButton, title: "Применить", color: ColorPalette.yellow, textColor: ColorPalette.black)
        
        setupLabel(label: parksLabel, text: "Парки", fontSize: 20)
        setupLabel(label: questroomLabel, text: "Квесты", fontSize: 20)
        setupLabel(label: artplaysLabel, text: "Выставки", fontSize: 20)
        setupLabel(label: museumsLabel, text: "Квесты", fontSize: 20)
        setupLabel(label: restaurantLabel, text: "Рестораны", fontSize: 20)
        setupLabel(label: barsLabel, text: "Бары", fontSize: 20)
        setupLabel(label: attractionsLabel, text: "Интесности", fontSize: 20)
        setupLabel(label: clubsLabel, text: "Клубы", fontSize: 20)
        
        exitButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        emplyButton.addTarget(self, action: #selector(didClickedEmplyButton), for: .touchUpInside)
        
        parksButton.addTarget(self, action: #selector(didClickedParksButton), for: .touchUpInside)
        questroomButton.addTarget(self, action: #selector(didClickedQuestroomButton), for: .touchUpInside)
        artplaysButton.addTarget(self, action: #selector(didClickedArtplaysButton), for: .touchUpInside)
        museumsButton.addTarget(self, action: #selector(didClickedMuseumsButton), for: .touchUpInside)
        restaurantButton.addTarget(self, action: #selector(didClickedRestaurantButton), for: .touchUpInside)
        barsButton.addTarget(self, action: #selector(didClickedBarsButton), for: .touchUpInside)
        attractionsButton.addTarget(self, action: #selector(didClickedAttractionsButton), for: .touchUpInside)
        clubsButton.addTarget(self, action: #selector(didClickedClubsButton), for: .touchUpInside)
        
        [customLine0, customLine1, customLine2, customLine3, customLine4, customLine5, customLine6, customLine7].forEach {
            ($0).backgroundColor =  ColorPalette.gray
        }
        
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        
        [exitButton, emplyButton, parksLabel, parksButton, questroomButton, artplaysButton, museumsButton, restaurantButton, barsButton, attractionsButton, clubsButton, parksLabel, questroomLabel, artplaysLabel, museumsLabel, restaurantLabel, barsLabel, attractionsLabel, clubsLabel, customLine0, customLine1, customLine2, customLine3, customLine4, customLine5, customLine6, customLine7].forEach{
            scrollView.addSubview($0)
        }
        addConstraints()
    }
    
    func addConstraints() {
        let buttonSize: CGFloat = 35
        let lineSpacing: CGFloat = 15
        [contentView, scrollView, exitButton, emplyButton, parksLabel, parksButton, questroomButton, artplaysButton, museumsButton, restaurantButton, barsButton, attractionsButton, clubsButton, parksLabel, questroomLabel, artplaysLabel, museumsLabel, restaurantLabel, barsLabel, attractionsLabel, clubsLabel, customLine0, customLine1, customLine2, customLine3, customLine4, customLine5, customLine6, customLine7].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85).isActive = true
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
                exitButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
                exitButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
            ])
            
            NSLayoutConstraint.activate([
                parksButton.widthAnchor.constraint(equalToConstant: buttonSize),
                parksButton.heightAnchor.constraint(equalToConstant: buttonSize),
                parksButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                parksButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120)
            ])
            
            NSLayoutConstraint.activate([
                parksLabel.widthAnchor.constraint(equalToConstant: 170),
                parksLabel.heightAnchor.constraint(equalToConstant: 40),
                parksLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                parksLabel.topAnchor.constraint(equalTo: parksButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine0.widthAnchor.constraint(equalToConstant: 300),
                customLine0.heightAnchor.constraint(equalToConstant: 0.5),
                customLine0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine0.topAnchor.constraint(equalTo: parksButton.bottomAnchor)//155
            ])
            
            NSLayoutConstraint.activate([
                questroomButton.widthAnchor.constraint(equalToConstant: buttonSize),
                questroomButton.heightAnchor.constraint(equalToConstant: buttonSize),
                questroomButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                questroomButton.topAnchor.constraint(equalTo: parksButton.bottomAnchor, constant: lineSpacing)
            ])
            
            NSLayoutConstraint.activate([
                questroomLabel.widthAnchor.constraint(equalToConstant: 170),
                questroomLabel.heightAnchor.constraint(equalToConstant: 40),
                questroomLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                questroomLabel.topAnchor.constraint(equalTo: questroomButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine1.widthAnchor.constraint(equalToConstant: 300),
                customLine1.heightAnchor.constraint(equalToConstant: 0.5),
                customLine1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine1.topAnchor.constraint(equalTo: questroomButton.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                artplaysButton.widthAnchor.constraint(equalToConstant: buttonSize),
                artplaysButton.heightAnchor.constraint(equalToConstant: buttonSize),
                artplaysButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                artplaysButton.topAnchor.constraint(equalTo: questroomButton.bottomAnchor, constant: lineSpacing)
            ])
            
            NSLayoutConstraint.activate([
                artplaysLabel.widthAnchor.constraint(equalToConstant: 170),
                artplaysLabel.heightAnchor.constraint(equalToConstant: 40),
                artplaysLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                artplaysLabel.topAnchor.constraint(equalTo: artplaysButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine2.widthAnchor.constraint(equalToConstant: 300),
                customLine2.heightAnchor.constraint(equalToConstant: 0.5),
                customLine2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine2.topAnchor.constraint(equalTo: artplaysButton.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                museumsButton.widthAnchor.constraint(equalToConstant: buttonSize),
                museumsButton.heightAnchor.constraint(equalToConstant: buttonSize),
                museumsButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                museumsButton.topAnchor.constraint(equalTo: artplaysButton.bottomAnchor, constant: lineSpacing)
            ])
            
            NSLayoutConstraint.activate([
                museumsLabel.widthAnchor.constraint(equalToConstant: 170),
                museumsLabel.heightAnchor.constraint(equalToConstant: 40),
                museumsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                museumsLabel.topAnchor.constraint(equalTo: museumsButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine3.widthAnchor.constraint(equalToConstant: 300),
                customLine3.heightAnchor.constraint(equalToConstant: 0.5),
                customLine3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine3.topAnchor.constraint(equalTo: museumsButton.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                restaurantButton.widthAnchor.constraint(equalToConstant: buttonSize),
                restaurantButton.heightAnchor.constraint(equalToConstant: buttonSize),
                restaurantButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                restaurantButton.topAnchor.constraint(equalTo: museumsButton.bottomAnchor, constant: lineSpacing)
            ])
            
            NSLayoutConstraint.activate([
                restaurantLabel.widthAnchor.constraint(equalToConstant: 170),
                restaurantLabel.heightAnchor.constraint(equalToConstant: 40),
                restaurantLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                restaurantLabel.topAnchor.constraint(equalTo: restaurantButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine4.widthAnchor.constraint(equalToConstant: 300),
                customLine4.heightAnchor.constraint(equalToConstant: 0.5),
                customLine4.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine4.topAnchor.constraint(equalTo: restaurantButton.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                barsButton.widthAnchor.constraint(equalToConstant: buttonSize),
                barsButton.heightAnchor.constraint(equalToConstant: buttonSize),
                barsButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                barsButton.topAnchor.constraint(equalTo: restaurantButton.bottomAnchor, constant: lineSpacing)
            ])
            
            NSLayoutConstraint.activate([
                barsLabel.widthAnchor.constraint(equalToConstant: 170),
                barsLabel.heightAnchor.constraint(equalToConstant: 40),
                barsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                barsLabel.topAnchor.constraint(equalTo: barsButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine5.widthAnchor.constraint(equalToConstant: 300),
                customLine5.heightAnchor.constraint(equalToConstant: 0.5),
                customLine5.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine5.topAnchor.constraint(equalTo: barsButton.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                attractionsButton.widthAnchor.constraint(equalToConstant: buttonSize),
                attractionsButton.heightAnchor.constraint(equalToConstant: buttonSize),
                attractionsButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                attractionsButton.topAnchor.constraint(equalTo: barsButton.bottomAnchor, constant: lineSpacing)
            ])
            
            NSLayoutConstraint.activate([
                attractionsLabel.widthAnchor.constraint(equalToConstant: 170),
                attractionsLabel.heightAnchor.constraint(equalToConstant: 40),
                attractionsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                attractionsLabel.topAnchor.constraint(equalTo: attractionsButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine6.widthAnchor.constraint(equalToConstant: 300),
                customLine6.heightAnchor.constraint(equalToConstant: 0.5),
                customLine6.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine6.topAnchor.constraint(equalTo: attractionsButton.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                clubsButton.widthAnchor.constraint(equalToConstant: buttonSize),
                clubsButton.heightAnchor.constraint(equalToConstant: buttonSize),
                clubsButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
                clubsButton.topAnchor.constraint(equalTo: attractionsButton.bottomAnchor, constant: lineSpacing)
            ])
            
            NSLayoutConstraint.activate([
                clubsLabel.widthAnchor.constraint(equalToConstant: 170),
                clubsLabel.heightAnchor.constraint(equalToConstant: 40),
                clubsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                clubsLabel.topAnchor.constraint(equalTo: clubsButton.topAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine7.widthAnchor.constraint(equalToConstant: 300),
                customLine7.heightAnchor.constraint(equalToConstant: 0.5),
                customLine7.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine7.topAnchor.constraint(equalTo: clubsButton.bottomAnchor)
            ])
            
            
            NSLayoutConstraint.activate([
                emplyButton.widthAnchor.constraint(equalToConstant: 150),
                emplyButton.heightAnchor.constraint(equalToConstant: 50),
                emplyButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                emplyButton.topAnchor.constraint(equalTo: customLine7.bottomAnchor, constant: lineSpacing*2)
                // emplyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
            ])
        
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
    func didClickedParksButton(){
        if !flagParks {
            parksButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagParks = true
        } else {
            parksButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagParks = false
        }
    }
    
    @objc
    func didClickedQuestroomButton(){
        if !flagQuestroom {
            questroomButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagQuestroom = true
        } else {
            questroomButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagQuestroom = false
        }
    }
    
    @objc
    func didClickedArtplaysButton(){
        if !flagArtplays {
            artplaysButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagArtplays = true
        } else {
            artplaysButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagArtplays = false
        }
    }
    
    @objc
    func didClickedMuseumsButton(){
        if !flagMuseums {
            museumsButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagMuseums = true
        } else {
            museumsButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagMuseums = false
        }
    }
    
    @objc
    func didClickedRestaurantButton(){
        if !flagRestaurant {
            restaurantButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagRestaurant = true
        } else {
            restaurantButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagRestaurant = false
        }
    }
    
    @objc
    func didClickedBarsButton(){
        if !flagBars {
            barsButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagBars = true
        } else {
            barsButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagBars = false
        }
    }
    
    @objc
    func didClickedAttractionsButton(){
        if !flagAttractions {
            attractionsButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagAttractions = true
        } else {
            attractionsButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagAttractions = false
        }
    }
    
    @objc
    func didClickedClubsButton(){
        if !flagClubs {
            clubsButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flagClubs = true
        } else {
            clubsButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flagClubs = false
        }
    }
    
    
    @objc
    func didClickedGoBackButton() {
        exitButton.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didClickedEmplyButton() {
        emplyButton.pulsate()
        var flagBegin = false
        var filterParams =  ""
        if flagParks{
            if !flagBegin{
                flagBegin = true
            }
            filterParams = filterParams + "park"
        }
        if flagQuestroom{
            if !flagBegin{
                flagBegin = true
                filterParams = filterParams + "questroom"
            } else{
                filterParams = filterParams + ",questroom"
            }
        }
        if flagMuseums{
            if !flagBegin{
                flagBegin = true
                filterParams = filterParams + "museums"
            } else {
                filterParams = filterParams + ",museums"
            }
        }
        if flagArtplays{
            if !flagBegin{
                flagBegin = true
                filterParams = filterParams + "art-space"
            }
            filterParams = filterParams + ",art-space"
        }
        if flagRestaurant{
            if !flagBegin{
                flagBegin = true
                filterParams = filterParams + "restaurants"
            } else {
                filterParams = filterParams + ",restaurants"
            }
        }
        if flagBars{
            if !flagBegin{
                flagBegin = true
                filterParams = filterParams + "bar"
            } else {
                filterParams = filterParams + ",bar"
            }
        }
        if flagClubs{
            if !flagBegin{
                flagBegin = true
                filterParams = filterParams + "clubs"
            } else {
                filterParams = filterParams + ",clubs"
            }
        }
        if flagAttractions{
            if !flagBegin{
                flagBegin = true
                filterParams = filterParams + "attractions"
            } else {
                filterParams = filterParams + ",attractions"
            }
        }
        
        delegate?.applyFilter(categories: filterParams, page: 1)
        self.dismiss(animated: true, completion: nil)
    }
    


    

}
