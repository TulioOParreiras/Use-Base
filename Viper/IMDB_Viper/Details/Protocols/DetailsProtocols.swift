//
//  DetailsProtocols.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

protocol DetailsPresenterToViewProtocol: class {
    func showDetails(details: MediaDetailsModel)
    func showError(errorMessage: String)
}

protocol DetailsInteractorToPresenterProtocol: class {
    func detailsFetched(details: MediaDetailsModel)
    func detailsFetchFailed(errorMessage: String)
}

protocol DetailsPresenterToInteractorProtocol: class {
    var presenter: DetailsInteractorToPresenterProtocol? { get set }
    func fetchDetails(for media: MediaEntity)
}

protocol DetailsViewToPresenterProtocol: class {
    var view: DetailsPresenterToViewProtocol? { get set }
    var interactor: DetailsPresenterToInteractorProtocol? { get set }
    var router: DetailsPresenterToRouterProtocol? { get set }
    func getDetails(for media: MediaEntity)
}

protocol DetailsPresenterToRouterProtocol: class {
    static func createModule() -> DetailsViewController
}
