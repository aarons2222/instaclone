//
//  SettingsEditIMageView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct SettingsEditImageView: View {

    
    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage
    @State var showImagePicker: Bool = false
    
    @State var sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){
            
            HStack{
                Text(description)
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            
        
    Image(uiImage: selectedImage)
        .resizable()
        .scaledToFill()
        .frame(width: 200, height: 200, alignment: .center)
        .clipped()
        .cornerRadius(12)
            
            
            
            
            Button(action: {
                showImagePicker.toggle()
                
            }, label: {
                Text("Import".uppercased())
                    .font(.title3)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.yelowColor)
                    .cornerRadius(12)
            })
            .accentColor(Color.MyTheme.purpleColor)
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(imageSelected: $selectedImage, sourceType: $sourceType)
            })
            
            
            
            
            Button(action: {
                
            }, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purpleColor)
                    .cornerRadius(12)
            })
            .accentColor(Color.MyTheme.yelowColor)
            
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(title)
    }
    
}



struct SettingsEditImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        SettingsEditImageView(title: "Title", description: "description", selectedImage: UIImage(named: "dog1")!)
        }
    }
}
