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
    
    func toPostTable () -> PostTable{
        let postTable = PostTable()
        postTable.userId = Int16(self.userId)
        postTable.id = Int16(self.id)
        postTable.title = self.title
        postTable.body = self.body
        return postTable
    }
    
    init(from postTable: PostTable) throws {
        self.userId = Int(postTable.userId)
        self.id = Int(postTable.id)
        self.title = postTable.title ?? ""
        self.body = postTable.body ?? ""
    }
    
}

typealias Posts = [Post]
