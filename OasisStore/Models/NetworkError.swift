//
//  NetworkError.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/26/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case urlError(URLError?)
    case decode
    case api(APIError?)
    case unknown
    
    var errorDescription: String?  {
        switch self {
        case .urlError(let error):
            return error?.localizedDescription
            
        case .api(let error):
            return error?.localizedDescription
            
        case .decode:
            return String(localized: "error_decode")
            
        case .unknown:
            return String(localized: "error_unknown")
            
        }
    }
}

enum APIError: LocalizedError, Equatable {
    case url(url: URLError?)
    case redirectError(url: URL?)
    case badRequest(url: URL?)
    case unauthorized(url: URL?)
    case forbidden(url: URL?)
    case serverError(url: URL?)
    case unknown
    
    var errorDescription: String? {
        switch self {
            
        case .url(let url):
            return url?.localizedDescription
            
        case .badRequest(_):
            return String(localized: "error_badRequest")
        
        case .unauthorized(_):
            return String(localized: "error_session")
            
        case .forbidden(_):
            return String(localized: "error_forbidden")
        
        case .serverError(_):
            return String(localized: "error_server_error")
        
        case .redirectError(_):
            return String(localized: "error_redirect")
            
        case .unknown: return String(localized: "error_unknown")
        }
    }
    
    static func from(error: Error) {
        
    }
}
