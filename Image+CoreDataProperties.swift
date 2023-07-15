//
//  Item+CoreDataProperties.swift
//  Diamonds
//
//  Created by Kevin Kirkland on 7/14/23.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var timestamp: Date?
    @NSManaged public var stadium: Stadium?

}
