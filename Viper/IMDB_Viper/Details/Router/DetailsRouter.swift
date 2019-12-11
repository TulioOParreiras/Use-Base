//
//  DetailsRoute.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class DetailsRouter: DetailsPresenterToRouterProtocol {
    
    static func createModule() -> DetailsViewController {
        let view = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        
        let presenter: DetailsViewToPresenterProtocol & DetailsInteractorToPresenterProtocol = DetailsPresenter()
        let interactor: DetailsPresenterToInteractorProtocol = DetailsInteractor()
        let router: DetailsPresenterToRouterProtocol = DetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
}
