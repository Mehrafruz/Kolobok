//
//  MeViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    let tempButton = UIButton()
    let titleLabel = UILabel()
    let avatarImageView = UIImageView()
    let visitedView = UILabel()
    
    private let visitedCollectionView: UICollectionView = {
           let viewLayout = UICollectionViewFlowLayout()
           
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
           collectionView.backgroundColor = UIColor(red: 253/255, green: 247/255, blue: 152/255, alpha: 1)
           return collectionView
       }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mine"
        view.backgroundColor = .systemBackground
//        setupButton()
        setupTitleView()
        setupAvatarImage()
        setupVisitedView()
    
        setupViews()
        setupLayouts()
        setupCollectionViewItemSize()
        
//       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
//       collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.489895463, blue: 0, alpha: 1)
       
     
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    
        //для анимации
        //animationView.center.x = view.bounds.midX
        //animationView.center.y = view.bounds.minY+125
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(visitedCollectionView)
        
        visitedCollectionView.dataSource = self
        visitedCollectionView.delegate = self
        visitedCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private func setupCollectionViewItemSize (){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        customLayout.numberOfColumns = 5
        customLayout.cellPadding = 3
        customLayout.accessibilityScroll(.left)
        visitedCollectionView.collectionViewLayout = customLayout
        
    }
    
    private func setupLayouts() {
        visitedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            visitedCollectionView.topAnchor.constraint(equalTo: visitedView.bottomAnchor, constant: 20),
//            visitedCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            visitedCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            visitedCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            visitedCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupVisitedCollectionView() {
        
    }
    
    func setupVisitedView() {
        view.addSubview(visitedView)
        visitedView.backgroundColor = .white
        visitedView.text = "Visited places:"
        visitedView.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        visitedView.adjustsFontSizeToFitWidth = true
        visitedView.translatesAutoresizingMaskIntoConstraints = false
        
        constraintsForVisited()
    }
    
    
    func setupAvatarImage() {
        avatarImageView.image = UIImage.init(named: "kolobokAnimation_2")
        view.addSubview(avatarImageView)
        let indent: CGFloat = 130.0
        let width = UIScreen.main.bounds.width - indent * 2

        avatarImageView.layer.cornerRadius = width / 2
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.masksToBounds = true
        
        avatarImageView.layer.borderColor = UIColor(red: 1, green: 195/255, blue: 52/255, alpha: 1).cgColor
        avatarImageView.layer.borderWidth = 3
        
        constrainsForAva(indent, width)
    }
    
    func setupButton() {
        tempButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        tempButton.addTarget(self, action: #selector(tempButtonTapped), for: .touchUpInside)
        
        view.addSubview(tempButton)
        
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        tempButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true// left side
        tempButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true //right side
        tempButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tempButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupTitleView() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
        titleLabel.text = "My Account"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraintsForTitle()
        
    }
     
    @objc func tempButtonTapped () {
        let secondViewController = ParksViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }

    
    func constraintsForTitle() {
        let horizontalConstraint = NSLayoutConstraint(item: titleLabel,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .top,
                                                  multiplier: 1,
                                                  constant: 80)
        let verticalCenter = NSLayoutConstraint(item: titleLabel,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .centerX,
                                                multiplier: 1,
                                                constant: 0)
        let height = NSLayoutConstraint(item: titleLabel,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 50)
        
//        let width = NSLayoutConstraint(item: titleView,
//                                       attribute: .width,
//                                       relatedBy: .equal,
//                                       toItem: nil,
//                                       attribute: .width,
//                                       multiplier: 1,
//                                       constant: 100)
        
        let constraints: [NSLayoutConstraint] = [horizontalConstraint, verticalCenter, height]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func constrainsForAva(_ indent: CGFloat, _ width: CGFloat) {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent).isActive = true// left side
        //        avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100).isActive = true //right side
        avatarImageView.heightAnchor.constraint(equalToConstant: width).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    
    fileprivate func constraintsForVisited() {
        let horizontalConstraint = NSLayoutConstraint(item: visitedView,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: avatarImageView,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: 20)
        let verticalConstraint = NSLayoutConstraint(item: visitedView,
                                                    attribute: .leading,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .leading,
                                                    multiplier: 1,
                                                    constant: 20)
        let height = NSLayoutConstraint(item: visitedView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 50)
    
        
        let constraints: [NSLayoutConstraint] = [horizontalConstraint, verticalConstraint, height]
        
        NSLayoutConstraint.activate(constraints)
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let item = items2[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    
}

extension MeViewController: UICollectionViewDelegate {
    
}

extension MeViewController: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return UIImage(named: items2[indexPath.item].imageName)?.size ?? CGSize(width: 0, height: 0)
    }
}

