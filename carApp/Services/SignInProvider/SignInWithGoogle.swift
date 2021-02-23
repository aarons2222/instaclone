//
//  SignInWithGoogle.swift
//  carApp
//
//  Created by eLOQ on 10/02/2021.
//

import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseAuth

class SignInWithWithGoogle: NSObject, GIDSignInDelegate{
    
    
    
    static let instance = SignInWithWithGoogle()
    var onboardingView: OnBoardingView!
    
    func startSignInWIthGoogleFlow(view: OnBoardingView){
        
        self.onboardingView = view
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance()?.presentingViewController.modalPresentationStyle = .fullScreen
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print("ERROR SIGNING IN TO GOOGLE")
        
        self.onboardingView.showError.toggle()
        return
      }
        
        
        let fullName: String = user.profile.name
        let email: String = user.profile.email
        
        let idToken: String = user.authentication.idToken
        let accessToken: String = user.authentication.accessToken
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        
        self.onboardingView.connectToFirebase(name: fullName, email: email, provider: "google", credential: credential)

        
 
      // ...
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
      
        
        print("USER DISCONNECTED FROM GOOGLE")
        
        self.onboardingView.showError.toggle()
    }
    
}
