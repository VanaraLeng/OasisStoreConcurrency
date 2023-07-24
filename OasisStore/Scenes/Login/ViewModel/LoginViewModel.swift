//
//  LoginViewModel.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/6/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    var isValidInput: Bool {
        guard username.isValidEmail() || username.isValidUsername() else { return false }
        guard !password.isEmpty && !password.hasWhiteSpace() else { return false }
        return true
    }
    
    func login() {
        // Simulate login
        KeychainUtil.shared.save(service: .accessToken, secret: "ey1234567abc")
    }
}
