//
//  ceibaTestTests.swift
//  ceibaTestTests
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import XCTest
@testable import ceibaTest

class ceibaTestTests: XCTestCase {

    let serviceFactory = ServiceFactory()
    var serviceInteractor = ServiceInteractor()
    let databaseInteractor = DatabaseInteractor()
    var persons = [Person]()
    var posts = [Post]()
    var personManager = PersonsManager()
    var postsManager = PostsManager()
    
    override func setUpWithError() throws {
        serviceInteractor.postsDelegate = self
        serviceInteractor.personsDelegate = self
        personManager.delegate = self
        postsManager.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ServiceFactoryOK () throws{
        var data : Data?
        
        
        serviceFactory.consumeService(serviceUrl: serviceFactory.usersAPI) { response in
            data = response
        } onError: { _ in
            
        }
        
        XCTAssertNotNil(data, "Testing consume service with right service")
        
    }
    
    func test_ServiceFactoryFail () throws{
        var e : Error?
        
        serviceFactory.consumeService(serviceUrl: serviceFactory.userIdQuery) { _ in
            
        } onError: { error in
            e = error
        }
        
        XCTAssertNotNil(e, "Testing consume service with wrong service")
        
    }
    
    func test_DatabaseInteractorGetPersonsFromDB() throws{
        let persons = databaseInteractor.getPersonsFromDB()
        XCTAssertNotNil(persons)
    }
    
    func test_DatabaseInteractorGetPostsFromDB() throws{
        let posts = databaseInteractor.getPostsFromDB()
        XCTAssertNotNil(posts)
    }
    
    func test_DatabaseInteractorCleanPersonsFromDB()async  throws{
        await databaseInteractor.cleanPersonsDB()
        XCTAssertTrue(databaseInteractor.getPersonsFromDB()?.count ?? 1 == 0)
    }
    
    func test_DatabaseInteractorCleanPostsFromDB() async throws{
        await databaseInteractor.cleanPostsDB()
        XCTAssertTrue(databaseInteractor.getPersonsFromDB()?.count ?? 1 == 0)
    }

    func test_DatabaseInteractorSavePersonsFromDB() async throws{
        let person = PersonTable()
        person.id = 01
        person.name = "Luis"
        person.email = "luis.email"
        person.phone = "3227965405"
        person.username = "luis.alvarez"
        person.website = "luis.com"
        
        await databaseInteractor.savePersonsInDB(personsData: [try! Person(from: person)])
        
        XCTAssertTrue(databaseInteractor.getPersonsFromDB()?.count ?? 0 > 1)
    }
    
    func test_DatabaseInteractorSavePostsFromDB() async  throws{
        let post = PostTable()
        post.id = 0
        post.userId = 0
        post.title = "Publicacion"
        post.body = "Publicacion body"
        
        await databaseInteractor.savePostsInDB(postsData: [try! Post(from: post)])
        
        XCTAssertTrue(databaseInteractor.getPostsFromDB()?.count ?? 0 > 1)
    }
 
    func test_ServiceInteractor() throws {
        XCTAssertNotNil(serviceInteractor)
    }
    
    func test_ServiceInteractorGetPersons() async throws {
        await serviceInteractor.getPersons()
        XCTAssertTrue(persons.count > 1)
    }
    
    func test_ServiceInteractorGetPosts() async throws {
        await serviceInteractor.getPosts()
        XCTAssertTrue(posts.count > 1)
    }
    
    func test_ServiceInteractorGetPostsByUser() async throws {
        await serviceInteractor.getPostsByUser(userId: 0)
        XCTAssertTrue(posts.count > 1)
    }
    
    func test_PersonManagerGetPersons() async throws {
        await personManager.getPersons()
        XCTAssertTrue(persons.count > 1)
    }
    
    func test_PostManagerGetPost() async throws {
        await postsManager.getPosts()
        XCTAssertTrue(posts.count > 1)
    }
    
    func test_PostManagerGetPostByUser() async throws {
        await postsManager.getPostsByUser(userId: 0)
        XCTAssertTrue(posts.count > 1)
    }
    
}


extension ceibaTestTests : ServiceInteractorPostsDelegate, ServiceInteractorPersonDelegate {
    
    func onPostsReceived(posts: [Post]) {
        self.posts = posts
    }
    
    func onPostsByUserReceived(posts: [Post]) {
        self.posts = posts
    }
    
    func onPersonsReceived(persons: [Person]) {
        self.persons = persons
    }
    
    func onFail(message: String?) {
        
    }
    
}

extension ceibaTestTests : PersonsManagerDelegate, PostsManagerDelegate {
    func onPersonsUpdate(personsList: [Person]) {
        self.persons = personsList
    }
    
    func onError(error: String?) {
        
    }
    
    func onDataFromService() {
        
    }
    
    func onPostsUpdate(posts: [Post]) {
        self.posts = posts
    }
    
    func onError(message: String?) {
        
    }
    
    
}
