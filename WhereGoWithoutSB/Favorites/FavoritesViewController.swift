//
//  FavoritesViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

protocol MainViewDelegate: AnyObject{
    func openSignIn()
    func dismissMeView()
}

    weak var delegate: MainViewDelegate?

final class FavoritesViewController: UIViewController {

    private let output: FavoritesViewOutput
    private var currentSegment: String = "Favorites"
    private let backgroundLabel = UILabel()
    private var avatarImage = UIImage()
    private let heartForEmptyKeysImageView = UIImageView()
    private let eyeForEmptyKeysImageView = UIImageView()
    private let favForEmptyKeysLabel = UILabel()
    private let visForEmptyKeysLabel = UILabel()
    private let meViewController = MeViewController()
    
    var favoritesTableView : UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(MeTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "MeTableViewHeader")
        return tableView
    }()
        
    init(output: FavoritesViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if globalAppUser.name.isEmpty {
            delegate?.dismissMeView()
            delegate?.openSignIn()
        } else {
            if (globalAppUser.avatarURL != "0" && globalAppUser.avatarURL != ""){
                loadAvatarURL(avatarURL: globalAppUser.avatarURL)
            }
        }
        favoritesTableView.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if globalAppUser.name.isEmpty{
            delegate?.dismissMeView()
            delegate?.openSignIn()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        setupEmptyKeys()
        favoritesTableView.register(FavoritesTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "FavoritesTableViewHeader")
        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
                
        [favoritesTableView, favForEmptyKeysLabel, visForEmptyKeysLabel, eyeForEmptyKeysImageView, heartForEmptyKeysImageView].forEach{
            view.addSubview($0)
        }
        
        addConstraints()


    }
    
    func setupEmptyKeys(){
        heartForEmptyKeysImageView.image = UIImage(systemName: "heart.fill")
        heartForEmptyKeysImageView.tintColor = ColorPalette.gray//yellow
        eyeForEmptyKeysImageView.image = UIImage(systemName: "eye.fill")
        eyeForEmptyKeysImageView.tintColor = ColorPalette.gray//yellow
        
        favForEmptyKeysLabel.text = "Добавьте понравившиеся локации в избранное"
        visForEmptyKeysLabel.text = "Тут будут отображаться последние 10 просмотренных локаций"
        
        [favForEmptyKeysLabel, visForEmptyKeysLabel].forEach{
            ($0).numberOfLines = 3
            ($0).lineBreakMode = .byClipping
            ($0).textAlignment = .center
            ($0).font = UIFont(name: "POEVeticaVanta", size: 18)
            ($0).textColor = .gray
        }
    }
    
    func hideVisitedEmptyKeys(){
        [eyeForEmptyKeysImageView, visForEmptyKeysLabel].forEach{
            ($0).isHidden = true
        }
    }
    
    func hideFavoriteEmptyKeys(){
        [favForEmptyKeysLabel, heartForEmptyKeysImageView].forEach{
            ($0).isHidden = true
        }
    }
    
    func showVisitedEmptyKeys(){
        [eyeForEmptyKeysImageView, visForEmptyKeysLabel].forEach{
            ($0).isHidden = false
        }
    }
    
    func showFavoriteEmptyKeys(){
        [favForEmptyKeysLabel, heartForEmptyKeysImageView].forEach{
            ($0).isHidden = false
        }
    }
    
    
    func addConstraints(){
        [favoritesTableView, favForEmptyKeysLabel, visForEmptyKeysLabel, eyeForEmptyKeysImageView, heartForEmptyKeysImageView].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoritesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            favoritesTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            heartForEmptyKeysImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heartForEmptyKeysImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            heartForEmptyKeysImageView.widthAnchor.constraint(equalToConstant: 120),
            heartForEmptyKeysImageView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            favForEmptyKeysLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favForEmptyKeysLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            favForEmptyKeysLabel.widthAnchor.constraint(equalToConstant: 300),
            favForEmptyKeysLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            eyeForEmptyKeysImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eyeForEmptyKeysImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            eyeForEmptyKeysImageView.widthAnchor.constraint(equalToConstant: 120),
            eyeForEmptyKeysImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            visForEmptyKeysLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            visForEmptyKeysLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            visForEmptyKeysLabel.widthAnchor.constraint(equalToConstant: 300),
            visForEmptyKeysLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    

    @objc
    func timerAction() {
        favoritesTableView.reloadData()
    }
    
    func loadAvatarURL (avatarURL: String) {
        var image = UIImage()
        let referenceUsers = Storage.storage().reference(forURL: avatarURL)
        let mByte = Int64(2*1024*1024)
        referenceUsers.getData(maxSize: mByte) { (data, error) in
            guard let imageData = data else { return }
            image = UIImage(data: imageData) ?? UIImage()
            self.avatarImage = image
            self.favoritesTableView.reloadData()
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if currentSegment == "Favorites" {
            count = output.itemsCount(arr: globalAppUser.favoritePlaces)
            if count > 0 {
                hideFavoriteEmptyKeys()
                hideVisitedEmptyKeys()
            } else {
                showFavoriteEmptyKeys()
                hideVisitedEmptyKeys()
            }
            return count
        }
        if currentSegment == "Visited" {
            count = output.itemsCount(arr: globalAppUser.viewedPlaces)
            if count > 0 {
                hideVisitedEmptyKeys()
                hideFavoriteEmptyKeys()
            } else {
                showVisitedEmptyKeys()
                hideFavoriteEmptyKeys()
            }
            return count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else {
            return .init()
        }
        var item = FavoritesTableViewCellModel(imageURL: nil, title: "", subway: "", iconName: "")
        if currentSegment == "Favorites" {
            item = output.item(at: indexPath.row, at: globalAppUser.favoritePlaces)
            item.iconName = "heart.fill"
        } else if currentSegment == "Visited"{
            item = output.item(at: indexPath.row, at: globalAppUser.viewedPlaces)
            item.iconName = "eye.fill"
        }
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = favoritesTableView.dequeueReusableHeaderFooterView(withIdentifier: "FavoritesTableViewHeader") as! FavoritesTableViewHeader
        view.delegate = self
       
        if currentSegment == "Favorites" {
            if globalAppUser.avatarURL == "" || globalAppUser.avatarURL == "0"{
                view.configure(titleText: "Избранное", image: UIImage(named: "appIcon")!)
            } else {
                view.configure(titleText: "Избранное", image: avatarImage)
            }
        
        } else if currentSegment == "Visited"{
            if globalAppUser.avatarURL == "" || globalAppUser.avatarURL == "0"{
                view.configure(titleText: "Просмотренное", image: UIImage(named: "appIcon")!)
            } else {
                view.configure(titleText: "Просмотренное", image: avatarImage)
            }
        }
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentSegment == "Favorites" {
            let id = globalAppUser.favoritePlaces.reversed()[indexPath.row]
            output.didSelect(at: id)
        } else if currentSegment == "Visited"{
            let id = globalAppUser.viewedPlaces.reversed()[indexPath.row]
            output.didSelect(at: id)
        }
    }
}

extension FavoritesViewController: FavoritesViewInput {
    func updateCell(at index: Int) {
        if currentSegment == "Favorites" {
            if index < output.itemsCount(arr: globalAppUser.favoritePlaces){
                 favoritesTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        } else if currentSegment == "Visited"{
            if index < output.itemsCount(arr: globalAppUser.viewedPlaces){
                 favoritesTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        }
    }
    
}

extension FavoritesViewController: TableViewHeader{
    func currentSegment(currentSegment: String) {
        self.currentSegment = currentSegment
    }
    
    
    func didTapProfileButton() {
        output.didTapProfileButton()
    }
    
    
    func didChangeSegment() {
        favoritesTableView.reloadData()
    }
    
       
   }
   

extension FavoritesViewController: EditFavoritesViewController{
 
    func reloadHeader() {
        loadAvatarURL(avatarURL: globalAppUser.avatarURL)
    }
    
    func reloadTableView(){
        //favoritesTableView.reloadData()
    }
    
    
}
