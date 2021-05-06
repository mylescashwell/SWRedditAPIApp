//
//  PostListTableViewController.swift
//  SWRedditAPIApp
//
//  Created by Myles Cashwell on 5/6/21.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - Properties
    var posts: [Post] = []
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsForCells()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = posts[indexPath.row]
        cell.post = post
//        cell.updateViews()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    //MARK: - Functions
    func fetchPostsForCells() {
        PostController.fetchPost { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
     */
}
