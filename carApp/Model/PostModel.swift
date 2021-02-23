//
//  PostModel.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    
    var id = UUID()
    
    var postID: String // ID for post in DB
    var userID: String // ID for user in DB
    var username: String // username of user in DB
    var caption: String?
    var dateCreate: Date
    var likeCount: Int
    var likedByUser: Bool
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
