//
//  Person.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.

import Foundation

// MARK: - Person
class Person: Codable {
    let id: Int
    let name, username, email, phone, website: String
    
    func toPersonTable () -> PersonTable {
        let personTable = PersonTable()
        
        
        return personTable
    }
    
    required init(from personTable: PersonTable) throws {
        self.id = Int(personTable.id)
        self.name = personTable.name ?? ""
        self.phone = personTable.phone ?? ""
        self.email = personTable.email ?? ""
        self.username = personTable.username ?? ""
        self.website = personTable.website ?? ""
    }
}

typealias Persons = [Person]
