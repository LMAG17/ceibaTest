//
//  PostsViewController.swift
//  ceibaTest
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import UIKit

//MARK: -> PostsViewController
class PostsViewController: UIViewController {

    //MARK: -> Manager
    var postsManager = PostsManager()
    
    //MARK: Variables
    var posts : [Post] = []
    var user : Person?
    
    //MARK: -> Outlets
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var postActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var postsTitle: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userStack: UIStackView!
    
    //MARK: -> viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.register(UINib(nibName: "PostCellTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsManager.delegate = self
        postActivityIndicator.hidesWhenStopped = true
        prepareForUserContent()
    }
    
    //MARK: -> prepareForUserContent
    func prepareForUserContent (){
        if let id = user?.id, user != nil {
            DispatchQueue.main.async {
                self.postsTitle.isHidden = false
                self.postsTitle.text = "Las publicaciones de \(self.user!.name):"
                self.userNameLabel.text = "\(self.user!.name)"
                self.userPhoneLabel.text  = "☎ \(self.user!.phone)"
                self.userEmailLabel.text = "📧 \(self.user!.email)"
                self.title = "Publicaciones"
            }
            getPostsByUserId(userId: id)
        }
        else{
            DispatchQueue.main.async {
                self.postsTitle.isHidden = true
                self.userStack.isHidden = true
                self.title = "Publicaciones"
            }
            getPosts()
        }
    }
    
}

//MARK: -> PostsViewController UITableView
extension PostsViewController : UITableViewDelegate, UITableViewDataSource {
    
    //MARK: -> UITableView numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    //MARK: -> UITableView cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCellTableViewCell
        
        postCell.titleText = posts[indexPath.row].title
        postCell.descriptionText = posts[indexPath.row].body
        
        return postCell
    }
    
    //MARK: -> UITableView heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //MARK: -> UITableView didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK: -> UITableView refreshTable
    func refreshTable(posts: [Post]) {
        self.posts = posts
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
            self.postsTableView.isHidden = false
            self.postActivityIndicator.stopAnimating()
        }
    }
    
    //MARK: -> UITableView tableLoading
    func tableLoading() {
        DispatchQueue.main.async {
            self.postsTableView.isHidden = true
            self.postActivityIndicator.startAnimating()
        }
    }
    
}

//MARK: -> PostsViewController PostsManagerDelegate
extension PostsViewController : PostsManagerDelegate {
    
    //MARK: -> PostsViewController onError
    func onError(message: String?) {
        DispatchQueue.main.async {
            self.postActivityIndicator.stopAnimating()
        }
        let alert = UIAlertController(title: "Se presento un error obteniendo las personas", message: "Por favor intente nuevamente mas tarde", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Reintentar", style: .default, handler: { uiAction in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: -> PostsViewController getPosts
    func getPosts(){
        tableLoading()
        postsManager.getPosts()
    }
    
    //MARK: -> PostsViewController getPostsByUserId
    func getPostsByUserId(userId : Int){
        tableLoading()
        postsManager.getPostsByUser(userId: userId)
    }
    
    //MARK: -> PostsViewController onPostsUpdate
    func onPostsUpdate(posts: [Post]) {
        refreshTable(posts: posts)
    }
    
    //MARK: -> PostsViewController onPostsByUserReceived
    func onPostsByUserReceived(posts: [Post]) {
        refreshTable(posts: posts)
    }
}
