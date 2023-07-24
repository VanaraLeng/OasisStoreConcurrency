//
//  KeychainUtil.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation
import Security

enum KeychainServiceType: String {
    case accessToken
    case refreshToken
}

class KeychainUtil {
    let account = Bundle.main.bundleIdentifier!
    
    static let shared = KeychainUtil()
    private init() {}
    
    /// Save secret to Keychain
    /// ```
    /// service is type of you retrieve.
    /// secret is your password or token
    /// ```
    func save(service: KeychainServiceType, secret: String) {
        guard let passData = secret.data(using: .utf8) else { return }
        let addQuery : [CFString : Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service.rawValue,
            kSecValueData : passData
        ]
        
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            // Update existing item
            let attributesToUpdate = [kSecValueData: passData] as CFDictionary
            SecItemUpdate(addQuery as CFDictionary, attributesToUpdate)
        } else if status != errSecSuccess {
            print(status)
        }
    }

    /// Get secret from keychain
    /// ```
    /// service is type of you secret
    /// ```
    func retrieve(service: KeychainServiceType) -> String? {
        
        let keychainItem: [CFString : Any] = [
          kSecAttrAccount: account,
          kSecAttrService: service.rawValue,
          kSecClass: kSecClassGenericPassword,
          kSecReturnData: true
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(keychainItem as CFDictionary, &item)
        guard status == errSecSuccess,
              let result = item as? Data else {
            print(status)
            return nil
        }
        
        return String(data: result, encoding: .utf8)
    }
    
    func delete(service: KeychainServiceType) {
        let keychainItem: [CFString : Any] = [
          kSecAttrAccount: account,
          kSecAttrService: service.rawValue,
          kSecClass: kSecClassGenericPassword,
        ]
        let status = SecItemDelete(keychainItem as CFDictionary)
        if status == errSecSuccess {
            print(status)
        }
    }
    
}
