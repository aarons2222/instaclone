//
//  ProfileHeaderView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @Binding var profileDIsplayName: String
    @Binding var profileImage: UIImage
    
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10, content: {
            
            
            //MARK: PROFILE PICTURE
            
            
            
            
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
           
            //MARK: USERNAME
            Text(profileDIsplayName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            //MARK: BIO
            Text("This is the area where the user can add a bio to their profile")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            
            HStack(alignment: .center, spacing: 20, content: {
               
                //MARK: POSTS
                VStack(alignment: .center, spacing: 5, content: {
                    
                    Text("5")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Posts")
                        .font(.callout)
                        .fontWeight(.medium)
                    
                })
                
                
                
                
                // MARK: LIKES
                VStack(alignment: .center, spacing: 5, content: {
                    
                    Text("20")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                    
                })
            })
        })
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    
    @State static var name: String = "Desmond"
    @State static var image: UIImage = UIImage(named: "dog1")!
    
    
    static var previews: some View {
        ProfileHeaderView(profileDIsplayName: $name, profileImage: $image)
            .previewLayout(.sizeThatFits)
    }
}
