//
//  PostTableViewCell.swift
//  SWRedditAPIApp
//
//  Created by Myles Cashwell on 5/6/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postAuthorNameLabel: UILabel!
    @IBOutlet weak var postUpvotesLabel: UILabel!
    @IBOutlet weak var postUpsCountLabel: UILabel!
    
    
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Functions
    func updateViews() {
        guard let post = post else { return }
        postTitleLabel.text = post.title
        
        postAuthorNameLabel.text = "By: \(post.name)"
        postAuthorNameLabel.textColor = .secondaryLabel
        
        postUpvotesLabel.text = "Upvotes:"
        
        postUpsCountLabel.text = "\(post.ups)"
        postUpsCountLabel.textColor = .green
        
        
        PostController.fetchThumbnail(for: post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    self.postImageView.image = thumbnail
                    self.postImageView.layer.cornerRadius = 10
                case .failure(let error):
                    self.postImageView.image = UIImage(named: "noImage")
                    print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
