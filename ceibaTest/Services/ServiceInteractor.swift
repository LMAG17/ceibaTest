//
//  ServiceInteractor.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import Foundation

//MARK: -> ServiceInteractor Protocols
protocol ServiceInteractorDelegate {
    func onFail(message: String?)
}

protocol ServiceInteractorPersonDelegate : ServiceInteractorDelegate {
    func onPersonsReceived(persons: [Person])
}

protocol ServiceInteractorPostsDelegate : ServiceInteractorDelegate {
    func onPostsReceived(posts: [Post])
    func onPostsByUserReceived(posts: [Post])
}

//MARK: -> ServiceInteractor
struct ServiceInteractor {
    
    let serviceFactory = ServiceFactory()
    var personsDelegate : ServiceInteractorPersonDelegate? = nil
    var postsDelegate : ServiceInteractorPostsDelegate? = nil
    
}

//MARK: -> ServiceInteractor GETS
extension ServiceInteractor {
    func getPersons () {
        serviceFactory.consumeService(serviceUrl: serviceFactory.usersAPI) { response in
            if let persons = try? JSONDecoder().decode([Person].self, from: response){
                personsDelegate?.onPersonsReceived(persons: persons)
            }
            else {
                personsDelegate?.onFail(message: "Failure parsing persons")
            }
        } onError: { error in
            personsDelegate?.onFail(message: "Failure gettin persons")
        }
    }
    
    func getPosts(){
        serviceFactory.consumeService(serviceUrl: serviceFactory.postsAPI) { response in
            if let posts = try? JSONDecoder().decode([Post].self, from: response){
                postsDelegate?.onPostsReceived(posts: posts)
            }
            else {
                postsDelegate?.onFail(message: "Failure parsing posts")
            }
        } onError: { error in
            postsDelegate?.onFail(message: "Failure gettin posts")
        }
    }
    
    func getPostsByUser(userId :Int){
        serviceFactory.consumeService(serviceUrl: serviceFactory.postsAPI + serviceFactory.userIdQuery + String(userId)) { response in
            if let posts = try? JSONDecoder().decode([Post].self, from: response){
                postsDelegate?.onPostsByUserReceived(posts: posts)
            }
            else {
                postsDelegate?.onFail(message: "Failure parsing posts")
            }
        } onError: { error in
            postsDelegate?.onFail(message: "Failure gettin posts")
        }
    }
    
}
