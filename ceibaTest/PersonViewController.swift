//
//  PersonViewController.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import UIKit

//MARK: -> PersonViewController
class PersonViewController: UIViewController {
    
    //MARK: -> Managers
    var personsManager = PersonsManager()
    
    //MARK: -> Variable
    var persons : [Person] = []
    var searchResults : [Person] = []
    var search: String? = ""
    var selectedRow: Int?
    
    //MARK: -> Outlets
    @IBOutlet weak var myEmptyListLabe: UILabel!
    @IBOutlet weak var personActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var personViewController: UISearchBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var personTableView: UITableView!
    
    //MARK: -> viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        personTableView.register(UINib(nibName: "PersonCellViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
        personTableView.delegate = self
        personTableView.dataSource = self
        personsManager.delegate = self
        searchBar.delegate = self
        personActivityIndicator.hidesWhenStopped = true
        
        DispatchQueue.main.async {
            self.title = "Usuarios"
            self.myEmptyListLabe.isHidden = true
        }
        
        getPersons()
    }
    
    
}

//MARK: -> PersonViewController UITableView
extension PersonViewController : UITableViewDataSource, UITableViewDelegate {
    
    //MARK: -> UITableView numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count >= 1 || search != "" ? searchResults.count
        : persons.count
    }
    
    //MARK: -> UITableView heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    //MARK: -> UITableView cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellView = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        as! PersonCellViewCell
        
        let personOrigin = searchResults.count >= 1 || search != "" ?
        searchResults[indexPath.row] :
        persons[indexPath.row]
        
        cellView.name = personOrigin.name
        cellView.cellphone = "☎ \(personOrigin.phone)"
        cellView.email = "📧 \(personOrigin.email)"
        
        return cellView
    }
    
    //MARK: -> UITableView didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "selectPerson", sender: self)
        personTableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: -> UITableView prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectPerson" {
            let selectPerson = segue.destination as! PostsViewController
            selectPerson.user = persons[self.selectedRow!]
        }
    }
    
    //MARK: -> UITableView refreshTable
    func refreshTable() {
        DispatchQueue.main.async {
            self.personTableView.reloadData()
            self.personTableView.isHidden = false
            self.personActivityIndicator.stopAnimating()
            if self.searchResults.count < 1 && self.search != "" {
                self.myEmptyListLabe.isHidden = false
            } else {
                self.myEmptyListLabe.isHidden = true
            }
        }
    }
    
    //MARK: -> UITableView tableLoading
    func tableLoading() {
        DispatchQueue.main.async {
            self.personTableView.isHidden = true
            self.personActivityIndicator.startAnimating()
        }
    }
}

//MARK: -> PersonsManagerDelegate
extension PersonViewController : PersonsManagerDelegate {
    
    //MARK: -> getPersons
    func getPersons(){
        tableLoading()
        personsManager.getPersons()
    }
    
    //MARK: -> onError
    func onError(error: String?) {
        DispatchQueue.main.async {
            self.personActivityIndicator.stopAnimating()
        }
        showAlert(title: "Se presento un error obteniendo las personas", message: "Por favor intente nuevamente mas tarde", retry: true)
    }
    
    //MARK: -> onPersonsUpdate
    func onPersonsUpdate(personsList: [Person]) {
        persons = personsList
        refreshTable()
    }
    
    func onDataFromService() {
        showAlert(title: "La informacion proviene del servicio", message: "", retry: false)
    }
    
}

//MARK: -> PersonViewController UISearchBar
extension PersonViewController : UISearchBarDelegate {
    //MARK: -> UISearchBar textDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = persons.filter { person in
            return person.name.lowercased().contains(searchText.lowercased())
        }
        search = searchText
        refreshTable()
    }
    
    //MARK: -> UISearchBar searchBarSearchButtonClicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

//MARK: -> PersonViewController alert
extension PersonViewController {
    func showAlert (title: String, message: String, retry: Bool){
        self.personActivityIndicator.stopAnimating()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if retry{
            alert.addAction( UIAlertAction(title: "Reintentar", style: .default, handler: {_ in
                alert.dismiss(animated: true)
                self.getPersons()
            }))
        } else {
            alert.addAction( UIAlertAction(title: "OK", style: .default, handler: {_ in
                alert.dismiss(animated: true)
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
