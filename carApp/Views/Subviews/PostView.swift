//
//  PostView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct PostView: View {
    
    
    @State var post: PostModel
    var showHeaderAndFooter: Bool
    @State var animateLike: Bool = false
    
    @State var addHeartAnimationToView: Bool
    
    @State var showActionSheet: Bool = false
    
    @State var actionSheetType: PostActionSheetOption = .general
    

    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    @State var postImage: UIImage = UIImage(named: "logo.loading")!

    
    
    enum PostActionSheetOption{
        case general
        case reporting
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
           // MARK: HEADER
            
            if showHeaderAndFooter{
                HStack {
                    NavigationLink(
                        destination: ProfileView(isMyProfile: false, profileDisplayName: post.username, profileUSerID: post.userID, posts: PostArrayObject(userID: post.userID)),
                        label: {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(15)
                            
                            Text(post.username)
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        })
                    
                  
                        
                    Spacer()
                    
                    
                    Button(action: {
                        showActionSheet.toggle()
                        
                    }, label: {
                        Image(systemName: "ellipsis")
                            .font(.headline)
                    })
                    .accentColor(.primary)
                    .actionSheet(isPresented: $showActionSheet, content:{
                        getActionSheet()
                    })
                    
                  
                    
                }
                .padding(.all, 6)
                
            }
            
            
            
        
            // MARK: IMAGE
            
            ZStack{
                
                Image(uiImage: postImage)
                    .resizable()
                    .scaledToFit()
                
                if addHeartAnimationToView{
                    LikeAnimationView(animate: $animateLike)

                }
                
    
            }
            
           
            // MARK: FOOTER
            
            
            
            
            if showHeaderAndFooter{
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                   
                    Button(action: {
                        
                        if post.likedByUser{
                            //unlike
                            unlikePost()
                        }else{
                            //like
                            likePost()
                        }
                        
                    }, label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                            
                    
                        
                    })
                    .accentColor(post.likedByUser ? .red : .primary)
                 
                    //MARK: COMMENT ICON
                    NavigationLink(
                        
                        destination: CommentsView(),
                        label: {
                            Image(systemName: "bubble.middle.bottom")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    )
                    
                    Button(action: {
                        sharePost()
                    }, label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                    })
                    .accentColor(.primary)
                 
                    Spacer()
                }
                
                
                
                )
                
                
                
                .padding(.all, 6)
                if let caption = post.caption{
                    HStack {
                        Text(caption)
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.all, 6)
                }
            }
           
        })
        .onAppear{
            
            getImages()
            
        }
    }
    
    
    // MARK: FUNCTIONS
    
    func likePost(){
        // update local data
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreate: post.dateCreate, likeCount: post.likeCount + 1, likedByUser: true)
        self.post = updatedPost
        
        
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            animateLike = false
        }
    }
    
    
    func unlikePost(){
        // update local data
        
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreate: post.dateCreate, likeCount: post.likeCount - 1, likedByUser: false)
        self.post = updatedPost
    }
    
    
    func getImages(){
        
        //get profile image
        
        ImageManager.instance.downloadProfileImage(userID: post.userID) { (returnedImage) in
           
            if let image = returnedImage{
            self.profileImage = image
            }
        }
        
        //get post image
        
        
        ImageManager.instance.downloadPostImage(postID: post.postID){ (returnedImage) in
            if let image = returnedImage{
                
                self.postImage = image
                
            }
        }
    }
    
    
    func getActionSheet() -> ActionSheet{
        
        switch self.actionSheetType {
        case .general:
            return ActionSheet(title: Text("What would you like to do?"), message: nil, buttons: [
                
                .destructive(Text("Report"), action: {
                  
                    self.actionSheetType = .reporting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.showActionSheet.toggle()
                    }
                   
                }),
                
                .default(Text("Learn more..."),  action: {
                    print("LEARN MORE PRESSED")
                }),
                
                .cancel()
             
            ])
            
        case .reporting:
            return ActionSheet(title: Text("Why are you reporting this post?"), message: nil,
           buttons: [
                
                .destructive(Text("This is inappropriate"), action: {
                   reportPost(reason: "This is inappropriate")
                }),
            
             .destructive(Text("This is spam"), action:{
               reportPost(reason: "This is spam")
            }),
              
                .destructive(Text("It made me uncomfortable"), action:{
                   reportPost(reason: "It made me uncomfortable")
                }),
              
            .cancel({
            self.actionSheetType = .general
         })
                
            ])
        }
     
    
    }
    
    
    func reportPost(reason: String){
        print("REPOST POST NOW")
    }
    
    
    func sharePost(){
        
        let message = " Checkout this post"
        let image = postImage
        let link = URL(string: "https://www.google.com")!
        
        let activityViewController = UIActivityViewController(activityItems: [message, image, link], applicationActivities: nil)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityViewController, animated: true, completion: nil)
        
    }
    
}

struct PostView_Previews: PreviewProvider {
    
    static var post: PostModel = PostModel(postID: " ", userID: " ", username: "aaron ", caption: "test caption", dateCreate: Date(), likeCount: 0, likedByUser: false)
 
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
            .previewLayout(.sizeThatFits)
    }
}
