//
//  SearchViewController.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class APIBase<T: BaseModel> {
    
}

class NewClass: APIBase<NewModel> {
    
}

class NewModel: BaseModel {
    
}

class BaseModel: Codable {
    
}

class SearchViewController: UIViewController {
    
    // MARK: UI Components
    
    lazy var searchView: SearchView = {
        let view = SearchView.instanceFromNib()
        view.delegate = self
        return view
    }()
    
    // MARK: Properties
    
    var searchController = UISearchController()
    
    // MARK: Life Cycle
    
    override func loadView() {
        self.view = self.searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "IMDB Search"
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Methods

    public func requestSearch(text: String) {
        // TODO: Adicionar classe para gerenciar comunicação
        
        API_Instant.search(text: text, success: { [weak self] (model) in
            guard let _self = self else { return }
            _self.searchView.updateViewModel(model.search?.compactMap({ MediaViewModel(mediaModel: $0)}) ?? [])
        }) { [weak self] (code, message) in
            guard let _self = self else { return }
            _self.showAlertCommon(message: message)
        }
    }
    
    public func presentMediaDetails(_ viewModel: MediaViewModel) {
        let detailsVC = DetailsViewController(mediaViewModel: viewModel)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

// MARK: Extensions

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) { 
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        self.requestSearch(text: text)
    }
}

extension SearchViewController: SearchViewDelegate {
    
    func search(_ searchView: SearchView, didSelect viewModel: MediaViewModel) {
        self.searchController.searchBar.endEditing(false)
        self.presentMediaDetails(viewModel)
    }
    
}
