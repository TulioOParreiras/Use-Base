//
//  DetailsInteractor.swift
//  IMDB_Viper
//
//  Created by Usemobile on 11/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

class DetailsInteractor: DetailsPresenterToInteractorProtocol {
    
    var presenter: DetailsInteractorToPresenterProtocol?
    
    func fetchDetails(for media: MediaModel) {
        // Call API
        guard let objectId = media.objectId else {
            self.presenter?.detailsFetchFailed(errorMessage: "There is no identifier for the selected media")
            return
        }
        API.getMediaDetails(mediaId: objectId, success: { (model) in
            self.presenter?.detailsFetched(details: model)
        }) { (code, message) in
            self.presenter?.detailsFetchFailed(errorMessage: message)
        }
    }
    
}
