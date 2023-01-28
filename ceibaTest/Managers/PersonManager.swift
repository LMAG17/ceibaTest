//
//  PersonManager.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import Foundation
import UIKit
import CoreData

//MARK: -> PersonManagerDelegate
protocol PersonsManagerDelegate {
    func onPersonsUpdate (personsList : [Person])
    func onError (error: String?)
    func onDataFromService()
}

//MARK: -> PersonManager
class PersonsManager {
    
    var serviceInteractor = ServiceInteractor()
    var delegate : PersonsManagerDelegate?
    var databaseInteractor = DatabaseInteractor()
    var reachability : Reachability
    
    init() {
        reachability = try! Reachability()
        serviceInteractor.personsDelegate = self
    }
    
    func getPersons(){
        let dbPersons = databaseInteractor.getPersonsFromDB()
        if dbPersons != nil {
            delegate?.onPersonsUpdate(personsList: dbPersons!)
        }
        else if reachability.connection == .unavailable {
            delegate?.onError(error: "Can not load Persons")
        }
        else {
            serviceInteractor.getPersons()
            delegate?.onDataFromService()
        }
    }
    
}

//MARK: -> ServiceInteractorPersonDelegate
extension PersonsManager : ServiceInteractorPersonDelegate {
    
    func onPersonsReceived(persons: [Person]) {
        databaseInteractor.cleanPersonsDB()
        databaseInteractor.savePersonsInDB(personsData: persons)
        self.delegate?.onPersonsUpdate(personsList: persons)
    }
    
    func onFail(message: String?) {
        self.delegate?.onError(error: message)
    }
    
}
