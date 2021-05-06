//
//  PostController.swift
//  SWRedditAPIApp
//
//  Created by Myles Cashwell on 5/5/21.
//

import UIKit

class PostController {
    
    //MARK: - Network Calls
    static func fetchPost(completion: @escaping (Result<[Post], PostError>) -> Void) {
        let baseURL = URL(string: "https://www.reddit.com/r/StarWars/.json")
        guard let finalURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
//                print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POST STATUS CODE \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let firstLevelObject = try JSONDecoder().decode(FirstLevelObject.self, from: data)
                let secondLevelObject = firstLevelObject.data
                let thirdLevelObject = secondLevelObject.children
                
                var arrayOfObject: [Post] = []
                
                for posts in thirdLevelObject {
                    let post = posts.data
                    arrayOfObject.append(post)
                }
                completion(.success(arrayOfObject))
            } catch {
//                print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchThumbnail(for post: Post, completion: @escaping (Result<UIImage,PostError>) -> Void) {
        guard let thumbnailURL = URL(string: post.thumbnail) else { return completion(.failure(.invalidURL)) }
        URLSession.shared.dataTask(with: thumbnailURL) { (data, response, error) in
            if let error = error {
//                print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("THUMBNAIL STATUS CODE \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.noData)) }
            completion(.success(thumbnail))
        }.resume()
    }
}
