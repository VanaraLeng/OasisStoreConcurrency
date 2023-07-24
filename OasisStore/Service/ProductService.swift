//
//  ProductService.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation
import Combine

actor ProductService: ProductServiceProtocol {
    
    func getHomeData() async throws -> HomeResponse? {
        let request = ProductRouter.home.asRequest
        return try await NetworkManager.shared.make(request: request, type: HomeResponse.self)
    }
}
