//
//  PlaceViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 22.11.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import PinLayout
import Foundation
import Firebase
import FirebaseStorage

class PlaceViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var placeImagesURLs: [CategoryElements.Results.Images] = []
    let titleLabel = UILabel()
    let adressLabel = UILabel()
    let timeTableLabel = UILabel()
    let phoneLabel = UILabel()
    let descriptionTextView = UITextView()
    let subwayLabel = UILabel()
    private let customLine0 = UITableViewCell()
    private let customLine1 = UITableViewCell()
    private let customLine2 = UITableViewCell()
    private let customLine3 = UITableViewCell()
    private let customLine4 = UITableViewCell()
    private let customLine5 = UITableViewCell()
    private let swipeLine = UITableViewCell()
    let likeImage = UIImageView()
    let reviewLabel = UILabel()
    
    private let likeButton = UIButton()
    private let reviewButton = UIButton()
    private let showOnMapButton = UIButton()
    private let goBackButton = UIButton()
    
    private let adressImageView = UIImageView()
    private let timeImageView = UIImageView()
    private let subwayImageView = UIImageView()
    private let phoneImageView = UIImageView()
    
    private let imagesPageControl = UIPageControl()
    private let imageCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
        viewLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width, height: 412)
        viewLayout.minimumInteritemSpacing = 0
        viewLayout.minimumLineSpacing = 0
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var currentElement: CategoryElements.Results!

    
    override func viewDidAppear(_ animated: Bool) {
        //MARK: чтобы прокрутка скрола нормально заработала сонтентсайз вызывай тут
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1200)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        didAddPlaceToVisited()
    }
    
    func setup(){
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        placeImagesURLs = currentElement.images
        setupLittleButton(button: goBackButton, imageName: "", bgImageName: "arrow.left", tintColor: ColorPalette.gray)
        goBackButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        showOnMapButton.addTarget(self, action: #selector(didClickedShowOnMapButton), for: .touchUpInside)
        imageCollectionView.layer.zPosition = -0.1
        
        
       
        setupLittleButton(button: showOnMapButton, imageName: "location.fill", bgImageName: "", tintColor: ColorPalette.black)
        showOnMapButton.backgroundColor = ColorPalette.gray
        showOnMapButton.alpha = 0.8
    
        setupButton(button: reviewButton, title: "Оставить отзыв", color: ColorPalette.gray, textColor: .white)
        setupButton(button: likeButton, title: "", color: ColorPalette.yellow, textColor: .white)
        likeButton.addTarget(self, action: #selector(didClickedLikeButton), for: .touchUpInside)
        setupLikeImage()
        likeImage.tintColor = ColorPalette.black
        likeImage.layer.zPosition = 2
        
        if !currentElement.short_title.isEmpty{
            titleLabel.text = currentElement.short_title
        } else
        {
            titleLabel.text = currentElement.title
        }
        titleLabel.font = UIFont(name: "POEVeticaVanta", size: 25)
        titleLabel.textAlignment = .center
        
        adressLabel.text = currentElement.address
        if !currentElement.timetable.isEmpty{
            timeTableLabel.text = currentElement.timetable
        } else {
            timeTableLabel.text = "не регламентированно"
        }
        
        if !currentElement.phone.isEmpty{
            phoneLabel.text = currentElement.phone
        } else {
            phoneLabel.text = "отсутствует"
        }
       
        if !currentElement.subway.isEmpty{
            subwayLabel.text = currentElement.subway
        } else {
            subwayLabel.text = "далеко от метро"
        }
        [timeTableLabel,phoneLabel,subwayLabel].forEach {
            ($0).numberOfLines = 2
            ($0).lineBreakMode = .byClipping
        }
       
        
        setupDescriptionTextView()
        
        setupImageView(imageView: adressImageView, imageName: "adress")
        setupImageView(imageView: timeImageView, imageName: "timeTable")
        setupImageView(imageView: subwayImageView, imageName: "subway")
        phoneImageView.image = UIImage(systemName: "phone.circle.fill")
        phoneImageView.tintColor = ColorPalette.blue
            
        
        
        [adressLabel, timeTableLabel, phoneLabel, subwayLabel].forEach {
            ($0).font = UIFont(name: "POEVeticaVanta", size: 18)
        }
        
        [adressLabel, timeTableLabel, phoneLabel, subwayLabel].forEach {
            ($0).textColor = ColorPalette.black
        }
        
        [customLine0, customLine1, customLine2, customLine3, customLine4, customLine5].forEach {
            ($0).backgroundColor = ColorPalette.gray
        }
        
        setupCollectionView(imageCollectionView)
        setupPageControl(pageControl: imagesPageControl)
        
        view.addSubview(scrollView)
        
        [goBackButton].forEach {
            imageCollectionView.addSubview($0)
        }
        
        [imageCollectionView, imagesPageControl, titleLabel, adressLabel, timeTableLabel, phoneLabel, descriptionTextView, adressImageView, timeImageView, subwayImageView, phoneImageView, subwayLabel, customLine0, customLine1, customLine2, customLine3, customLine4, customLine5, likeButton, reviewLabel, likeImage, showOnMapButton].forEach { scrollView.addSubview($0) }
        addConstraints() //reviewButton
                         //MARK: решено пока без отзывов(
    }
    
    func setupImageView(imageView: UIImageView, imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    func setupLikeImage(){
        let currentId = currentElement.id
        if globalAppUser.favoritePlaces.contains(currentId){
            likeImage.image = UIImage(systemName: "heart.fill")
        } else {
            likeImage.image = UIImage(systemName: "heart")
        }
    }
    
    func setupDescriptionTextView(){
        let descriptionText = currentElement.description + currentElement.body_text
        descriptionTextView.text = descriptionText
        descriptionTextView.font = UIFont(name: "POEVeticaVanta", size: 18)
        descriptionTextView.isEditable = false
        descriptionTextView.textColor = ColorPalette.darkGray
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 17)
        button.backgroundColor = color
        button.layer.zPosition = 1.5
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func setupLittleButton(button: UIButton, imageName: String, bgImageName: String, tintColor: UIColor) {
        button.setImage( UIImage(systemName: imageName), for: UIControl.State.normal)
        button.setBackgroundImage( UIImage(systemName: bgImageName), for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.tintColor = tintColor
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.isPagingEnabled = true
    }
    
    private func setupPageControl(pageControl: UIPageControl){
        pageControl.backgroundColor = UIColor.clear
        pageControl.numberOfPages = currentElement.images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = ColorPalette.black
    }
    
    
    
    func addConstraints(){
        [goBackButton, imageCollectionView, imagesPageControl, titleLabel, adressLabel, timeTableLabel, phoneLabel, descriptionTextView, adressImageView, timeImageView, subwayImageView, phoneImageView, subwayLabel, customLine0, customLine1, customLine2, customLine3, customLine4, customLine5, likeButton, reviewLabel, likeImage, showOnMapButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false      //reviewButton
                                                                        //MARK: решено пока без отзывов(
        }
        
        NSLayoutConstraint.activate([
            goBackButton.widthAnchor.constraint(equalToConstant: 30),
            goBackButton.heightAnchor.constraint(equalToConstant: 30),
            goBackButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            goBackButton.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            imageCollectionView.widthAnchor.constraint(equalToConstant: self.scrollView.bounds.width),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 400),
            imageCollectionView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            imageCollectionView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
            imageCollectionView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            showOnMapButton.widthAnchor.constraint(equalToConstant: 50),
            showOnMapButton.heightAnchor.constraint(equalToConstant: 50),
            showOnMapButton.topAnchor.constraint(equalTo: self.imageCollectionView.bottomAnchor, constant: -25),
            showOnMapButton.rightAnchor.constraint(equalTo: self.imageCollectionView.rightAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            imagesPageControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0.0),
            imagesPageControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0.0),
            imagesPageControl.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            imagesPageControl.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, constant: 400)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant:  380),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 420),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            customLine0.heightAnchor.constraint(equalToConstant: 0.5),
            customLine0.widthAnchor.constraint(equalToConstant: 350),
            customLine0.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 461),
            customLine0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.heightAnchor.constraint(equalToConstant: 265),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 360),
            descriptionTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 465),
        ])
        
        NSLayoutConstraint.activate([
            customLine1.heightAnchor.constraint(equalToConstant: 0.5),
            customLine1.widthAnchor.constraint(equalToConstant: 350),
            customLine1.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 735),
            customLine1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            adressImageView.heightAnchor.constraint(equalToConstant: 30),
            adressImageView.widthAnchor.constraint(equalToConstant: 30),
            adressImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 750),
            adressImageView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            adressLabel.heightAnchor.constraint(equalToConstant: 60),
            adressLabel.widthAnchor.constraint(equalToConstant: 350),
            adressLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 740),
            adressLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 50),
            adressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            customLine2.heightAnchor.constraint(equalToConstant: 0.5),
            customLine2.widthAnchor.constraint(equalToConstant: 350),
            customLine2.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 790),
            customLine2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            timeImageView.heightAnchor.constraint(equalToConstant: 25),
            timeImageView.widthAnchor.constraint(equalToConstant: 25),
            timeImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 798),
            timeImageView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            timeTableLabel.heightAnchor.constraint(equalToConstant: 60),
            timeTableLabel.widthAnchor.constraint(equalToConstant: 350),
            timeTableLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 795),
            timeTableLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 50),
            timeTableLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            customLine3.heightAnchor.constraint(equalToConstant: 0.5),
            customLine3.widthAnchor.constraint(equalToConstant: 350),
            customLine3.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 845),
            customLine3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            subwayImageView.heightAnchor.constraint(equalToConstant: 25),
            subwayImageView.widthAnchor.constraint(equalToConstant: 25),
            subwayImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 842),
            subwayImageView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            subwayLabel.heightAnchor.constraint(equalToConstant: 60),
            subwayLabel.widthAnchor.constraint(equalToConstant: 350),
            subwayLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 860),
            subwayLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 50),
            subwayLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            customLine4.heightAnchor.constraint(equalToConstant: 0.5),
            customLine4.widthAnchor.constraint(equalToConstant: 350),
            customLine4.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 900),
            customLine4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            phoneImageView.heightAnchor.constraint(equalToConstant: 25),
            phoneImageView.widthAnchor.constraint(equalToConstant: 25),
            phoneImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 886),
            phoneImageView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            phoneLabel.heightAnchor.constraint(equalToConstant: 60),
            phoneLabel.widthAnchor.constraint(equalToConstant: 350),
            phoneLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 905),
            phoneLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 50),
            phoneLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            customLine5.heightAnchor.constraint(equalToConstant: 0.5),
            customLine5.widthAnchor.constraint(equalToConstant: 350),
            customLine5.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 955),
            customLine5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 50),
            likeButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2-50),
            likeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            likeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            likeImage.heightAnchor.constraint(equalToConstant: 30),
            likeImage.widthAnchor.constraint(equalToConstant: 35),
            likeImage.centerXAnchor.constraint(equalTo: likeButton.centerXAnchor),
            likeImage.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
        ])
        
