//
//  Interactor.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

class SearchInteractor: SearchPresenterToInteractorProtocol {

    var presenter: SearchInteractorToPresenterProtocol?
    
    func fetchSearch(text: String) {
        API_Instant.search(text: text, success: { [weak self] (model) in
            guard let self = self else { return }
            self.presenter?.searchFetched(search: model)
        }) { [weak self] (code, message) in
            guard let self = self else { return }
            self.presenter?.searchFetchedFailed(errorMessage: message)
        }
    }
    
    
}
