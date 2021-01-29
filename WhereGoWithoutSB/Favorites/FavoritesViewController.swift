//
//  FavoritesViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 26.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

protocol MainViewDelegate: AnyObject{
    func openSignIn()
    func dismissMeView()
}

    weak var delegate: MainViewDelegate?

final class FavoritesViewController: UIViewController {

    private let output: FavoritesViewOutput
    private var currentSegment: String = "Favorites"
    private let backgroundImage = UIImageView()
    private let backgroundLabel = UILabel()
    
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
        if globalAppUser.name.isEmpty{
            delegate?.dismissMeView()
            delegate?.openSignIn()
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
        backgroundImage.image = UIImage(named: "bgWelcomeScene")
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self

        favoritesTableView.register(FavoritesTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "FavoritesTableViewHeader")
        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
                
        [favoritesTableView, backgroundImage].forEach{
            view.addSubview($0)
        }
        
        addConstraints()
    }
    
    func addConstraints(){
        [backgroundImage, favoritesTableView].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoritesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            favoritesTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        backgroundImage.layer.zPosition = 2
    }
    

    @objc
    func timerAction() {
        favoritesTableView.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if currentSegment == "Favorites" {
            count = output.itemsCount(arr: globalAppUser.favoritePlaces)
            if count > 0 {
                backgroundImage.isHidden = true
            } else {
                backgroundImage.isHidden = false
            }
            return count
        }
        if currentSegment == "Visited" {
            count = output.itemsCount(arr: globalAppUser.viewedPlaces)
            if count > 0 {
                backgroundImage.isHidden = true
            } else {
                backgroundImage.isHidden = false
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
            view.configure(titleText: "Избранное")
            
        } else if currentSegment == "Visited"{
            view.configure(titleText: "Просмотренное")
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
        self.present(MeViewController(), animated: true)
    }
    
    
    func didChangeSegment() {
        favoritesTableView.reloadData()
    }
    
       
   }
   
