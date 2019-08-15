//
//  SearchModel.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

struct SearchModel: Codable {
    let response: String?
    let search: [MediaModel]?
    let totalResults: String?
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case search = "Search"
        case totalResults
    }
}

struct MediaModel: Codable {
    let objectId: String?
    let poster: String?
    let title: String?
    let type: String?
    let year: String?
    
    enum CodingKeys: String, CodingKey {
        case objectId = "imdbID"
        case poster = "Poster"
        case title = "Title"
        case type = "Type"
        case year = "Year"
    }
}
