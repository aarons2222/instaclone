//
//  CommentsView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct CommentsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    var body: some View {
       
        VStack{
            
            ScrollView {
             
                LazyVStack{
                    
                    ForEach(commentArray, id: \.self) { comment in
                        MessageView(comment: comment)
                    }
                }
            }
            
            HStack{
                
                Image("dog1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a coment here...", text: $submissionText)
                
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        
                })
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yelowColor)

            }
            .padding(.all, 6)
        }
        .padding(.horizontal)
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
        })
    }
    
    // MARK: FUNCTIONS
    
    func getComments() {
        
        print("GET COMMENTS FROMM DB")
        
        let comment1 = CommentModel(commentID: "", userID: "", username: "Aaron", content: "This is the first comment", dateCreated: Date())
        
        let comment2 = CommentModel(commentID: "", userID: "", username: "Barry", content: "This is the second comment", dateCreated: Date())
        
        
        let comment3 = CommentModel(commentID: "", userID: "", username: "Bruce", content: "This is the third comment", dateCreated: Date())
        
        let comment4 = CommentModel(commentID: "", userID: "", username: "Desmond", content: "This is the fourth comment", dateCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
        
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CommentsView()
                .preferredColorScheme(.dark)

        }
    }
}
