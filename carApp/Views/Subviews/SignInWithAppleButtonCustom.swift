//
//  SignInWIghtAppleButtonCustom.swift
//  carApp
//
//  Created by eLOQ on 10/02/2021.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonCustom: UIViewRepresentable{
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton{
        return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) { }
    
}
