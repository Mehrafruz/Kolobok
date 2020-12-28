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
    private var indicatorView = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()
    private let output: CategoryViewOutput
    private var filterValue: String = ""
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output.tableView(filter: "")
        setup()
    }
    
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
       // tableView.prefetchDataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.frame = view.frame
        indicatorView.center = view.center
        indicatorView.color = ColorPalette.black
        editBurButtons()
        [tableView, indicatorView].forEach{
            view.addSubview($0)
        }
        
        tableView.isHidden = true
        indicatorView.startAnimating()
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
        output.tableView(filter: filterValue)
    }
    
    func update() {
        indicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {  //UITableViewDataSourcePrefetching
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        if indexPaths.contains(where: output.isLoadingCell) {
//            print ("some")
//         // viewModel.fetchModerators()
//        }
//    }
    
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
    
}






