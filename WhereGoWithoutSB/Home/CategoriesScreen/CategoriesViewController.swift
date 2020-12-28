//
//  CategoriesViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//
//MARK: этот раздел с исключительно грязным кодом, возможно когда нибудь я все перепишу. Сори)

import UIKit
import SpriteKit
import FirebaseStorage
import Firebase

var categoriesItems: [CategoriesItem] = [CategoriesItem(imageName:"ParkCategoryImage"),
                                CategoriesItem(imageName:"QuestroomCategoryImage"),
                                CategoriesItem(imageName:"ArtSpaceCategoryImage"),
                                CategoriesItem(imageName:"MuseumCategoryImage"),
                                CategoriesItem(imageName:"RestaurantCategoryImage"),
                                CategoriesItem(imageName:"BarCategoryImage"),
                                CategoriesItem(imageName:"ClubCategoryImage"),
                                CategoriesItem(imageName:"AttractionCategoryImage")]



class CategoriesViewController: UIViewController, SKPhysicsContactDelegate, UISearchBarDelegate{
    
    var searchController = UISearchController(searchResultsController: nil)
    var searcBar = UISearchBar()
    var searchTableView = UITableView()
    
    private let categoriesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 5.0
        static let itemHeight: CGFloat = 300.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searcBar.delegate = self
        setup()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let context = SearchContext()
        let container = SearchContainer.assemble(with: context)
        self.navigationController?.pushViewController(container.viewController, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "Отмена"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setup(){
        setupViews()
        setupLayouts()
        setupSearchBar()
        setupCollectionViewItemSize()
        categoriesCollectionView.reloadData()
    }

    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    func setupSearchBar(){
        searcBar.placeholder = "Поиск"
        searcBar.layer.cornerRadius = 10
        searcBar.alpha = 0.5
        view.addSubview(searcBar)
        addConstraints()
    }
    
    func addConstraints(){
        searcBar.translatesAutoresizingMaskIntoConstraints = false
        searcBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true// left side
        searcBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0).isActive = true //right side
        searcBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searcBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.minY).isActive = true
    }
    
    private func setupCollectionViewItemSize (){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        customLayout.numberOfColumns = 2
        customLayout.cellPadding = 3
        categoriesCollectionView.collectionViewLayout = customLayout
        
    }
    
    private func setupLayouts() {
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.minY+40),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoriesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let item = categoriesItems[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var category: String = ""
  
        switch indexPath {
        case [0,0]:
            category = "park"
        case [0,1]:
            category = "questroom"
        case [0,2]:
            category = "art-space"
        case [0,3]:
            category = "museums"
        case [0,4]:
            category = "restaurants"
        case [0,5]:
            category = "bar"
        case [0,6]:
            category = "clubs"
        case [0,7]:
            category = "attractions"
        default:
            category = ""
        }
        
        let context = CategoryContext()
        let container = CategoryContainer.assemble(with: category, with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
        self.navigationController?.navigationBar.tintColor = ColorPalette.black//UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "К категориям"
    }
}

extension CategoriesViewController: UICollectionViewDelegate{
    
}


extension CategoriesViewController: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return UIImage(named: categoriesItems[indexPath.item].imageName)?.size ?? CGSize(width: 0, height: 0)
    }
}
