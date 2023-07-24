//
//  KeychainTest.swift
//  OasisStoreTests
//
//  Created by Vanara Leng on 6/26/23.
//

import Foundation
import XCTest
@testable import OasisStore

class KeychainUtilTest: XCTestCase {

    override func tearDown() {
        KeychainUtil.shared.delete(service: .accessToken)
        KeychainUtil.shared.delete(service: .refreshToken)
        super.tearDown()
    }
    
    func test_KeychainUtil_save() {
        // When
        KeychainUtil.shared.save(service: .accessToken, secret: "value")
        
        // Then
        let value = KeychainUtil.shared.retrieve(service: .accessToken)
        XCTAssertEqual(value, "value" )
    }
    
    func test_KeychainUtil_saveRefreshToken() {
        // When
        KeychainUtil.shared.save(service: .refreshToken, secret: "value")
        
        // Then
        let value = KeychainUtil.shared.retrieve(service: .refreshToken)
        XCTAssertEqual(value, "value" )
    }
    
    func test_KeychainUtil_saveEmptyRefreshToken() {
        // When
        // Then
        let value = KeychainUtil.shared.retrieve(service: .refreshToken)
        XCTAssertNil(value, "Keychain should be nil")
    }
    
    func test_KeychainUtil_updateRefreshToken() {
        // When
        KeychainUtil.shared.save(service: .refreshToken, secret: "value")
        KeychainUtil.shared.save(service: .refreshToken, secret: "value2")
        // Then
        let value = KeychainUtil.shared.retrieve(service: .refreshToken)
        XCTAssertEqual(value, "value2" )
    }
}
