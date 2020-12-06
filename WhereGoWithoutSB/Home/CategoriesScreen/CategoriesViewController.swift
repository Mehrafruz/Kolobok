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



var items2: [CategoriesItem] = [CategoriesItem(imageName:"Image5_0"),
                                CategoriesItem(imageName:"Image5_1"),
                                CategoriesItem(imageName:"Image5_2"),
                                CategoriesItem(imageName:"Image5_3"),
                                CategoriesItem(imageName:"Image5_4"),
                                CategoriesItem(imageName:"Image5_5"),
                                CategoriesItem(imageName:"Image5_6"),
                                CategoriesItem(imageName:"Image5_7")]



class CategoriesViewController: UIViewController, SKPhysicsContactDelegate, UISearchBarDelegate{
    
    
    var searcBar = UISearchBar()
    private let animationView = SKView()
    
    
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
        setupViews()
        setupLayouts()
        setupSearchBar()
        setupCollectionViewItemSize()
        categoriesCollectionView.reloadData()

    
        //for animation
        view.addSubview(animationView)
//        let scene = makeScene()
//        animationView.frame.size = scene.size
//        animationView.presentScene(scene)
//        animationView.allowsTransparency = true
        //Timer.scheduledTimer(timeInterval: 5.1, target: self, selector: #selector(removeScene), userInfo: nil, repeats: true)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //for animation
//        animationView.center.x = view.bounds.minX+30
//        animationView.center.y = view.bounds.maxY-125
    }

    @objc func removeScene(){
        //animationView.removeFromSuperview()
    }
    
//    //for animation
//    func makeScene() -> SKScene {
//        let size = CGSize(width: 260, height: 270)
//        let scene = SKScene(size: size)
//        scene.scaleMode = .aspectFit
//
//       // scene.backgroundColor = .clear//UIColor(red: 233/255, green: 238/255, blue: 241/255, alpha: 1)
//        createSceneContents(to: scene)
//        return scene
//    }

//    func createSceneContents(to scene: SKScene) {
//        //create baground
//        let backroundImage = SKSpriteNode(imageNamed: "backgroundAnimateScene")
//        backroundImage.position = CGPoint(x: scene.size.width/2+60, y: scene.size.height/2+46)
//        //backroundImage.size = CGSize(width: 130, height: 135)
////        backroundImage.setScale(1.30)
////        backroundImage.zPosition = -1
////        scene.addChild(backroundImage)
//        //create kolobok
//        let kolobokTexture = createKolobokTexture()
//        let kolobok = SKSpriteNode(texture: kolobokTexture.first)
//        kolobok.size = CGSize(width: 120, height: 120)
//        kolobok.position.y = scene.size.height / 2
//        kolobok.position.x = UIScreen.main.bounds.minX-300
//        scene.addChild(kolobok)
//        //run texture animation
//        let characterFramesOverOneSecond: TimeInterval = 1.0 / TimeInterval(12)
//        let animateKolobok: SKAction = .animate(with: kolobokTexture, timePerFrame: characterFramesOverOneSecond, resize: false, restore: true)
//        //run movements
//        let rightRotate: SKAction = .rotate(byAngle: -2 * .pi, duration: 3)
//        let leftRotate: SKAction = .rotate(byAngle: 2 * .pi, duration: 4)
//        let pause: SKAction = .pause()
//        let animDuration: TimeInterval = 4.0
//        kolobok.run(.repeat(
//            .sequence(
//                [.group([
//                    rightRotate,
//                    animateKolobok,
//                    .moveBy(x: 500, y: 0, duration: 3),
//                    ]),
//                 .group([pause,
//                         animateKolobok,
//                         .pause()]),
//                 .group([
//                    leftRotate,
//                    animateKolobok,
//                    .moveBy(x: -600, y: 0, duration: animDuration)]),
//                ]
//            ), count: 1))
//    }
//
//
//    func createKolobokTexture() -> [SKTexture] {
//        var arrayTexture = [SKTexture]()
//        for index in 0 ... 11{
//            let imageName = String("kolobokAnimation_\(index).png")
//            let texture = SKTexture(imageNamed: imageName)
//            arrayTexture.append(texture)
//        }
//        return arrayTexture
//    }
    
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
        //searcBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
        return items2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let item = items2[indexPath.row]
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
        self.navigationController?.navigationBar.tintColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "К категориям"
    }
}

extension CategoriesViewController: UICollectionViewDelegate{
    
}


extension CategoriesViewController: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return UIImage(named: items2[indexPath.item].imageName)?.size ?? CGSize(width: 0, height: 0)
    }
}



