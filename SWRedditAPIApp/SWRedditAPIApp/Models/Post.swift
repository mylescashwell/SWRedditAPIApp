//
//  Post.swift
//  SWRedditAPIApp
//
//  Created by Myles Cashwell on 5/5/21.
//

import UIKit

struct FirstLevelObject: Codable {
    let data: SecondLevelObject
}

struct SecondLevelObject: Codable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let name: String
    let title: String
    let ups: Int
    let thumbnail: String
}
