//
//  SearchEntity+CoreDataClass.swift
//  IMDB_Viper
//
//  Created by Usemobile on 12/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData

/*


 struct SearchEntity: Codable {
     let response: String?
     let search: [MediaEntity]?
     let totalResults: String?
     
     enum CodingKeys: String, CodingKey {
         case response = "Response"
         case search = "Search"
         case totalResults
     }
 }
 */

@objc(SearchEntity)
public class SearchEntity: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case search = "Search"
        case totalResults
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.response, forKey: .response)
            try container.encode(self.totalResults, forKey: .totalResults)
            try container.encode(self.searchArray, forKey: .search)
        }
    
    required public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "SearchEntity", in: managedObjectContext) else {
                fatalError("Failed to decode SearchEntity")
        }
        super.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        response = try container.decode(String.self, forKey: .response)
        totalResults = try container.decode(String.self, forKey: .totalResults)
        search = NSSet(array: try container.decode([MediaEntity].self, forKey: .search))
        
    }
    
}
