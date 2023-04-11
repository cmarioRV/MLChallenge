//
//  ViewModelTests.swift
//  MLChallengeTests
//
//  Created by Mario Rúa on 11/04/23.
//

import XCTest
import Swinject
@testable import Networking
@testable import Domain
@testable import MLChallenge

final class ViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetSearchReturnSuccess() {
        let fakeNetworkingDependency = NetworkingModule(assembly: FakeNetworkingAssembly())
        let fakeAssemblies = [fakeNetworkingDependency.moduleAssembly]
        let _ = Assembler(fakeAssemblies, container: Container())
        
        let expectation = expectation(description: "Return search successfully")
        var itemsResult: [SearchTableViewCell.ViewModel]?
        var errorResult: Error?
        
        let subject = SearchViewModel(networkingProvider: fakeNetworkingDependency)
        
        subject.outputs.cellViewModels.bind { results in
            itemsResult = results
            expectation.fulfill()
        }
        
        subject.outputs.error.bind { error in
            errorResult = error
            expectation.fulfill()
        }
        
        subject.inputs.search(query: "Medellin")
        
        waitForExpectations(timeout: 0.5) { error in
            XCTAssertNotNil(itemsResult)
            XCTAssertEqual(itemsResult?.count, 3)
            XCTAssertNil(errorResult)
        }
    }
}
