//
//  Router.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class SearchRouter: SearchPresenterToRouterProtocol {
    
    class func createModule() -> UIViewController {
        let view = SearchViewController(nibName: "SearchViewController", bundle: nil)

        let presenter: SearchViewToPresenterProtocol & SearchInteractorToPresenterProtocol = SearchPresenter()
        let interactor: SearchPresenterToInteractorProtocol = SearchInteractor()
        let router: SearchPresenterToRouterProtocol = SearchRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        let nav = UINavigationController(rootViewController: view)
        return nav
    }
    
    func showMediaDetails(for media: MediaModel, from view: UIViewController) {
        let detailsView = DetailsRouter.createModule()
        detailsView.media = media
        view.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    
}
