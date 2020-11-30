//
//  PlaceViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 22.11.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import PinLayout
import Kingfisher


class PlaceViewController: UIViewController {

    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    let adressLabel = UILabel()
    let timeTableLabel = UILabel()
    let phoneLabel = UILabel()
    let descriptionLabel = UITextField()
    let subwayLabel = UILabel()
    let customLine0 = UITableViewCell()
    let customLine1 = UITableViewCell()
    let customLine2 = UITableViewCell()
    let customLine3 = UITableViewCell()
    let customLine4 = UITableViewCell()
    let swipeLine = UITableViewCell()
    let likeImage = UIImageView()
    let reviewLabel = UILabel()
    
    let likeButton = UIButton()
    let reviewButton = UIButton()
    //MARK: пределать button
    let exitButtonImage = UIImageView()

    var currentElement: CategoryElements.Results!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup(){
        mainImageView.kf.setImage(with: currentElement.imageURL)
        
        titleLabel.text = currentElement.title
        titleLabel.font = UIFont(name: "NaturalMono-Regular", size: 30)
        adressLabel.text = "Адрес: " + currentElement.address
        adressLabel.font = UIFont(name: "NaturalMono-Regular", size: 17)
        timeTableLabel.text = "Время работы: " + currentElement.timetable
        timeTableLabel.font = UIFont(name: "NaturalMono-Regular", size: 17)
        phoneLabel.text = "Телефон: " + currentElement.phone
        phoneLabel.font = UIFont(name: "NaturalMono-Regular", size: 17)
        descriptionLabel.text = "Описание: " + currentElement.description
        descriptionLabel.font = UIFont(name: "NaturalMono-Regular", size: 17)
        subwayLabel.text = "Станция метро: " + currentElement.subway
        subwayLabel.font = UIFont(name: "NaturalMono-Regular", size: 17)
        customLine0.backgroundColor = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
        customLine1.backgroundColor = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
        customLine2.backgroundColor = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
        customLine3.backgroundColor = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
        customLine4.backgroundColor = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
        swipeLine.backgroundColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)

        likeButton.backgroundColor = UIColor(red: 253/255, green: 247/255, blue: 152/255, alpha: 1)
        reviewButton.backgroundColor = UIColor(red: 177/255, green: 190/255, blue: 197/255, alpha: 1)
        
        likeImage.image = UIImage(systemName: "heart")
        likeImage.tintColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
        reviewLabel.text = "Оставить отзыв"
        reviewLabel.textColor = .white
        reviewLabel.font = UIFont(name: "NaturalMono-Regular", size: 17)
        
        exitButtonImage.image = UIImage(systemName: "xmark")
        exitButtonImage.tintColor = .white
        
        [mainImageView, titleLabel, adressLabel, timeTableLabel, phoneLabel, descriptionLabel, subwayLabel, customLine0, customLine1, customLine2, customLine3, customLine4, likeButton, reviewButton, likeImage, reviewLabel, exitButtonImage, swipeLine].forEach { view.addSubview($0) }
        addConstraint()
    }
    
    func addConstraint(){
        super.viewDidLayoutSubviews()
        
        mainImageView.layer.cornerRadius = 10
        mainImageView.clipsToBounds = true
        
        mainImageView.pin
            .top(2)
            .left(1)
            .right(1)
            .size(412)
        
        titleLabel.pin
            .below(of: mainImageView)
            .left(20)
            .right(20)
            .top(12)
            .height(35)
        
        customLine0.pin
            .below(of: titleLabel)
            .left(20)
            .right(20)
            .top(15)
            .height(0.5)
            .width(UIScreen.main.bounds.width-40)
        
        adressLabel.pin
            .below(of: customLine0)
            .left(20)
            .right(20)
            .top(15)
            .height(35)
        
        customLine1.pin
            .below(of: adressLabel)
            .left(20)
            .right(20)
            .top(15)
            .height(0.5)
            .width(UIScreen.main.bounds.width-40)
        
        timeTableLabel.pin
            .below(of: customLine1)
            .left(20)
            .right(20)
            .top(15)
            .height(35)
        
        customLine2.pin
            .below(of: timeTableLabel)
            .left(20)
            .right(20)
            .top(15)
            .height(0.5)
            .width(UIScreen.main.bounds.width-40)
        
        phoneLabel.pin
            .below(of: customLine2)
            .left(20)
            .right(20)
            .top(15)
            .height(35)
        
        customLine3.pin
            .below(of: phoneLabel)
            .left(20)
            .right(20)
            .top(15)
            .height(0.5)
            .width(UIScreen.main.bounds.width-40)
        
        subwayLabel.pin
            .below(of: customLine3)
            .left(20)
            .right(20)
            .top(15)
            .height(35)
        
        customLine4.pin
            .below(of: subwayLabel)
            .left(20)
            .right(20)
            .top(15)
            .height(0.5)
            .width(UIScreen.main.bounds.width-40)
        
        descriptionLabel.pin
            .below(of: customLine4)
            .left(20)
            .right(20)
            .top(15)
            .height(35)
            .width(UIScreen.main.bounds.width-40)
        
        likeButton.layer.cornerRadius = 10
        likeButton.clipsToBounds = true
        
        likeButton.pin
            .left(15)
            .bottom(100)
            .right(UIScreen.main.bounds.width/2-15)
            .width(UIScreen.main.bounds.width/2-22.5)
            .height(50)
        
        reviewButton.layer.cornerRadius = 10
        reviewButton.clipsToBounds = true
        
        reviewButton.pin
            .right(15)
            .bottom(100)
            .left(UIScreen.main.bounds.width/2+15)
            .width(UIScreen.main.bounds.width/2-22.5)
            .height(50)
        
        likeImage.pin
            .left(UIScreen.main.bounds.width/4-20)
            .bottom(105)
            .right(UIScreen.main.bounds.width/4-11)
            .width(50)
            .height(40)
        
        reviewLabel.pin
            .right(15)
            .bottom(100)
            .left(UIScreen.main.bounds.width/2+35)
            .width(UIScreen.main.bounds.width/2-7.5)
            .height(50)
        
        exitButtonImage.pin
            .right(15)
            .top(15)
            .size(30)
        
        swipeLine.pin
            .right(UIScreen.main.bounds.width - UIScreen.main.bounds.width/3)
            .left(UIScreen.main.bounds.width)
            .top(10)
            .width(1)
            .height(UIScreen.main.bounds.width/3)
    }
    
    
    

}
