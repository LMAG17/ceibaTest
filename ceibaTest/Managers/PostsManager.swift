//
//  PostsManager.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import Foundation

//MARK: -> PostsManagerDelegate
protocol PostsManagerDelegate {
    func onPostsUpdate(posts: [Post])
    func onPostsByUserReceived(posts:[Post])
    func onError(message: String?)
}

//MARK: -> PostsManager
class PostsManager {
    
    var delegate : PostsManagerDelegate?
    var serviceInteractor = ServiceInteractor()
    var databaseInteractor = DatabaseInteractor()
    let reachability : Reachability
    
    init() {
        reachability = try! Reachability()
        serviceInteractor.postsDelegate = self
    }
    
    func getPosts(){
        if reachability.connection == .unavailable{
            let dbPosts = databaseInteractor.getPostsFromDB()
            if dbPosts != nil {
                delegate?.onPostsUpdate(posts: dbPosts!)
            }
            else {
                delegate?.onError(message: "Can not load Posts")
            }
        }
        else {
            serviceInteractor.getPosts()
        }
    }
    
    func getPostsByUser(userId :Int){
        if reachability.connection == .unavailable{
            let dbPosts = databaseInteractor.getPostsFromDB()
            if dbPosts != nil {
                let filteredPosts = dbPosts!.filter { p in
                    return p.userId == userId
                }
                delegate?.onPostsUpdate(posts: filteredPosts)
            }
            else {
                delegate?.onError(message: "Can not load Posts")
            }
        } else {
            
        }
        serviceInteractor.getPostsByUser(userId: userId)
    }
    
}

//MARK: -> ServiceInteractorPostsDelegate
extension PostsManager : ServiceInteractorPostsDelegate {
    
    func onPostsReceived(posts: [Post]) {
        databaseInteractor.cleanPostsDB()
        databaseInteractor.savePostsInDB(postsData: posts)
        self.delegate?.onPostsUpdate(posts: posts)
    }
    
    func onFail(message: String?) {
        self.delegate?.onError(message: message)
    }
    
    func onPostsByUserReceived(posts: [Post]) {
        self.delegate?.onPostsByUserReceived(posts: posts)
    }
    
}
