//
//  PostTests.swift
//  ObjcTextInput
//
//  Created by Stijn Willems on 14/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import XCTest
import Faro

@testable import ObjcTextInput

class PostTests: XCTestCase {

    var jsonData: Data = Data()
    var session: FaroURLSession = FaroURLSession(backendConfiguration: BackendConfiguration(baseURL: ""))

    override func setUp() {
        super.setUp()
        jsonData = """
                [
                  {
                    "body": "b 1",
                    "id": 1,
                    "title": "",
                    "userId": 1
                  },
                  {
                    "body": "b 2",
                    "id": 2,
                    "title": "qui est esse",
                    "userId": 1
                  },
                  {
                    "id": 3,
                    "title": "title",
                    "userId": 1
                  },
                  {
                    "body": "b 3",
                    "id": 4,
                    "title": "title ",
                    "userId": 1
                  }
                ]
        """.data(using: .utf8)!

        let config = BackendConfiguration(baseURL:"http://www.google.com")
        let urlSessionConfig = URLSessionConfiguration.default

        urlSessionConfig.protocolClasses = [StubbedURLProtocol.self]

        session = FaroURLSession(backendConfiguration: config, session: URLSession(configuration:urlSessionConfig))
        RequestStub.shared = RequestStub()
    }
    
    override func tearDown() {
        jsonData = Data()
        super.tearDown()
    }
    
    func testPostArray() {
        let call = Call(path: "posts")
        call.stub(statusCode: 200, data: jsonData)

        let expectation = XCTestExpectation(description: "")

        let service = Service(call: call, session: session)

        service.perform([Post].self) { (done) in

            let posts = try? done()

            XCTAssertEqual(posts?.count, 4)
            XCTAssertEqual(posts!.map {$0.id}, [1,2,3,4])
            XCTAssertEqual(posts!.map {$0.message ?? "nothing"}, ["b 1","b 2", "nothing", "b 3"])


            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    

    
}
