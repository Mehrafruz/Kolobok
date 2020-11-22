//
//  ParkTableViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 23.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

class ParkTableViewCell: UITableViewCell {
    
    var parkImageView: UIImageView = UIImageView()
    var parkNameLabel: UILabel = UILabel()
    var adressLabel: UILabel = UILabel()
    var timeTableLabel: UILabel = UILabel()
    var subwayLabel: UILabel = UILabel()
    var adressImageView: UIImageView = UIImageView()
    var timeTableImageView: UIImageView = UIImageView()
    var subwayImageView: UIImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(whereGoItem: whereGo){
        if let urlImage = URL(string: whereGoItem.imagesLinks[0]){
            if let data = try? Data(contentsOf: urlImage){
                parkImageView.image = UIImage(data: data)
            }
        }
        
        parkNameLabel.text = whereGoItem.eventName
        adressLabel.text = whereGoItem.location
        timeTableLabel.text = whereGoItem.timeTable
        subwayLabel.text = whereGoItem.subWay
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //------ где лучше вызывать эти функции?
        self.setupViews()
        self.setupLayouts()
    }
    
    
    private func setupViews() {
        // imageView
        contentView.clipsToBounds = true
        parkImageView.contentMode = .scaleAspectFill
        parkImageView.layer.cornerRadius = 10
        //без этой штуки углы закруглятся не будут
        parkImageView.clipsToBounds = true
        contentView.addSubview(parkImageView)
        
        //adressImage
        adressImageView.contentMode = .scaleAspectFill
        adressImageView.layer.cornerRadius = 5
        adressImageView.clipsToBounds = true
        adressImageView.image = UIImage(named: "adress")
        contentView.addSubview(adressImageView)
        
        //timeTableImage
        timeTableImageView.contentMode = .scaleAspectFill
        timeTableImageView.layer.cornerRadius = 5
        timeTableImageView.clipsToBounds = true
        timeTableImageView.image = UIImage(named: "timeTable")
        contentView.addSubview(timeTableImageView)
        
        //subwayImage
        subwayImageView.contentMode = .scaleAspectFill
        subwayImageView.layer.cornerRadius = 5
        subwayImageView.clipsToBounds = true
        subwayImageView.image = UIImage(named: "subway")
        contentView.addSubview(subwayImageView)
        
        //parkName
        parkNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        parkNameLabel.textColor = #colorLiteral(red: 0.1215686275, green: 0.1176470588, blue: 0.137254902, alpha: 1)
        //parkNameLabel.text = "Park Gorkogo"
        contentView.addSubview(parkNameLabel)
        
        //adress
        adressLabel.font = UIFont.boldSystemFont(ofSize: 14)
        adressLabel.textColor = #colorLiteral(red: 0.1215686275, green: 0.1176470588, blue: 0.137254902, alpha: 1)
        //adressLabel.text = "ul. Lenina d. 5"
        contentView.addSubview(adressLabel)
        
        //timeTable
        timeTableLabel.font = UIFont.boldSystemFont(ofSize: 14)
        timeTableLabel.textColor = #colorLiteral(red: 0.1215686275, green: 0.1176470588, blue: 0.137254902, alpha: 1)
        //timeTableLabel.text = "we alwais open"
        contentView.addSubview(timeTableLabel)
        
        //subway
        subwayLabel.font = UIFont.boldSystemFont(ofSize: 14)
        subwayLabel.textColor = #colorLiteral(red: 0.1215686275, green: 0.1176470588, blue: 0.137254902, alpha: 1)
        //subwayLabel.text = "s. Oktyabrskaya"
        contentView.addSubview(subwayLabel)
    
    }
    
    private func setupLayouts() {
        parkImageView.translatesAutoresizingMaskIntoConstraints = false
        parkImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        parkImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        parkImageView.widthAnchor.constraint(equalToConstant:90).isActive = true
        parkImageView.heightAnchor.constraint(equalToConstant:90).isActive = true
        
        adressImageView.translatesAutoresizingMaskIntoConstraints = false
        adressImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: -10).isActive = true
        adressImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:110).isActive = true
        adressImageView.widthAnchor.constraint(equalToConstant:15).isActive = true
        adressImageView.heightAnchor.constraint(equalToConstant:15).isActive = true
        
        
        timeTableImageView.translatesAutoresizingMaskIntoConstraints = false
        timeTableImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: 5).isActive = true
        timeTableImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:110).isActive = true
        timeTableImageView.widthAnchor.constraint(equalToConstant:15).isActive = true
        timeTableImageView.heightAnchor.constraint(equalToConstant:15).isActive = true
        
        
        subwayImageView.translatesAutoresizingMaskIntoConstraints = false
        subwayImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: 20).isActive = true
        subwayImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:110).isActive = true
        subwayImageView.widthAnchor.constraint(equalToConstant:15).isActive = true
        subwayImageView.heightAnchor.constraint(equalToConstant:15).isActive = true
        
        
        parkNameLabel.translatesAutoresizingMaskIntoConstraints = false
        parkNameLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: -25).isActive = true
        parkNameLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:130).isActive = true
        parkNameLabel.widthAnchor.constraint(equalToConstant:200).isActive = true
        parkNameLabel.heightAnchor.constraint(equalToConstant:90).isActive = true
        
        
        adressLabel.translatesAutoresizingMaskIntoConstraints = false
        adressLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: -10).isActive = true
        adressLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:130).isActive = true
        adressLabel.widthAnchor.constraint(equalToConstant:200).isActive = true
        adressLabel.heightAnchor.constraint(equalToConstant:90).isActive = true
        
        
        timeTableLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTableLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: 5).isActive = true
        timeTableLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:130).isActive = true
        timeTableLabel.widthAnchor.constraint(equalToConstant:200).isActive = true
        timeTableLabel.heightAnchor.constraint(equalToConstant:90).isActive = true
        
        
        subwayLabel.translatesAutoresizingMaskIntoConstraints = false
        subwayLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: 20).isActive = true
        subwayLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:130).isActive = true
        subwayLabel.widthAnchor.constraint(equalToConstant:240).isActive = true
        subwayLabel.heightAnchor.constraint(equalToConstant:90).isActive = true
    }
    
}


extension ParkTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
