//
//  DetailsPresenter.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

class DetailsPresenter: DetailsViewToPresenterProtocol {
    
    var view: DetailsPresenterToViewProtocol?
    var interactor: DetailsPresenterToInteractorProtocol?
    var router: DetailsPresenterToRouterProtocol?
    
    func getDetails(for media: MediaModel) {
        self.interactor?.fetchDetails(for: media)
    }
    
}

extension DetailsPresenter: DetailsInteractorToPresenterProtocol {
    
    func detailsFetched(details: MediaDetailsModel) {
        self.view?.showDetails(details: details)
    }
    
    func detailsFetchFailed(errorMessage: String) {
        self.view?.showError(errorMessage: errorMessage)
    }
    
}
