//
//  PostError.swift
//  SWRedditAPIApp
//
//  Created by Myles Cashwell on 5/5/21.
//

import Foundation

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case.invalidURL:
            return "Unable to reach the server."
        case .thrownError(let error):
            print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
            return "That post does not exist\nPlease check your spelling"
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responded with bad data. Blame the back-end team, not the front-end"
        }
    }
}
