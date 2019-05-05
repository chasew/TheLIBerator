//
//  The_LiberatorTests.swift
//  The LiberatorTests
//
//  Created by Chase Wooten on 4/22/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import XCTest
@testable import The_Liberator

class The_LiberatorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDoTheThing() {
        var lib = madlib(fileName: "christmasLib")
        XCTAssertEqual(19, lib.getNumBlanks())
        for i in 0...18 {
            lib.fillBlank(position: i, text: "[\(i)th rando word]")
        }
        lib.fillBlank(position: 3, text: "[I AM NEW, LET ME IN]")
        lib.fillBlank(position: 3, text: "[F]")
        lib.fillBlank(position: 18, text: "[LITERALLY]")
        print(lib.getFullText())

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
