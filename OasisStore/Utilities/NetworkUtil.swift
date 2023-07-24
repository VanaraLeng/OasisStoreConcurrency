//
//  AsyncNetworkUtil.swift
//  OasisStore
//
//  Created by Vanara Leng on 7/12/23.
//

import Foundation

actor NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func make(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleMap(data: data, response: response, url: request.url)
    }
    
    func make<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T? {
        var data: Data? = nil
        
        do {
            data = try await make(request: request)
        } catch {
            throw error
        }
        
        guard let data = data else {
            throw NetworkError.urlError(URLError(URLError.badServerResponse))
        }
        
        // Decoding
        var result: T? = nil
        
        do {
            result = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decode
        }
        
        return result
    }
    
    func handleMap(data: Data, response: URLResponse, url: URL?) throws -> Data  {
        guard let res = response as? HTTPURLResponse else {
            throw APIError.badRequest(url: url)
        }
        
        let statusCode = res.statusCode
        
        switch statusCode {
        case 200..<300:
            return data
        
        case 401:
            throw APIError.unauthorized(url: url)
            
        case 403:
            throw APIError.forbidden(url: url)
            
        case 300..<400:
            throw APIError.redirectError(url: url)
            
        case 400..<500:
            throw APIError.badRequest(url: url)
            
        case 500..<600:
            throw APIError.serverError(url: url)
            
        default:
            throw APIError.unknown
        }
    }
}
