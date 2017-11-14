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
            "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
            "id": 1,
            "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            "userId": 1
            },
            {
            "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla",
            "id": 2,
            "title": "qui est esse",
            "userId": 1
            },
            {
            "body": "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut",
            "id": 3,
            "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
            "userId": 1
            },
            {
            "body": "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit",
            "id": 4,
            "title": "eum et est occaecati",
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

            XCTAssertEqual(posts?.count, 40)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    

    
}
