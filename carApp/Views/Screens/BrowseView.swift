//
//  BrowseView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct BrowseView: View {
    
    
    var posts = PostArrayObject()
    
    
    var body: some View {
        
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
           CarouselView()
            ImageGridView(posts: posts)
        })
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
    
        NavigationView{
            BrowseView()
        }
    }
}
