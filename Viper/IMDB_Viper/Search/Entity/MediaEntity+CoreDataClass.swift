//
//  MediaEntity+CoreDataClass.swift
//  IMDB_Viper
//
//  Created by Usemobile on 12/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

/*


 struct MediaEntity: Codable {
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

 */

@objc(MediaEntity)
public class MediaEntity: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case objectId = "imdbID"
        case poster = "Poster"
        case title = "Title"
        case type = "Type"
        case year = "Year"
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.objectId, forKey: .objectId)
        try container.encode(self.poster, forKey: .poster)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.year, forKey: .year)
    }
    
    required public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "MediaEntity", in: managedObjectContext) else {
            fatalError("Failed to decode MediaEntity")
        }
        super.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        objectId = try container.decode(String.self, forKey: .objectId)
        poster = try container.decode(String.self, forKey: .poster)
        title = try container.decode(String.self, forKey: .title)
        type = try container.decode(String.self, forKey: .type)
        year = try container.decode(String.self, forKey: .year)
        
    }
    
}
