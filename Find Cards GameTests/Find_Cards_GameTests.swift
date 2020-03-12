//
//  Find_Cards_GameTests.swift
//  Find Cards GameTests
//
//  Created by nadun.eranga.baduge on 11/3/20.
//  Copyright © 2020 nadun.eranga.baduge. All rights reserved.
//

import XCTest
@testable import Find_Cards_Game

class Find_Cards_GameTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRadomizor() {
        let maximumNumber = 10
        //Check is it generating all the numbers
        var uniqueNumbers: Set<Int> = []
        repeat {
            // Range startNumber ..< maximumNumber
            let randomNumber = getRandomNumber(startNumber: 0, maximumNumber: maximumNumber)
            uniqueNumbers.insert(randomNumber)
        } while(uniqueNumbers.count < maximumNumber)
        print(uniqueNumbers)
        XCTAssertTrue(true)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
