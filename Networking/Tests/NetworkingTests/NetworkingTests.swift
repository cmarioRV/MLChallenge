import XCTest
import Swinject
@testable import Networking
@testable import Domain

final class NetworkingTests: XCTestCase {
    func testGetSearchWithValidQueryReturnDomainModels() {
        let subject = NetworkingModule(assembly: FakeNetworkingAssembly())
        
        let assemblies = [subject.moduleAssembly]
        let _ = Assembler(assemblies, container: Container())
    
        var searchResult: [ItemDetail]?
        let expectation = expectation(description: "Return values successfully")
        subject.getSearch(query: "Med", completion: { result, error in
            searchResult = result
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.5) { error in
            XCTAssertNotNil(searchResult)
            XCTAssertEqual(searchResult?.count, 3)
        }
    }
}
