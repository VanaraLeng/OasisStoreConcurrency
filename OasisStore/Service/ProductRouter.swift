//
//  ProductRouter.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/20/23.
//

import Foundation

enum ProductRouter {
    case home
    case orders
}

extension ProductRouter : APIRouterProtocol {
    
    var method: HTTPMethod {
        switch self {
        case .home: return .get
        case .orders: return .get
        }
    }
    
    var path: String {
        switch self {
        case .home: return "/home"
        case .orders: return "/order"
        }
    }
    
    var parameter: [String : Any]? {
        return nil
    }
    
    var query: [String : String]? {
        return nil
    }
}
