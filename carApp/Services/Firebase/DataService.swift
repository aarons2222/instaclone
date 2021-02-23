//
//  DataService.swift
//  carApp
//
//  Created by eLOQ on 11/02/2021.
//

//used to handle uploading and downloading data

import Foundation
import SwiftUI
import FirebaseFirestore

class DataService {
    //MARK:  PROPERTIES
    
    static let instance = DataService()
    
    private var REF_POSTS = DB_BASE.collection("posts")
    
    
    // MARK: CREATE FUNCTION
    
    func uploadPost(image: UIImage, caption: String?, displayName: String, userID: String, handler: @escaping (_ success: Bool) -> ()){
        
        
        let document = REF_POSTS.document()
        let postID = document.documentID
        
        
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { (success) in
            
            if success {
                
                let postData: [String:Any] = [
                
                    DatabasePostField.postID: postID,
                    DatabasePostField.userID: userID,
                    DatabasePostField.displayName: displayName,
                    DatabasePostField.caption: caption,
                    DatabasePostField.dateCreated: FieldValue.serverTimestamp()
                    
                ]
                
                document.setData(postData) { (error) in
                    if let error = error{
                        print("ERROR UPLOADING DATA TO POST DOCUMENT \(error)")
                        handler(false)
                        return
                    } else {
                        //success upload
                        
                        handler(true)
                        return
                    }
                }
                
            } else{
                handler(false)
                return
            }
        }
        
    }
    
    
    //MARK: GET FUNCTIONS
    
    func downloadPostForUser(userID: String, handler: @escaping (_ posts: [PostModel]) -> ()){
        
        REF_POSTS.whereField(DatabasePostField.userID, isEqualTo: userID).getDocuments { (querySnapshot, error) in
            
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
            
        }
        
    }
    
    
    private func getPostsFromSnapshot(querySnapshot: QuerySnapshot?) -> [PostModel]{
        var postArray = [PostModel]()
        
        if let snapshot = querySnapshot, snapshot.documents.count > 0 {
            
            for document in snapshot.documents {
                
                
                if let userID = document.get(DatabasePostField.userID) as? String,
                   let displayName = document.get(DatabasePostField.displayName) as? String,
                   let timestamp = document.get(DatabasePostField.dateCreated) as? Timestamp{
                    
                    let date = timestamp.dateValue()
                    let postID = document.documentID
                    let caption = document.get(DatabasePostField.caption) as? String
                    
                    let newPost = PostModel(postID: postID, userID: userID, username: displayName, caption: caption, dateCreate: date, likeCount: 0, likedByUser: false)
                            
                    postArray.append(newPost)
                }
                
                
            }
            return postArray
        } else {
            print("No documents in snapshiot found for this user")
            return postArray
         
        }
        
      
    }
    
}


