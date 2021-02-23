//
//  ProfileVIew.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    var isMyProfile: Bool
    @State var profileDisplayName: String
    var profileUSerID: String
    @State var showSettings: Bool = false
    
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    
    var posts: PostArrayObject
    
    
    var body: some View {
         
        ScrollView(.vertical, showsIndicators: false, content: {
            ProfileHeaderView(profileDIsplayName: $profileDisplayName, profileImage: $profileImage)
            Divider()
            ImageGridView(posts: posts)
             
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showSettings.toggle()
                                },
                                       label: {
                                  Image(systemName: "line.horizontal.3")
                                })
                                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yelowColor)
                                .opacity(isMyProfile ? 1.0 : 0.0)
        )
        
        .onAppear(perform: {
            getProfileImage()
        })
        
        
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
                .preferredColorScheme(colorScheme)
                
        })
    }
    
    //MARK: FUNCTIONS
    
    func getProfileImage(){
        
        ImageManager.instance.downloadProfileImage(userID: profileUSerID) { (returnedImage) in
            
            if let image = returnedImage{
                
                self.profileImage = image
                
            }
            
        }
    }
}

struct ProfileVIew_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            ProfileView(isMyProfile: true, profileDisplayName: "Desmond", profileUSerID: "", posts: PostArrayObject(userID: ""))
                .preferredColorScheme(.dark)
        }

    }
}
