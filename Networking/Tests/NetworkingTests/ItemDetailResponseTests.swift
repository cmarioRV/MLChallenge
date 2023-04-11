//
//  ItemDetailResponseTests.swift
//  
//
//  Created by Mario Rúa on 11/04/23.
//

import XCTest
@testable import Networking
@testable import Domain

final class ItemDetailResponseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItemDetailResponseToDomainModelMapsReputationCorrectly() {
        let subjectFive = ItemDetailResponse(title: "Item 1", imageUrlString: "http://url.com", price: 1, condition: "new", sellerReputation: "5_green")
        let subjectFour = ItemDetailResponse(title: "Item 2", imageUrlString: "http://url.com", price: 2, condition: "new", sellerReputation: "4_light_green")
        let subjectThree = ItemDetailResponse(title: "Item 3", imageUrlString: "http://url.com", price: 3, condition: "used", sellerReputation: "3_yellow")
        let subjectTwo = ItemDetailResponse(title: "Item 4", imageUrlString: "http://url.com", price: 3, condition: "used", sellerReputation: "2_orange")
        let subjectOne = ItemDetailResponse(title: "Item 5", imageUrlString: "http://url.com", price: 3, condition: "used", sellerReputation: "1_red")
     
        XCTAssertEqual(subjectFive.toDomainModel()?.sellerReputation, SellerReputation.five)
        XCTAssertEqual(subjectFour.toDomainModel()?.sellerReputation, SellerReputation.four)
        XCTAssertEqual(subjectThree.toDomainModel()?.sellerReputation, SellerReputation.three)
        XCTAssertEqual(subjectTwo.toDomainModel()?.sellerReputation, SellerReputation.two)
        XCTAssertEqual(subjectOne.toDomainModel()?.sellerReputation, SellerReputation.one)
    }
}
