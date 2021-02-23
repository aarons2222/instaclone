//
//  ImageGridView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI


struct ImageGridView: View {
    
    @ObservedObject var posts: PostArrayObject
    
    var body: some View {
        
        LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                  ],
                  alignment: .center,
                  spacing: nil,
                  pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                  content: {
                    
                    ForEach(posts.dataArray, id: \.self) { post in
                        
                        NavigationLink(
                           
                            destination: FeedView(posts: PostArrayObject(post: post), title: "Post"),
                            label: {
                                PostView(post: post, showHeaderAndFooter: false, addHeartAnimationToView: false)
                            })
                        
                    }
        })
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(posts: PostArrayObject())
            .previewLayout(.sizeThatFits)
    }
}
