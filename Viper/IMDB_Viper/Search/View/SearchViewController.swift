//
//  SearchViewController.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewInstructions: UIView!
    @IBOutlet weak var lblInstructions: UILabel!
    
    // MARK: Properties
    
    var searchController = UISearchController()
    
    var presenter: SearchViewToPresenterProtocol?
    var search: SearchEntity? {
        didSet {
            self.viewInstructions.isHidden = self.search != nil
            self.tableView.reloadData()
        }
    }
    
    private let kCellId = "SearchCell"
    private var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "IMDB Search"
        self.setup()
        self.presenter?.viewDidLoad()
    }
    
    // MARK: Methods
    
    private func setup() {
        self.view.backgroundColor = .white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.kCellId)
        self.tableView.register(UINib(nibName: self.kCellId, bundle: nil), forCellReuseIdentifier: self.kCellId)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.keyboardDismissMode = .interactive
        
        self.lblInstructions.text = "SEARCH_INSTRUCTIONS_TEXT".localized
        self.setupSearchController()
    }
    
    private func setupSearchController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Media"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController = searchController
    }
    
}

// MARK: Extensions

extension SearchViewController: SearchPresenterToViewProtocol {
    
    func showSearch(search: SearchEntity) {
        self.search = search
    }
    
    func showError(errorMessage: String) {
        self.showAlertCommon(message: errorMessage)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        self.presenter?.search(text: text)
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        guard let media = self.search?.searchArray[row] else { return }
        self.presenter?.showMediaDetails(for: media, from: self)
        self.selectedIndexPath = nil
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(false)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(true)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? SearchCell)?.setContentSelected(false)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.search?.search?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kCellId, for: indexPath) as! SearchCell
        cell.media = self.search?.searchArray[indexPath.row]
        return cell
    }
    
}
