//
//  SettingsView.swift
//  carApp
//
//  Created by eLOQ on 09/02/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State var showSignOutError: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
        
            ScrollView(.vertical, showsIndicators: false, content: {
                
                //MARK: SECTION 1
                GroupBox(label: SettingsLabelView(labelText: "DogGram", labelImage: "dot.radiowaves.left.and.right"), content: {
                   
                    HStack(alignment: .center, spacing: 10, content: {
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        
                            Text("This is the #1 app in the world for sharing the best pictures of the best dogs")
                    })
                })
                .padding()
                
                
                //MARK: SECTION 2
                
                
                GroupBox(label: SettingsLabelView(labelText: "Profile", labelImage: "person.fill"), content: {
                    NavigationLink(
                        destination: SettingsEditTextView(submissionText: "Current Display Name", title: "Display Name", description: "You can edit your display name here. This will be seen by other users on your profile and on your posts", placeholder: "Your display name here..."),
                        label: {
                            SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.MyTheme.purpleColor)

                        })
                    
                    
                    NavigationLink(
                        destination: SettingsEditTextView(submissionText: "Current bio here", title: "Profile Bio", description: "Your bio is a great place to let other users know about you.  ", placeholder: "Your bio here..."),
                        label: {
                            SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.purpleColor)

                        })

                    
                    
                    NavigationLink(
                        destination: SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your profile and on your posts. Most users make it an image of themselves or of their dog!", selectedImage: UIImage(named: "dog1")!),
                        label: {
                            SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.MyTheme.purpleColor)
                        })

                  
                    
                    Button(action: {
                        signOut()
                    }, label: {
                        SettingsRowView(leftIcon: "figure.walk", text: "Sign Out", color: Color.MyTheme.purpleColor)
                    })
                    .alert(isPresented: $showSignOutError, content: {
                        return Alert(title: Text("Error signing out 🥵"))
                    })


                })
                .padding()
                
                
                
                
                //MARK: SECTION 3
                
                
                GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone"), content: {
                    
                    
                    Button(action: {
                        openURL(urlString: "https://www.google.com")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.MyTheme.yelowColor)

                    })
                    
                    
                    Button(action: {
                        openURL(urlString: "https://www.yahoo.com")
                    }, label: {
                        
                         SettingsRowView(leftIcon: "folder.fill", text: "Terms and Condition", color: Color.MyTheme.yelowColor)

                    })
                    
                    Button(action: {
                        openURL(urlString: "https://www.twitter.com")
                    }, label: {
                        SettingsRowView(leftIcon: "globe", text: "Website", color: Color.MyTheme.yelowColor)
                        

                    })
                    
         

           
                    
                    
                })
                .padding()
                
                
                //MARK: SECTION 3
                
            
                
                GroupBox{
                    
                    Text("This app was mad with love. \n All Rights Reserved \n Flatwhite.it \n Copyright 2021")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom, 80)
                
            })
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                       Image(systemName: "xmark")
                                        .font(.title)
                                    })
                                    .accentColor(.primary)
            )
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yelowColor)
     
    }
    
    // MARK: FUNCTIONS
    
    func openURL(urlString: String){
        
        guard let url = URL(string: urlString) else {return}
        
        if UIApplication.shared.canOpenURL(url){
            
            UIApplication.shared.open(url)
        }
    }
    
    func signOut (){
        
        AuthService.instance.logOutUser { (success) in
            if success {
                print("successfully logged out")
                
                self.presentationMode.wrappedValue.dismiss()
                
           
                
            
            } else {
                print("Error loggin out")
                
                self.showSignOutError.toggle()
                
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
