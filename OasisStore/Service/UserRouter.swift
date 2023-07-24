//
//  UserRouter.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/6/23.
//

import Foundation

enum UserRouter {
    case login
    case logout
}

extension UserRouter : APIRouterProtocol {
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .logout: return .post
        }
    }
    
    var path: String {
        switch self {
        case .login: return "/login"
        case .logout: return "/logout"
        }
    }
    
    var parameter: [String : Any]? {
        return nil
    }
    
    var query: [String : String]? {
        return nil
    }
}
