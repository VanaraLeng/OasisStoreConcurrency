//
//  MockProductService.swift
//  OasisStoreTests
//
//  Created by Vanara Leng on 6/22/23.
//

import Foundation
import Combine
@testable import OasisStore

class MockProductService: ProductServiceProtocol {
    
    var testdata = HomeResponse(success: true,
                            data: HomeDataResponse(
                                banners: [
                                    "https://m.media-amazon.com/images/I/71tUEbgSbzL._AC_SY400_.jpg"
                                ],
                                newProducts: [
                                    Product(id: 0,
                                            name: "Alienware 34",
                                            description: "Alienware 34 Inch Monitor",
                                            imageUrl: "https://m.media-amazon.com/images/I/71tUEbgSbzL._AC_SY400_.jpg",
                                            price: 10.11,
                                            discount: 0,
                                            gallery: nil)
                                ],
                                popularProducts: [
                                    Product(id: 0,
                                            name: "Alienware 34",
                                            description: "Alienware 34 Inch Monitor",
                                            imageUrl: "https://m.media-amazon.com/images/I/71tUEbgSbzL._AC_SY400_.jpg",
                                            price: 10.11,
                                            discount: 0,
                                            gallery: nil)
                                ]))
    
    var testError : Error?
    
    init(data: HomeResponse?, error: Error? = nil) {
        if let data = data {
            self.testdata = data
        }
        
        self.testError = error
    }
    
    var homeFetchResult: Result<HomeResponse, NetworkError>!
    
    func getHomeData() -> AnyPublisher<HomeResponse, NetworkError> {
        if let error = testError {
            return Fail(error: error)
                .mapError(NetworkUtil.mapError)
                .eraseToAnyPublisher()
        }
        return Just(testdata)
            .tryMap { $0 }
            .mapError(NetworkUtil.mapError)
            .eraseToAnyPublisher()
    }
}
