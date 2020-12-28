//
//  SearchViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 15.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit

var globalSearchElements: [SearchElements.Results] = []
var globalSearchElement: [CategoryElements.Results] = []

final class SearchViewController: UIViewController{
	private let output: SearchViewOutput
    
    private let tableView = UITableView()
    private let searchController = UISearchController()
    
    init(output: SearchViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .white
        //output.tableView()
        setup()
	}
    
    private func setup() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.setValue("Закрыть", forKey:"cancelButtonText")
        searchController.searchBar.placeholder = "Поиск"
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = ColorPalette.yellow
        searchController.dimsBackgroundDuringPresentation = false
        //searchController.hidesNavigationBarDuringPresentation =  false
        tableView.tableHeaderView = searchController.searchBar
        //navigationItem.searchController = searchController
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SerchTableViewCell")
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

extension SearchViewController: SearchViewInput {
    func update() {
        tableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SerchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return .init()
        }
        let item = output.item(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelect(with: indexPath.row)
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: { [weak self] in
            self?.searchController.searchBar.becomeFirstResponder()
        })
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
        if searchController.searchBar.text?.count ?? 0 >= 1 {
            output.makeLoadSearchElements(with: searchController.searchBar.text ?? "")
        } else {
          //  globalSearchElements.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: false)
       // globalSearchElements.removeAll()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
    
    }
}
