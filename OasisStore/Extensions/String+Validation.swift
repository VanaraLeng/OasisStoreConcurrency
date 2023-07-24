//
//  String+Validation.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/6/23.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidUsername() -> Bool {
        return self.count > 3 && !hasWhiteSpace()
    }
    
    func hasWhiteSpace() -> Bool {
        self.rangeOfCharacter(from: .whitespaces) != nil
    }
}
