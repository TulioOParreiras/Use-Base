//
//  MediaDetailsModel.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation

struct RatingModel: Codable {
    let source: String?
    let value: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

struct MediaDetailsModel: Codable {
    let title: String?
    let year: String?
    let rated: String?
    let realeased: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let ratings: [RatingModel]?
    let metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let type: String?
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let Website: String?
    let Response: String?
    
    enum CodingKeys: String, CodingKey {
        case imdbRating, imdbVotes, imdbID
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case realeased = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case Website = "Website"
        case Response = "Response"
    }
    
}
