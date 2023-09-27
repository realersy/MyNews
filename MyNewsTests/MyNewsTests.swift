//
//  MyNewsTests.swift
//  MyNewsTests
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import XCTest
@testable import MyNews

final class MyNewsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    //Testing whether network fetch is not empty
    func testNewsServiceNotEmpty() throws {
        let expectations = expectation(description: "exp")
        var fetchedArticles = [Article]()
        NewsService.shared.getNews { articles in
            fetchedArticles = articles
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            expectations.fulfill()
        })
        wait(for: [expectations])
        XCTAssertFalse(fetchedArticles.isEmpty)
    }
    //testing the date trimming extension
    func testStringTrim() throws {
        let date = "20-10-23T12323"
        XCTAssertEqual(date.trim(), "20-10-23")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
