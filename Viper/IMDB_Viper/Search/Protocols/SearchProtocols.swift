//
//  Protocols.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

protocol SearchPresenterToViewProtocol: class {
    func showSearch(search: SearchModel)
    func showError(errorMessage: String)
}

protocol SearchInteractorToPresenterProtocol: class {
    func searchFetched(search: SearchModel)
    func searchFetchedFailed(errorMessage: String)
}

protocol SearchPresenterToInteractorProtocol: class {
    var presenter: SearchInteractorToPresenterProtocol? {get set}
    func fetchSearch(text: String)
}

protocol SearchViewToPresenterProtocol: class {
    var view: SearchPresenterToViewProtocol? {get set}
    var interactor: SearchPresenterToInteractorProtocol? {get set}
    var router: SearchPresenterToRouterProtocol? {get set}
    func search(text: String)
    func showMediaDetails(for media: MediaModel, from view: UIViewController)
}

protocol SearchPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
    func showMediaDetails(for media: MediaModel, from view: UIViewController)
}
