//
//  OnBoardingView.swift
//  carApp
//
//  Created by eLOQ on 10/02/2021.
//

import SwiftUI
import FirebaseAuth

struct OnBoardingView: View {
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var providerID: String = ""
    @State var provider: String = ""
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showOnboardingPart2: Bool = false
    @State var showError: Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
            
            Text("Welcome to DogGram")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Text("This is the #1 app in the world for sharing the best pictures of the best dogs")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            
            // MARK: APPLE SIGN IN
            Button(action: {
                
                SignInWithApple.instance.startSignInWithAppleFlow(view: self)
             
            }, label: {
              SignInWithAppleButtonCustom()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            })
            
            
            
            // MARK: GOOGLE SIGN IN
            Button(action: {
                
                SignInWithWithGoogle.instance.startSignInWIthGoogleFlow(view: self)
             
            }, label: {
                HStack{
                    
                    Image(systemName: "globe")
                    
                    Text("Sign in with Google")
                    
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(6)
                .font(.system(size: 23, weight: .medium, design: .default))
            })
            .accentColor(Color.white)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Continue as guest".uppercased())
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
            })
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.beigeColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }, content: {
            OnboardingViewPart2(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
        })
        .alert(isPresented: $showError, content: {
            return Alert(title: Text("ERROR SIGNING IN 🙁"))
        })
    }
    
    //MARK: FUNCTIONS
    
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential){
        
        AuthService.instance.logInUserToFirebase(credential: credential){(returnedProviderID, isError, isNewUser, returnedUserId) in
            
            if let newUser = isNewUser {
                
                if newUser {
                    //new user
                    if let providerID = returnedProviderID, !isError {
                        //success
                        //new user go to onboarding part 2
                        self.displayName = name
                        self.email = email
                        self.providerID = providerID
                        self.provider = provider
                        
                        self.showOnboardingPart2.toggle()
                    }else{
                        //error
                        print("error getting provider id from log in user to firebase")
                        self.showError.toggle()
                    }
                } else {
                    //existing user
                    
                    if let userID = returnedUserId{
                        //login to app
                        
                        AuthService.instance.logInUserToApp(userID: userID) { (success) in
                            if (success){
                                print("success fil login")
                                self.presentationMode.wrappedValue.dismiss()
                            }else{
                                self.showError.toggle()
                            }
                        }
                        
                    } else{
                        
                        //error
                        print("error getting provider id from existing user in firebase")
                        self.showError.toggle()
                    }
                    
                }
                
            } else {
                
                
                //error
                print("error getting into from log in user to firebase")
                self.showError.toggle()
                
            }
            
            
            
            
           
            
            
            
            
            
            
        }
        
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
