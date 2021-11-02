//
//  Coffee+CoreDataProperties.swift
//  Grounds Control
//
//  Created by Brett on 10/22/21.
//
//

import Foundation
import CoreData


extension Coffee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coffee> {
        return NSFetchRequest<Coffee>(entityName: "Coffee")
    }

    @NSManaged public var aged: Float
    @NSManaged public var chocolate: Float
    @NSManaged public var created: Date!
    @NSManaged public var decomp: Float
    @NSManaged public var deletedDate: Date?
    @NSManaged public var floral: Float
    @NSManaged public var fruity: Float
    @NSManaged public var grade: String?
    @NSManaged public var id: UUID?
    @NSManaged public var mold: Float
    @NSManaged public var name: String!
    @NSManaged public var nutty: Float
    @NSManaged public var other: Float
    @NSManaged public var overroast: Float
    @NSManaged public var roasted: Float
    @NSManaged public var sour: Float
    @NSManaged public var spice: Float
    @NSManaged public var sweet: Float
    @NSManaged public var tainted: Float
    @NSManaged public var underripe: Float
    @NSManaged public var underroast: Float
    @NSManaged public var veggie: Float
    @NSManaged public var otherNotes: String?

}

extension Coffee : Identifiable {

}
