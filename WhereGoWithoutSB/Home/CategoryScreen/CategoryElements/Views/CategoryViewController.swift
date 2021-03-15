//
//  ParksViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 23.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//
import SpriteKit
import UIKit
import PinLayout


final class CategoryViewController: UIViewController{
    private let tableView = UITableView()
    private let output: CategoryViewOutput
    private var filterValue: String = ""
    private var animationView = SKView()
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0 //pageNo*limit
    var didEndReached:Bool=false
    
    init(output: CategoryViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    //    animationView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output.tableView(filter: "", pageInt: 1)
        setup()
    }
    
    
    private func setup() {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.frame = view.frame
        editBurButtons()
        [tableView, animationView].forEach{
            view.addSubview($0)
        }
        
        let scene = makeScene()
        animationView.frame.size = scene.size
        animationView.presentScene(scene)
        animationView.allowsTransparency = true
        // добавление загрузочного окна
        tableView.isHidden = false
        animationView.isHidden = false
        
    }
    
    func makeScene() -> SKScene {
    let size = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    let scene = SKScene(size: size)
    scene.zPosition = 1.1
    scene.scaleMode = .aspectFit
    scene.backgroundColor = .white
    createSceneContents(to: scene)
    return scene
    }

    func createSceneContents(to scene: SKScene) {

    let kolobok = SKSpriteNode(imageNamed: "kolobokAnimation")
    kolobok.size = CGSize(width: 75, height: 75)
    kolobok.zPosition = 1.3
    kolobok.position.y = UIScreen.main.bounds.maxY/2
    kolobok.position.x = UIScreen.main.bounds.maxX/2
    let rightRotate: SKAction = .rotate(byAngle: -16 * .pi, duration: 10)
    kolobok.run(rightRotate)

    scene.addChild(kolobok)
    }
    
    private func editBurButtons(){
        let rightBarButton = UIBarButtonItem.init(title: "filter", style: .done, target: self, action: #selector(filter))
        rightBarButton.image = UIImage(systemName: "slider.horizontal.3")
        rightBarButton.tintColor = ColorPalette.black
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func filter(){
        print ("filter is tapd")
        output.didSelectFilter()
    }
}

extension CategoryViewController: CategoryViewInput{
    func upplyFilter(with filterValue: String) {
          animationView.isHidden = false
        tableView.isHidden = true
        output.removeCategoryElements()
        output.tableView(filter: filterValue, pageInt: 1)//output.countElementsToPages
    }
    
    func update() {
        animationView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {  //UITableViewDataSourcePrefetching

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return .init()
        }
        
        let item = output.item(at: indexPath.row)
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelect(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
 
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 1500)
        {
            if !isDataLoading{
                isDataLoading = true
                self.pageNo=self.pageNo+1
                output.countElementsToPages = pageNo
                print (output.itemsCount)
                
                output.tableView(filter: "", pageInt: pageNo)
                
            }
        }
        
    }
    
    
}






