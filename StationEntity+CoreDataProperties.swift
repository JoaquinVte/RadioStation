//
//  StationEntity+CoreDataProperties.swift
//  RadioStation
//
//  Created by Joaquin on 9/5/21.
//
//

import Foundation
import CoreData


extension StationEntity {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<StationEntity> {
        return NSFetchRequest<StationEntity>(entityName: "StationEntity")
    }

    @NSManaged public var imageURL: String
    @NSManaged public var isFavourite: Bool
    @NSManaged public var name: String
    @NSManaged public var streamURL: String

}

extension StationEntity : Identifiable {

}
