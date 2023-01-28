//
//  Post.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let userId, id: Int
    let title, body: String
    
    init(from postTable: PostTable) throws {
        self.userId = Int(postTable.userId)
        self.id = Int(postTable.id)
        self.title = postTable.title ?? ""
        self.body = postTable.body ?? ""
    }
    
}

typealias Posts = [Post]
