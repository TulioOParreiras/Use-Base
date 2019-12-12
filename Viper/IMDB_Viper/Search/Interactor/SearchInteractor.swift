//
//  Interactor.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit
import CoreData

class SearchInteractor: SearchPresenterToInteractorProtocol {

    var presenter: SearchInteractorToPresenterProtocol?
    
    func fetchSearch(text: String) {
        API_Instant.search(text: text, success: { [weak self] (model) in
            guard let self = self else { return }

            let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
            let managedContext = persistentContainer?.viewContext
            do {
                try managedContext?.save()
            } catch (let saveError) {
                API.printLog("saveError", message: saveError)
            }
            self.presenter?.searchFetched(search: model)
        }) { [weak self] (code, message) in
            guard let self = self else { return }
            self.presenter?.searchFetchedFailed(errorMessage: message)
        }
    }
    
    func fetchLocalSearch() {
        let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        do {
            let result = try persistentContainer?.viewContext.fetch(NSFetchRequest(entityName: "SearchEntity"))
            if let last = result?.last as? SearchEntity {
                self.presenter?.searchFetched(search: last)
            }
        } catch{
            self.presenter?.searchFetchedFailed(errorMessage: error.localizedDescription)
        }
    }
    
    
}
