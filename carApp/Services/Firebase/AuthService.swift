//
//  AuthService.swift
//  carApp
//
//  Created by eLOQ on 10/02/2021.
//


// authenticate users in firsbase
//handle user accounts
import Foundation
import FirebaseAuth
import FirebaseFirestore //database

let DB_BASE = Firestore.firestore()

class AuthService {
    // MARK: PROPERTIES
    
    static let instance = AuthService()
    
    
    private var REF_USERS = DB_BASE.collection("users")
    
    
    // MARK: AUTH USER FUNCTIONS
    
    func logInUserToFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool, _ isNewUser: Bool?, _ userID: String?) -> ()) {
        
        Auth.auth().signIn(with: credential) { (result, error) in
            //check for errors
            if error != nil {
                print("Error logging in to Firebase")
                handler(nil, true, nil, nil)
                return
            }
            //check for provider id
            guard let providerID = result?.user.uid else {
                print("Error gettung provider ID")
                handler(nil, true, nil, nil)
                return
            
            }
            
            //check if user exists
            
            self.checkIfUserExists(providerID: providerID) { (returnedUSerID) in
                if let userID = returnedUSerID {
                    //user exists, login to app
                    
                    handler(providerID, false, false, userID)
                    
                } else {
                    //user does NOT exist, continue onboarding process
                    
                    handler(providerID, false, true, nil)
                }
            }
            
           
        }
    }
    
    
    
    func logInUserToApp(userID: String, handler: @escaping (_ success: Bool) -> () ){
        
        // get user info
        getUserInfo(forUserID: userID) { (returnedName, returnedBio) in
            if let name = returnedName, let bio = returnedBio{
                //sucess
                print("success logging in user")
                handler(true)
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    //set user info
                
                    UserDefaults.standard.set(userID, forKey: CurrentUserDefaults.userID)
                UserDefaults.standard.set(bio, forKey: CurrentUserDefaults.bio)
                UserDefaults.standard.set(name, forKey: CurrentUserDefaults.displayName)
                
                }
                
                
                
                
            }else{
                //error
                print("error getting user info while logging in")
                handler(false)
            }
        }
        
        // set user info in app
    }
    
    
    func logOutUser(handler: @escaping (_ success: Bool) -> ()){
        
    do{
     try Auth.auth().signOut()
    } catch {
          print("Error \(error)")
          handler(false)
          return
        }
        
        handler(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
            
            defaultsDictionary.keys.forEach { (key) in
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    
    
    
    
    func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping (_
                userID: String?) -> ()){
        
        
        // set up user document within user collection
        
        let document = REF_USERS.document()
        let userID = document.documentID
        
        
        //upload profile image to storage
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        
        
        //upload prifle data to firestore
        let userData: [String: Any] = [
            
            DatabaseUserField.displayName : name,
            DatabaseUserField.email : email,
            DatabaseUserField.providerID : providerID,
            DatabaseUserField.provider : provider,
            DatabaseUserField.userID : userID,
            DatabaseUserField.bio : "",
            DatabaseUserField.dateCreated : FieldValue.serverTimestamp(),
            
        ]
        
        document.setData(userData) { (error) in
            
            if let error = error {
                
                //Error
                print("Error uploading data to user document. \(error)")
                handler(nil)
            }else{
                //Success
                handler(userID)

                //update user defaults
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
                    
                    defaultsDictionary.keys.forEach { (key) in
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                }            }
        }
        
    }
    
    
    private func checkIfUserExists(providerID: String, handler: @escaping (_ existingUserID: String?) -> ()){
        //if a user is returned then user already exists
        
        REF_USERS.whereField(DatabaseUserField.providerID, isEqualTo: providerID).getDocuments { (querySnapshot, error) in
            
            if let snapshot = querySnapshot, snapshot.count > 0, let document = snapshot.documents.first{
                //success
                let existingUserID = document.documentID
                handler(existingUserID)
                return
            }else {
                //error
                handler(nil)
                return
            }
            
        }
    }
    
    // MARK: GET USER FUNCTIONS
    
    
    func getUserInfo(forUserID userID: String, handler: @escaping (_ name: String?, _ bio: String?) -> ()) {
        
        REF_USERS.document(userID).getDocument { (documentSnapshot, error) in
            
            if let document = documentSnapshot,
               let name = document.get(DatabaseUserField.displayName) as? String,
               let bio = document.get(DatabaseUserField.bio) as? String{
                
                print("SUCCESS GETTING USER INFO")
                handler(name, bio)
                return
                
            }else{
                print("error getting user info")
                handler(nil, nil)
                return
            }
            
        }
    }
}
