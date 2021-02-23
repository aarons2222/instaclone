//
//  carAppApp.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn


@main
struct carAppApp: App {
    
    init(){
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
      
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    GIDSignIn.sharedInstance().handle(url) // google sign in
                })
        }
    }
}