//        NSLayoutConstraint.activate([
//            reviewButton.heightAnchor.constraint(equalToConstant: 50),
//            reviewButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2-50),
//            reviewButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
//            reviewButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32),
//        ])
        
    }
    
    @objc func didClickedGoBackButton() {
        self.dismiss(animated: true, completion: nil)
       // navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func didClickedShowOnMapButton() {
        present(PlaceInMapViewController(lat: currentElement.coords.lat, lon: currentElement.coords.lon),animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        imagesPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    @objc
    func didClickedLikeButton(){
        if globalAppUser.name.isEmpty{
            present(SignInViewController(), animated: true)
        } else {
            let currentId = currentElement.id
            if globalAppUser.favoritePlaces.contains(currentId){
                guard let index = globalAppUser.favoritePlaces.firstIndex(of: currentId) else { return }
                globalAppUser.favoritePlaces.remove(at: index)
                likeImage.image = UIImage(systemName: "heart")
                uploadFavoritePlaces(currentUserId: globalAppUser.id)
            } else {
                globalAppUser.favoritePlaces.append(currentId)
                likeImage.image = UIImage(systemName: "heart.fill")
                uploadFavoritePlaces(currentUserId: globalAppUser.id)
            }
        }
    }
    
    func didAddPlaceToVisited(){
        if !globalAppUser.email.isEmpty || !globalAppUser.name.isEmpty{
            if globalAppUser.viewedPlaces.count > 10{
                globalAppUser.viewedPlaces.removeFirst()
                uploadViewedPlaces(currentUserId: globalAppUser.id)
            }
            if !(globalAppUser.viewedPlaces.contains(currentElement.id)){
                globalAppUser.viewedPlaces.append(currentElement.id)
                uploadViewedPlaces(currentUserId: globalAppUser.id)
            } else {
                globalAppUser.viewedPlaces.firstIndex(of: currentElement.id).map { _ = globalAppUser.viewedPlaces.remove(at: $0) }
                globalAppUser.viewedPlaces.append(currentElement.id)
                uploadViewedPlaces(currentUserId: globalAppUser.id)
            }
        }
    }
    
}

extension PlaceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentElement.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? PlaceCollectionViewCell else {
            return .init()
        }
        cell.setupImage(imageURL: currentElement.images[indexPath.row].image)
        return cell
    }
    
    
}

extension PlaceViewController: FireStoreFavoritePlacesInput{
    func uploadViewedPlaces(currentUserId: String) {
        let referenceUsers = Database.database().reference()
        referenceUsers.child("users/\(currentUserId)/viewedPlaces").setValue(globalAppUser.viewedPlaces)
    }
    
    func uploadFavoritePlaces(currentUserId: String) {
        let referenceUsers = Database.database().reference()
        referenceUsers.child("users/\(currentUserId)/favoritePlaces").setValue(globalAppUser.favoritePlaces)
    }
    
    
}
