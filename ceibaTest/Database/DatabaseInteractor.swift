//
//  DatabaseInteractor.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import Foundation
import UIKit
import CoreData

//MARK: -> DatabaseInteractor
struct DatabaseInteractor {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}

//MARK: -> DatabaseInteractor GETS
extension DatabaseInteractor {
    func getPersonsFromDB() -> [Person]?{
        do{
            let personsFromTable = try context.fetch(PersonTable.fetchRequest())
            print ("persons from table \(personsFromTable)")
            do {
                return try personsFromTable.map {
                    try Person(from: $0)
                }
            }
            catch {
                print ("There was a error parsing persons from table")
                return nil
            }
        }
        catch {
            print ("There was a error getting persons from table")
            return nil
        }
    }
    
    func getPostsFromDB() -> [Post]?{
        do{
            let postFromTable = try context.fetch(PostTable.fetchRequest())
            do{
                return try postFromTable.map {
                    try Post(from: $0)
                }
            }
            catch{
                print ("There was a error parsing posts from table")
                return nil
            }
        }
        catch {
            print ("There was a error getting posts from table")
            return nil
        }
    }
}

//MARK: -> DatabaseInteractor Saves
extension DatabaseInteractor {
    
    func savePersonsInDB (personsData: [Person]){
        for person in personsData {
            let newPersonDB = NSEntityDescription.insertNewObject(forEntityName: "PersonTable", into: context)
            newPersonDB.setValue(person.id, forKey: "id")
            newPersonDB.setValue(person.username, forKey: "username")
            newPersonDB.setValue(person.name, forKey: "name")
            newPersonDB.setValue(person.phone, forKey: "phone")
            newPersonDB.setValue(person.email, forKey: "email")
            newPersonDB.setValue(person.website, forKey: "website")
        }
        do {
            try context.save()
        } catch {
            print ("There was a error saving persons to table")
        }
    }
    
    func savePostsInDB (postsData: [Post]){
        for post in postsData {
            let newPostDB = NSEntityDescription.insertNewObject(forEntityName: "PostTable", into: context)
            newPostDB.setValue(post.id, forKey: "id")
            newPostDB.setValue(post.userId, forKey: "userId")
            newPostDB.setValue(post.title, forKey: "title")
            newPostDB.setValue(post.body, forKey: "body")
        }
        do {
            try context.save()
        } catch {
            print ("There was a error saving posts to table")
        }
    }
    
}

//MARK: -> DatabaseInteractor Cleans
extension  DatabaseInteractor {
    func cleanPersonsDB (){
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: PersonTable.fetchRequest())
        do {
            try context.execute(deleteRequest)
        } catch{
            print("Error cleaning PersonTable")
        }
    }
    
    func cleanPostsDB (){
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: PostTable.fetchRequest())
        do {
            try context.execute(deleteRequest)
        } catch{
            print("Error cleaning PersonTable")
        }
    }
}
