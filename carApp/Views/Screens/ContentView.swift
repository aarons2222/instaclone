//
//  ContentView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    
    var body: some View {
        TabView{
            NavigationView{
                FeedView(posts: PostArrayObject(), title: "Feed")
            }
            
                .tabItem{
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView{
                BrowseView()

                
            }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
           UploadView()
                .tabItem{
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            
            
            ZStack{
                
                if let userID = currentUserID, let displayName = currentUserDisplayName{
                    
                    NavigationView{
                        
                        ProfileView(isMyProfile: true, profileDisplayName: displayName, profileUSerID: userID, posts: PostArrayObject(userID: userID))
                    }
                    
                }else{
                    SignupView()
                }
                
          
                
            }
            .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor :
                        Color.MyTheme.yelowColor)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
