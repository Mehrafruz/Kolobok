//
//  CategoriesViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

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



class CategoriesViewController: UIViewController {
    
 //для анимации
//    private let animationView = SKView()
    

//    func makeScene() -> SKScene {
//        let minimumDimension = min(view.frame.width, view.frame.height)
//        //let size = CGSize(width: minimumDimension, height: minimumDimension)
//        let size = CGSize(width: minimumDimension, height: 70)
//        let scene = SKScene(size: size)
//        scene.backgroundColor = .white
//        //addEmoji(to: scene)
//       // animateNodes(scene.children)
//        return scene
//    }
    
    
    private let categoriesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 1.0
        static let itemHeight: CGFloat = 300.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Categories"
        setupViews()
        setupLayouts()
        setupCollectionViewItemSize()
        categoriesCollectionView.reloadData()
        
//        для анимации
//        view.addSubview(animationView)
//        let scene = makeScene()
//        animationView.frame.size = scene.size
//        animationView.presentScene(scene)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //для анимации
        //animationView.center.x = view.bounds.midX
        //animationView.center.y = view.bounds.minY+125
    }
    
    //для анимации
    
//    func addEmoji(to scene: SKScene) {
//        //let allEmoji: [Character] = ["🍊", "🍋", "🍑", "🥭"]
//        let kolobok = SKSpriteNode(imageNamed: "kolobokAnimation_2")
//        kolobok.name = "kolobok"
//        kolobok.size = CGSize(width: 150, height: 150)
//        let distance = floor(scene.size.width / 4)
//        kolobok.position.y = floor(scene.size.height / 2)
//        kolobok.position.x = distance * (1 + 0.5)
//        scene.addChild(kolobok)
//
//    }
//
//    func animateNodes(_ nodes: [SKNode]) {
//      for (index, node) in nodes.enumerated() {
//        node.run(.sequence([
//          .wait(forDuration: TimeInterval(index) * 0.2),
//          .repeatForever(.sequence([
//            .group([
//              .sequence([
//                .scale(to: 1.5, duration: 0.3),
//                .scale(to: 1, duration: 0.3)
//                ]),
//              .rotate(byAngle: .pi * 2, duration: 0.6)
//              ]),
//            .wait(forDuration: 2)
//            ]))
//          ]))
//      }
//    }
    
    
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
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
        
        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.minY+70),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            categoriesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        print ("didSelectItemAt:\(indexPath)")
        if indexPath == [0,0]{
            let parksCategoryScreen = ParksViewController()
            //parksCategoryScreen.modalPresentationStyle = .overCurrentContext
            parksCategoryScreen.title = "Parks"
            navigationController?.pushViewController(parksCategoryScreen, animated: true)
            //present(parksCategoryScreen, animated: true, completion: nil )
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegate{
    
}


extension CategoriesViewController: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return UIImage(named: items2[indexPath.item].imageName)?.size ?? CGSize(width: 0, height: 0)
    }
}

//для анимации
//extension SKLabelNode {
//    func renderEmoji(_ emoji: Character) {
//        fontSize = 50
//        text = String(emoji)
//
//        verticalAlignmentMode = .center
//        horizontalAlignmentMode = .center
//    }
//}
