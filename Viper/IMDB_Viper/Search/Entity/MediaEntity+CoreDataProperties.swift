//
//  MediaEntity+CoreDataProperties.swift
//  IMDB_Viper
//
//  Created by Usemobile on 12/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//
//

import Foundation
import CoreData


extension MediaEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaEntity> {
        return NSFetchRequest<MediaEntity>(entityName: "MediaEntity")
    }

    @NSManaged public var objectId: String?
    @NSManaged public var poster: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var year: String?

}
