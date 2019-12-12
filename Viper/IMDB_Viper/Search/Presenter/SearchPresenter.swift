//
//  Presenter.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class SearchPresenter: SearchViewToPresenterProtocol {
    
    func viewDidLoad() {
        self.interactor?.fetchLocalSearch()
    }
    
    var view: SearchPresenterToViewProtocol?
    
    var interactor: SearchPresenterToInteractorProtocol?
    
    var router: SearchPresenterToRouterProtocol?
    
    func search(text: String) {
        self.interactor?.fetchSearch(text: text)
    }
    
    func showMediaDetails(for media: MediaEntity, from view: UIViewController) {
        self.router?.showMediaDetails(for: media, from: view)
    }
    
}

extension SearchPresenter: SearchInteractorToPresenterProtocol {
    func searchFetched(search: SearchEntity) {
        self.view?.showSearch(search: search)
    }
    
    func searchFetchedFailed(errorMessage: String) {
        self.view?.showError(errorMessage: errorMessage)
    }
    
    
}
