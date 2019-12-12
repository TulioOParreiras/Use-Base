//
//  Protocols.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

protocol SearchPresenterToViewProtocol: class {
    func showSearch(search: SearchEntity)
    func showError(errorMessage: String)
}

protocol SearchInteractorToPresenterProtocol: class {
    func searchFetched(search: SearchEntity)
    func searchFetchedFailed(errorMessage: String)
}

protocol SearchPresenterToInteractorProtocol: class {
    var presenter: SearchInteractorToPresenterProtocol? {get set}
    func fetchSearch(text: String)
    func fetchLocalSearch()
}

protocol SearchViewToPresenterProtocol: class {
    var view: SearchPresenterToViewProtocol? {get set}
    var interactor: SearchPresenterToInteractorProtocol? {get set}
    var router: SearchPresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func search(text: String)
    func showMediaDetails(for media: MediaEntity, from view: UIViewController)
}

protocol SearchPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
    func showMediaDetails(for media: MediaEntity, from view: UIViewController)
}
