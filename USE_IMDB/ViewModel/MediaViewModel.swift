//
//  MediaViewModel.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

class MediaViewModel {
    
    let title: String
    let year: String
    let type: String
    let posterLink: String?
    let objectId: String?
    
    init(mediaModel: MediaModel) {
        self.title = mediaModel.title ?? "MISSING_TITLE_TEXT".localized
        self.year = mediaModel.year ?? "MISSING_FIELD_TEXT".localized
        self.type = mediaModel.type ?? "MISSING_FIELD_TEXT".localized
        
        self.posterLink = mediaModel.poster
        self.objectId = mediaModel.objectId
    }
    
}
