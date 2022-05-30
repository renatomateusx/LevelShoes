//
//  HomeViewController.swift
//  LevelShoesTests
//
//  Created by Renato Mateus on 29/05/22.
//

import XCTest
import UIKit
import SnapshotTesting

@testable import LevelShoes

class HomeViewControllerTestes: XCTestCase {

    var viewController: HomeViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        
        viewController = HomeViewController()
        viewController.viewModel = HomeViewModel(with: PopularProductsServiceMockSuccess())
        viewController.loadViewIfNeeded()
        
        window = UIApplication.shared.windows.first
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialState() {
        sleep(3)
        XCTAssertEqual(viewController.products.count, 3)
        XCTAssertEqual(viewController.topTitleLabel.text, "NEW IN")
        assertSnapshot(matching: viewController, as: .image(precision: 0.99))
    }

}
