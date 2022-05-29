//
//  HomeViewModelTests.swift
//  LevelShoesTests
//
//  Created by Renato Mateus on 27/05/22.
//

import XCTest

@testable import LevelShoes

class HomeViewModelTests: XCTestCase {

    typealias Completion<T> = ((_ value: T) -> Void)
    var viewModel: HomeViewModel!
    var successCompletion: Completion<Any>!
    var failureCompletion: Completion<Any>!
    lazy var serviceMockSuccess: PopularProductsServiceMockSuccess = PopularProductsServiceMockSuccess()
    lazy var serviceMockFailure: PopularProductsServiceMockFailure = PopularProductsServiceMockFailure()
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testFetchIfSuccess() {
        viewModel = HomeViewModel(with: serviceMockSuccess)
        viewModel?.delegate = self
        let expectation = XCTestExpectation.init(description: "Products Data")
        self.successCompletion = { products in
            XCTAssertNotNil(products, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData()
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testFetchPostsIfFailure() {
        viewModel = HomeViewModel(with: serviceMockFailure)
        viewModel.delegate = self
        let expectation = XCTestExpectation.init(description: "Error")
        self.failureCompletion = { error in
            XCTAssertNotNil(error, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData()
        wait(for: [expectation], timeout: 60.0)
    }
}

extension HomeViewModelTests: HomeViewModelDelegate {
    func onSuccessFetchingProducts(products: DataProducts) {
        successCompletion(products)
    }
    
    func onFailureFetchingProducts(error: Error) {
        failureCompletion(error)
    }
}
