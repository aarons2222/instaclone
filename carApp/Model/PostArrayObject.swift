//
//  PostArrayObject.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import Foundation

class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    
    init() {
        
        //fetch post from database
        
        
        
        let post1 = PostModel(postID: "", userID: "", username: "Dave Smith", caption: "caption test", dateCreate: Date(), likeCount: 0, likedByUser: false)

        let post2 = PostModel(postID: "", userID: "", username: "Barry Wilkins", caption: nil, dateCreate: Date(), likeCount: 0, likedByUser: false)

        let post3 = PostModel(postID: "", userID: "", username: "Jony Ive", caption: "Aluminum", dateCreate: Date(), likeCount: 21, likedByUser: false)

        let post4 = PostModel(postID: "", userID: "", username: "Sloth", caption: "chocolatee", dateCreate: Date(), likeCount: 0, likedByUser: true)
  
    
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    
    }
    
    
    /// USED FOR SINGLE POST SELWCTION
    init(post: PostModel) {
        self.dataArray.append(post)
    }
    
    
    
///used for getting posts
    
    init(userID: String){
        
        DataService.instance.downloadPostForUser(userID: userID) { (returnedPosts) in
            let sortedPosts = returnedPosts.sorted { (post1, post2) -> Bool in
                
                return post1.dateCreate > post2.dateCreate
                
            }
            self.dataArray.append(contentsOf: sortedPosts)
        }
        
    }
}
