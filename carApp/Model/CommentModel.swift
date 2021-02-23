//
//  CommentModel.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import Foundation
import SwiftUI

struct CommentModel: Identifiable, Hashable {
    
    var id = UUID()
    var commentID: String // ID for comment in DB
    var userID: String //id for user in DB
    var username: String // username
    var content: String // actual comment text
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
