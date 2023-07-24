//
//  APIRouter.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation

protocol APIRouterProtocol {
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var query: [String : String]? { get }
    var parameter: [String : Any]? { get }
}

extension APIRouterProtocol {
    
    var baseUrl: String {
        return "https://private-20516c-oasisstoreapp.apiary-mock.com"
    }
    
    var asRequest: URLRequest {
        // Default query
        let langQuery = [ URLQueryItem(name: "lang", value: "en")]
        var urlComponent = URLComponents(string: baseUrl)!
        urlComponent.queryItems = langQuery
        let url = urlComponent.url!.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        // header
        request.setValue("iOS", forHTTPHeaderField: "Platform")
        
        if let token = KeychainUtil.shared.retrieve(service: .accessToken) {
            request.setValue("Bearer " + token , forHTTPHeaderField: "Authorization")
        }
        
        // method
        request.httpMethod = method.rawValue
        
        // body
        if let parameters = parameter {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
