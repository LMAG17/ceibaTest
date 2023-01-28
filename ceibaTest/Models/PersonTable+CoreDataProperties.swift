//
//  PersonTable+CoreDataProperties.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//
//

import Foundation
import CoreData


extension PersonTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonTable> {
        return NSFetchRequest<PersonTable>(entityName: "PersonTable")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?

}

extension PersonTable : Identifiable {

}
