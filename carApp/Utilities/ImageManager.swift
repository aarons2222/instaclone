//
//  ImageManager.swift
//  carApp
//
//  Created by eLOQ on 10/02/2021.
//

import Foundation
import FirebaseStorage

let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager {
    
    // MARK: PROPERTIES
    
    static let instance = ImageManager()
    
    private var REF_STOR = Storage.storage()
    
    
    
    // MARK: PUBLIC FUNCTIONS
    
    
    func uploadPostImage(postID: String, image: UIImage, handler: @escaping (_ success: Bool) -> ()){
        
        
        let path = getPostImagePath(postID: postID)
        
        uploadImage(path: path, image: image) { (success) in
            handler(success)
        }
    }
    
    func uploadProfileImage(userID: String, image: UIImage){
        
        //get upload path
        
        let path = getProfileImagePath(userID: userID)
        
        
        //save image
        
        uploadImage(path: path, image: image) { (_) in }
    }
    
    
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) -> ()){
        
        let path = getProfileImagePath(userID: userID)
        
        
        //download image from path
        
        downloadImage(path: path){ (returnedImage) in
            
            handler(returnedImage)
            
        }
    }
    
    func downloadPostImage(postID: String, handler: @escaping (_ image: UIImage?) -> ()){
        
        let path = getPostImagePath(postID: postID)
        
        //download image from path
        
        downloadImage(path: path) { (returnedImage) in
            handler(returnedImage)
        }
        
    }
    
    // MARK: PRIVATE FUNCTIONS
    
    
    private func getProfileImagePath(userID: String) -> StorageReference {
        
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func getPostImagePath(postID: String) -> StorageReference{
        let postPath = "posts/\(postID)/1"
        let storagePath = REF_STOR.reference(withPath: postPath)
        return storagePath
    }
    
    
    private func uploadImage(path: StorageReference, image: UIImage, handler: @escaping (_ success: Bool) -> ()){
        
        var compression: CGFloat = 1.0
        
        let maxFileSize: Int = 240 * 240 //max file size to be saved
        let maxCompression: CGFloat = 0.05 // max compression allowed
        
        
        // get image data
        guard var originalData = image.jpegData(compressionQuality: compression) else{
            
            print("ERROR GETTING DATAS FROM IMAGE")
            handler(false)
            return
        }
        
        // check max file size
        
        while (originalData.count > maxFileSize) && (compression > maxCompression ) {
            
            compression -= 0.05
            
            if let compressedData  = image.jpegData(compressionQuality: compression){
                originalData = compressedData
            }
            print("COMPRESSION \(compression)")
        }
        
        
        // get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else{
            
            print("ERROR GETTING DATAS FROM IMAGE")
            handler(false)
            return
        }
        
        // get photo metadata
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        
        //save data to path
        path.putData(finalData, metadata: metadata) { (_, error) in
            
            if let error = error {
                // ERROR
                print("error uploading image.  \(error)")
                handler(false)
                return
            } else {
                //SUCCESS
                print("success uploading image")
                handler(true)
                return
            }
            
        }
    }
    
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image: UIImage?) -> ()){
        
        if let cachedImage = imageCache.object(forKey: path){
            print("image found in cache")
            handler(cachedImage)
            return
        } else{
            
            path.getData(maxSize: 27 * 1024 * 1024) { (returnedImageData, error) in
                
                if let data = returnedImageData, let image = UIImage(data: data){
                    
                    //success getting image data
                    
                    imageCache.setObject(image, forKey: path)
                    
                    handler(image)
                    return
                    
                } else {
                    //cant get image data
                    
                    print("error getting image daga")
                    handler(nil)
                    return
                }
            
        }
        
        
        }
        
    }
}
