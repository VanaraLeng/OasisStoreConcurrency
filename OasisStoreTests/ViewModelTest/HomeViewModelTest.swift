//
//  HomeViewModelTest.swift
//  OasisStoreTests
//
//  Created by Vanara Leng on 6/22/23.
//

import Foundation
import XCTest
import Combine
@testable import OasisStore

class HomeViewModelTest: XCTestCase {
    
    private var dataService: MockProductService!
    private var sut: HomeViewModel!
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        dataService = nil
        sut = nil
        subscriptions = []
        try super.tearDownWithError()
    }
    
    func test_HomeViewModel_fetchData_dataShouldPopulated() {
        
        dataService = MockProductService(data: nil)
        sut = HomeViewModel(dataService: dataService)
        
        let expectation = XCTestExpectation(description: "Should return products list")
        let expectation2 = XCTestExpectation(description: "Should return new product list")
        let expectation3 = XCTestExpectation(description: "Should return banner list")
        
        // When
        sut.$popularProducts
            .dropFirst()
            .sink { products in
                
                if products.count == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        sut.$banners
            .dropFirst()
            .sink { banners in
                if banners.count > 0 {
                    expectation2.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        sut.$newProducts
            .dropFirst()
            .sink { products in
                if products.count == 1 {
                    expectation3.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        sut.fetchHomeData()
        
        // Then
        wait(for: [
            expectation,
            expectation2,
            expectation3
        ],
             timeout: 1)
    }
    
    func test_HomeViewModel_fetchData_doesHandleNoConnectionErrorCorrectly() {
        // Given
        let testerror = URLError(URLError.notConnectedToInternet)
        dataService = MockProductService(data: nil, error: testerror)
        sut = HomeViewModel(dataService: dataService)

        let expectation = XCTestExpectation(description: "Error should be set")
        let expectation2  = XCTestExpectation(description: "Error text should be urlError")
        let expectation3 = XCTestExpectation(description: "ShowError should be set")
        
        // When
        sut.$errorString
            .dropFirst()
            .sink { error in
                if let _ = error {
                    expectation.fulfill()
                }
                
                if error == NetworkError.urlError(testerror).errorDescription {
                    expectation2.fulfill()
                }
                 
  
            }
            .store(in: &subscriptions)
        
        sut.$showError
            .dropFirst()
            .sink { showError in
                XCTAssertTrue(showError, "showError should be true")
                 
                expectation3.fulfill()
            }
            .store(in: &subscriptions)
        
        sut.fetchHomeData()
        
        // Then
        wait(for: [expectation, expectation2, expectation3], timeout: 1)
    }
    
    func test_HomeViewModel_fetchData_doesHandleAPIErrorCorrectly() {
        let testerror = APIError.badRequest(url: nil)
        dataService = MockProductService(data: nil, error: testerror)
        sut = HomeViewModel(dataService: dataService)
        
        // When
        
        let expectation = XCTestExpectation(description: "error should be set")
        let expectation2 = XCTestExpectation(description: "error should be badRequest errorDescription")
        let expectation3 = XCTestExpectation(description: "showError should be set")
        
        sut.$errorString
            .dropFirst()
            .sink { error in
                if let _ = error {
                    expectation.fulfill()
                }
                
                if error == APIError.badRequest(url: nil).errorDescription {
                    expectation2.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        sut.$showError
            .dropFirst()
            .sink { showError in
                XCTAssertTrue(showError, "showError should be true")
                 
                expectation3.fulfill()
            }
            .store(in: &subscriptions)
        
        sut.fetchHomeData()
        
        // Then
        wait(for: [expectation, expectation2], timeout: 1)
    }
    
    func test_HomeViewModel_fetchData_doesSetIsLoadingCorrectly() {
        dataService = MockProductService(data: nil, error: NetworkError.urlError(nil))
        sut = HomeViewModel(dataService: dataService)
        
        // When
        
        let expectation = expectation(description: "Error should be set")
        
        sut.$isLoading
            .dropFirst()
            .sink { isLoading in
                XCTAssertTrue(isLoading, "isLoading should be true")
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        sut.fetchHomeData()
        
        // Then
        wait(for: [expectation], timeout: 2)
    }
    
  
}
