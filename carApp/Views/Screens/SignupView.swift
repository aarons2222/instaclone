//
//  SignupView.swift
//  carApp
//
//  Created by eLOQ on 10/02/2021.
//

import SwiftUI

struct SignupView: View {
    
    @State var showOnboarding: Bool = false
    
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Spacer()
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("You're not signed in! 🙁")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Text("Click the button neloow to create a account and join the fun")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Button(action: {
                showOnboarding.toggle()
            }, label: {
                Text("Sign in/ Sign up".uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.MyTheme.purpleColor)
                    .cornerRadius(12)
                    .shadow(radius: 12)
            })
            .accentColor(Color.MyTheme.yelowColor)
            
            Spacer()
        })
        .padding(.all, 40)
        .background(Color.MyTheme.yelowColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboarding, content: {
            OnBoardingView()
        })
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .preferredColorScheme(.dark)
    }
}
