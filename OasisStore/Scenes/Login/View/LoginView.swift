//
//  SwiftUIView.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/6/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    @Environment(\.dismiss) var dismiss;
    
    @FocusState private var shouldFocusOnUsername: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, .accentColor], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Spacer()
                    Button("login_skip") {
                        dismiss()
                    }
                    .buttonStyle(MainButtonStyle())
                }
            
                Spacer()
                
                Text("login_title")
                    .titleText()
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack (spacing: 16) {
                    // Username
                    TextField("login_username", text: $vm.username)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($shouldFocusOnUsername)
                    
                    // Password
                    SecureField("login_password", text: $vm.password)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // Login button
                    Button {
                        vm.login()
                        dismiss()
                    } label: {
                        Text("login_button")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(!vm.isValidInput)
                    .buttonStyle(MainButtonStyle())
                }
                
                Spacer()
            }
            .onAppear {
                shouldFocusOnUsername = true
            }
            .padding(20)
        }
        
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
