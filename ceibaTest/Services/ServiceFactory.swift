//
//  ServiceFactory.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import Foundation

//MARK: -> ServiceFactory
struct ServiceFactory {
    
    let usersAPI = "https://jsonplaceholder.typicode.com/users"
    let postsAPI = "https://jsonplaceholder.typicode.com/posts"
    let userIdQuery = "?userId="
    
    func consumeService(serviceUrl: String, onSuccess: @escaping (_ response: Data) -> Void, onError: @escaping (_ error: Error) -> Void ){
        if let url = URL.init(string: serviceUrl){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
                if  error != nil{
                    onError(error!)
                    return
                }
                onSuccess(data)
            }
            task.resume()
        }
    }
}
