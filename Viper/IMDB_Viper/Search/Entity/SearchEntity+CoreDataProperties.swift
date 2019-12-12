//
//  SearchEntity+CoreDataProperties.swift
//  IMDB_Viper
//
//  Created by Usemobile on 12/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData


extension SearchEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchEntity> {
        return NSFetchRequest<SearchEntity>(entityName: "SearchEntity")
    }
    
    @NSManaged public var error: String?
    @NSManaged public var response: String?
    @NSManaged public var totalResults: String?
    @NSManaged public var search: NSSet?
    
    var searchArray: [MediaEntity] {
        let set = search  as? Set<MediaEntity> ?? []
        
        return set.sorted {
            ($0.title ?? "") < ($1.title ?? "")
        }
    }

}

// MARK: Generated accessors for search
extension SearchEntity {

    @objc(addSearchObject:)
    @NSManaged public func addToSearch(_ value: MediaEntity)

    @objc(removeSearchObject:)
    @NSManaged public func removeFromSearch(_ value: MediaEntity)

    @objc(addSearch:)
    @NSManaged public func addToSearch(_ values: NSSet)

    @objc(removeSearch:)
    @NSManaged public func removeFromSearch(_ values: NSSet)

}
