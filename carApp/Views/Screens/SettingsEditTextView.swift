//
//  SettingsEditTextView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct SettingsEditTextView: View {
    @Environment(\.colorScheme) var colorScheme

    @State var submissionText: String = ""
    
    @State var title: String
    @State var description: String
    @State var placeholder: String
    
    var body: some View {
        
        VStack{
            
            HStack{
                Text(description)
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            
        
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(colorScheme == .light ? Color.MyTheme.beigeColor : Color.MyTheme.purpleColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Button(action: {
                
            }, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yelowColor)
                    .cornerRadius(12)
            })
            .accentColor(colorScheme == .light ? Color.MyTheme.yelowColor : Color.MyTheme.purpleColor)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(title)
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SettingsEditTextView(title: "Test Title", description: "Test Desc", placeholder: "Test Placeholder")
                .preferredColorScheme(.dark)

        }
    }
}
