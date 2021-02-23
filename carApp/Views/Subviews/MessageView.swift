//
//  MessageView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct MessageView: View {
    
    
    @State var comment: CommentModel
    
    var body: some View {
      
        HStack{
            // MARK: PROFILE IMAGE
            Image("dog1")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 4, content: {
                // MARK: USERNAME
                Text(comment.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                // MARK: CONTENT
                Text(comment.content)
                    .padding(.all, 10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)
            })
            
            Spacer(minLength: 0)
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    
    static var comment: CommentModel = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "This is a cool photo", dateCreated: Date())
    
    
    static var previews: some View {
        MessageView(comment: comment)
            .previewLayout(.sizeThatFits)
    }
}
