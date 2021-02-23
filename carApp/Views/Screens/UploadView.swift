//
//  UploadView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI
import UIKit

struct UploadView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var showPostImageView: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack{
                
                Button(action: {
                    sourceType = UIImagePickerController.SourceType.camera
                    showImagePicker.toggle()
                },
                       label: {
                        Text("Take photo".uppercased())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.MyTheme.yelowColor)
                })
                    .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                    .background(Color.MyTheme.purpleColor)
                
                Button(action: {
                    sourceType = UIImagePickerController.SourceType.photoLibrary
                    showImagePicker.toggle()

                },
                       label: {
                        Text("Import photo".uppercased())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.MyTheme.purpleColor)
                })
                    .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                    .background(Color.MyTheme.yelowColor)
                
            }
          
            .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView, content: {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
                    .preferredColorScheme(colorScheme)
                    .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yelowColor)
            })
       
            
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView, content: {
                   
                    PostImageView(imageSelected: $imageSelected)
                        .preferredColorScheme(colorScheme)
                })
        }
        .edgesIgnoringSafeArea(.top)
        
    }
    
    //MARK: FUNCTIONS
    
    func segueToPostImageView(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            showPostImageView.toggle()
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
            .preferredColorScheme(.dark)
    }
}
