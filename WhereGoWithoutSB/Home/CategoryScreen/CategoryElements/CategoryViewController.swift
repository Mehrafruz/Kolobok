//
//  ParksViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 23.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//
import SpriteKit
import UIKit


final class CategoryViewController: UIViewController{
    private let tableView = UITableView()
    private let output: CategoryViewOutput

    init(output: CategoryViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
}

extension CategoryViewController: CategoryViewInput{
    func update(at index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return .init()
        }
        
        let item = output.item(at: "some", at: indexPath.row)
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

//class ParksViewController: UIViewController{
//
//    private var parksTableView : UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//
//    let basePathKudaGoToParks = "https://kudago.com/public-api/v1.4/places/?lang=&fields=title,address,images,description,foreign_url,subway,timetable,favorites_count,phone&expand=&order_by=&text_format=&ids=&location=msk&has_showings=&showing_since=&showing_until=&categories=park&lon=&lat=&radius="
//
//    var resultArray: [whereGo] = []
////    var parkItemArray: [ParkItem] = []
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        view.isOpaque = false
//        self.parksTableView.register(ParkTableViewCell.self, forCellReuseIdentifier: ParkTableViewCell.identifier)
//        loadData()
//    }
//
//    private func setupViews(){
//        view.backgroundColor = .white
//        view.addSubview(parksTableView)
//
//        parksTableView.delegate = self
//        parksTableView.dataSource = self
//    }
//
//    private func setupLayouts() {
//        parksTableView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 0).isActive = true
//        parksTableView.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: 0).isActive = true
//        parksTableView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0).isActive = true
//        parksTableView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0).isActive = true
//    }
//
//
//    func loadData() {
//        var imageArray: [String] = []
//        let group = DispatchGroup()
//
//        group.enter()
//
//        let session = URLSession.shared
//        let request = URLRequest(url: URL(string: self.basePathKudaGoToParks)!)
//        //var result: URLResponse?
//        DispatchQueue.main.async {
//            //загрузка данных из инета
//            let task = session.dataTask(with: request, completionHandler: { data, response, error in
//                if let data = data{
//                    do{
//                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
//                            if let results = json["results"] as? [[String:Any]]{
//                                for parkObject in results{
//                                    if var kudaGoObject = try? whereGo(json: parkObject){
//                                        if let images =  parkObject["images"] as? [[String:Any]]{
//                                            imageArray.removeAll()
//                                            for image in images{
//                                                if let i = image["image"] as? String{
//                                                    imageArray.append(i)
//                                                }
//                                            }
//                                        }
//                                        kudaGoObject.imagesLinks = imageArray
//                                        self.resultArray.append(kudaGoObject)
//                                    }
//                                }
//                                // print (resultArray)
//                                // тут будет твой результат запроса
//                                //  result = response
//                            }
//                        }
//                    }
//                    catch{
//                        print (error.localizedDescription)
//                    }
//                }
//                group.leave()
//            })
//            task.resume()
//        }
//
//        //грузим в collectionView только после полной загрузки всех данных
//        group.notify(queue: .main) {
//            //print(result)
//            self.setupViews()
//            self.setupLayouts()
//        }
//    }
//
//}
//
//
//extension ParksViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return resultArray.count
//    }
//
//    //------как сделать так чтобы эта функция вызывалась внудри setupData после того как мы получили все данные перезаполняем ячейку?
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ParkTableViewCell.identifier, for: indexPath) as! ParkTableViewCell
//        cell.setup(whereGoItem: resultArray[indexPath.row])
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//
//}





