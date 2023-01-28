//
//  PostTable+CoreDataProperties.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//
//

import Foundation
import CoreData


extension PostTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostTable> {
        return NSFetchRequest<PostTable>(entityName: "PostTable")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension PostTable : Identifiable {

}
