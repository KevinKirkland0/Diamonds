//
//  Stadium+CoreDataProperties.swift
//  Diamonds
//
//  Created by Kevin Kirkland on 7/13/23.
//
//

import Foundation
import CoreData


extension Stadium {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stadium> {
        return NSFetchRequest<Stadium>(entityName: "Stadium")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var notes: String?
    @NSManaged public var coordinateLatitude: Double
    @NSManaged public var coordinateLongitude: Double
    @NSManaged public var visited: Bool
    @NSManaged public var imageData: Data?

}

extension Stadium : Identifiable {

}
